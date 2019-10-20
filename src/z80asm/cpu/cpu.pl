#!/usr/bin/perl

#------------------------------------------------------------------------------
# z80asm assembler
# Generate test code and parsing tables for the cpus supported by z80asm
# Copyright (C) Paulo Custodio, 2011-2019
# License: http://www.perlfoundation.org/artistic_license_2_0
# Repository: https://github.com/z88dk/z88dk
#------------------------------------------------------------------------------

use Modern::Perl;
use Path::Tiny;
use Text::Table;
use Clone qw( clone );
use Data::Dump 'dump';
use warnings FATAL => 'uninitialized'; 

#------------------------------------------------------------------------------
# Globals
#------------------------------------------------------------------------------
our @CPUS = sort qw( 8080 8085 gbz80 r2k r3k z180 z80 z80n );
our %CPU_I; for (0 .. $#CPUS) { $CPU_I{$CPUS[$_]} = $_; }
our $cpu = 'z80';
our $ixiy;

#------------------------------------------------------------------------------
# $Opcodes{$asm}{$cpu} = [\@ops, \@ticks]; @ops = (\@bytes_op1, \@bytes_op2, ...)
# %n	unsigned byte
# %d  	8-bit unsigned offset in ix|iy indirect addressing
# %s  	8-bit signed offset
# %n  	8-bit unsigned offset
# %m	16-bit value
# %c	constant
our %Opcodes;		# $Opcodes{$asm}{$cpu} = Instr

#------------------------------------------------------------------------------
my $table_separator = "|";

#------------------------------------------------------------------------------
# Predicates
#------------------------------------------------------------------------------
sub is_8080() 		{ return $cpu eq '8080'; }
sub is_8085() 		{ return $cpu eq '8085'; }
sub is_intel() 		{ return is_8080() || is_8085(); }
sub is_gameboy()	{ return $cpu eq 'gbz80'; }
sub is_z80()		{ return $cpu eq 'z80'; }
sub is_z80n() 		{ return $cpu eq 'z80n'; }
sub is_z180() 		{ return $cpu eq 'z180'; }
sub is_zilog() 		{ return is_z80() || is_z80n() || is_z180(); }
sub is_r2k()		{ return $cpu eq 'r2k'; }
sub is_r3k()		{ return $cpu eq 'r3k'; }
sub is_rabbit()		{ return is_r2k() || is_r3k(); }

sub ixiy_asm_flag 	{ return $ixiy ? "--IXIY " : ""; }

#------------------------------------------------------------------------------
# Assembly instruction
#------------------------------------------------------------------------------
{
	package Instr;
	use Modern::Perl;
	use Clone 'clone';
	use Object::Tiny::RW qw( asm bytes ticks args asmpc );
	
	sub new {
		my($class, $asm, $bytes, $ticks, %args) = @_;
		
		# normalize input
		$bytes = [$bytes] if !ref($bytes);
		ref($bytes) eq 'ARRAY' or die;
		
		$ticks = [$ticks] if !ref($ticks);
		ref($ticks) eq 'ARRAY' or die;
		my @ticks = @$ticks;
		@ticks==1 and push @ticks, $ticks[0];
		@ticks==2 or die;
		
		return bless { 
			asm => $asm, bytes => $bytes, ticks => \@ticks, 
			args => \%args, asmpc => 0}, $class;
	}
	
	sub format_bytes {
		my($self) = @_;
		my @bytes = @{$self->bytes};
		for (@bytes) {
			s/(\d+)/ sprintf("%02X", $_) /ge;
		}
		return join(' ', @bytes);
	}
}

#------------------------------------------------------------------------------
# Assembly code
#------------------------------------------------------------------------------
{
	package Prog;
	use Modern::Perl;
	use Object::Tiny::RW qw( prog );
	
	sub new {
		my($class, @prog) = @_;
		my $self = bless { prog => [] }, $class;
		$self->add($_) for @prog;
		return $self;
	}
	
	sub add {
		my($self, @prog) = @_;
		push @{$self->prog}, $_ for @prog;
	}
	
	sub asm {
		my($self) = @_;
		my @asm;
		for my $instr (@{$self->prog}) {
			push @asm, $instr->asm;
		}
		return join("\n", @asm);
	}
	
	sub bytes {
		my($self) = @_;
		my @bytes;
		for my $instr (@{$self->prog}) {
			push @bytes, @{$instr->bytes};
		}
		return \@bytes;
	}
	
	sub ticks {
		my($self) = @_;
		my @ticks = (0, 0);
		for my $instr (@{$self->prog}) {
			$ticks[0] += $instr->ticks->[0];
			$ticks[1] += $instr->ticks->[1];
		}
		return \@ticks;
	}
	
	sub format_bytes {
		my($self) = @_;
		my @bytes;
		for my $instr (@{$self->prog}) {
			push @bytes, $instr->format_bytes;
		}
		return join('; ', @bytes);
	}
}

#------------------------------------------------------------------------------
# Opcodes
#------------------------------------------------------------------------------

my %R = (b => 0, c => 1, d => 2, e => 3, h => 4, l => 5, '(hl)' => 6, f => 6, m => 6, a => 7);
sub R($)		{ return $R{$_[0]}; }

my %F = (nz => 0, z => 1, nc => 2, c => 3, po => 4, pe => 5, p => 6, m => 7);
sub F($)		{ return $F{$_[0]}; }

my %RP = (b => 0, bc => 0, d => 1, de => 1, h => 2, hl => 2, sp => 3, af => 3, psw => 3);
sub RP($)		{ return $RP{$_[0]}; }

my %P = (ix => 0xDD, iy => 0xFD);
sub P($)		{ return $P{$_[0]}; }

my %OP = (add => 0, adc => 1, sub => 2, sbc => 3, and => 4, xor => 5, or  => 6, cp  => 7,
										sbb => 3, ana => 4, xra => 5, ora => 6, cmp => 7,
		  adi => 0, aci => 1, sui => 2, sbi => 3, ani => 4, xri => 5, ori => 6, cpi => 7,
		  rlca=> 0, rrca=> 1, rla => 2, rra => 3,
		  rlc => 0, rrc => 1, ral => 2, rar => 3);
sub OP($)		{ return $OP{$_[0]}; }

#------------------------------------------------------------------------------
sub init_opcodes {
	for $cpu (@CPUS) {
		next unless $cpu =~ /8080|8085/;

		#----------------------------------------------------------------------
		# simple opcodes

		# data transfer group
		for my $r1 (qw( b c d e h l a )) {
			for my $r2 (qw( b c d e h l a )) {
				next if $cpu eq 'r3k' && "$r1,$r2" eq "e,e";
				add("ld  $r1, $r2", 0x40+R($r1)*8+R($r2), is_8080 ? 5 : is_rabbit ? 2 : 4);
				add("mov $r1, $r2", 0x40+R($r1)*8+R($r2), is_8080 ? 5 : is_rabbit ? 2 : 4);
			}
		}

		for my $r (qw( b c d e h l a )) {
			add("ld  $r, (hl)", 0x40+R($r)*8+6, is_intel ? 7 : die);
			add("mov $r, m", 	0x40+R($r)*8+6, is_intel ? 7 : die);
			
			add("ld  (hl), $r", 0x40+6*8+R($r), is_intel ? 7 : die);
			add("mov m, $r", 	0x40+6*8+R($r), is_intel ? 7 : die);
			
			add("ld  $r, %n",	[0x00+R($r)*8+6, '%n'], is_intel ? 7 : die);
			add("mvi $r, %n",	[0x00+R($r)*8+6, '%n'], is_intel ? 7 : die);
		}
			
		add("ld  (hl), %n",		[0x00+6*8+6, '%n'], is_intel ? 10 : die);
		add("mvi m, %n",		[0x00+6*8+6, '%n'], is_intel ? 10 : die);
	
		for my $r (qw( b bc d de h hl sp )) {
			add("lxi $r, %m",	[0x01+RP($r)*16, '%m', '%m'], is_intel ? 10 : die);
		}
		for my $r (qw( bc de hl sp )) {
			add("ld $r, %m",	[0x01+RP($r)*16, '%m', '%m'], is_intel ? 10 : die);
		}

		add("lda %m",			[0x3A, '%m', '%m'], is_intel ? 13 : die);
		add("ld a, (%m)",		[0x3A, '%m', '%m'], is_intel ? 13 : die);
		
		add("sta %m",			[0x32, '%m', '%m'], is_intel ? 13 : die);
		add("ld (%m), a",		[0x32, '%m', '%m'], is_intel ? 13 : die);
		
		add("lhld %m",			[0x2A, '%m', '%m'], is_intel ? 16 : die);
		add("ld hl, (%m)",		[0x2A, '%m', '%m'], is_intel ? 16 : die);
		
		add("shld %m",			[0x22, '%m', '%m'], is_intel ? 16 : die);
		add("ld (%m), hl",		[0x22, '%m', '%m'], is_intel ? 16 : die);
		
		for my $r (qw( b bc d de )) {
			add("ldax $r",		[0x0A+RP($r)*16], is_intel ? 7 : die);
			add("stax $r",		[0x02+RP($r)*16], is_intel ? 7 : die);
		}
		for my $r (qw( bc de )) {
			add("ld a, ($r)",	0x0A+RP($r)*16, is_intel ? 7 : die);
			add("ld ($r), a",	0x02+RP($r)*16, is_intel ? 7 : die);
		}

		add("xchg",				0xEB, is_intel ? 4 : die);
		add("ex de, hl",		0xEB, is_intel ? 4 : die);

		add("xthl",				0xE3, is_8080 ? 18 : is_8085 ? 16 : die);
		add("ex (sp), hl",		0xE3, is_8080 ? 18 : is_8085 ? 16 : die);

		add("sphl",				0xF9, is_8080 ? 5 : is_8085 ? 6 : die);
		add("ld sp, hl",		0xF9, is_8080 ? 5 : is_8085 ? 6 : die);

		# Zilog
		for my $op (qw( add adc sub sbc and xor or  cp  )) {
			next if $op eq 'cp' && is_intel;	# CP is Call Positive in Intel
			for my $r (qw( b c d e h l a )) {
				add("$op a, $r",0x80+OP($op)*8+R($r), is_intel ? 4 : die);
				add("$op $r", 	0x80+OP($op)*8+R($r), is_intel ? 4 : die);
			}
			add("$op a, (hl)", 	0x80+OP($op)*8+6, is_intel ? 7 : die);
			add("$op (hl)", 	0x80+OP($op)*8+6, is_intel ? 7 : die);

			add("$op a, %n", 	[0xC6+OP($op)*8, '%n'], is_intel ? 7 : die);
			add("$op %n", 		[0xC6+OP($op)*8, '%n'], is_intel ? 7 : die);
		}
		
		# Intel
		for my $op (qw( add adc sub sbb ana xra ora cmp )) {	
			for my $r (qw( b c d e h l a )) {
				add("$op $r", 	0x80+OP($op)*8+R($r), is_intel ? 4 : die) unless $op =~ /add|adc|sub/; # already done in Zilog
			}
			add("$op m", 		0x80+OP($op)*8+6, is_intel ? 7 : die);
		}
		
		for my $op (qw( adi aci sui sbi ani xri ori cpi )) {
			add("$op %n", 		[0xC6+OP($op)*8, '%n'], is_intel ? 7 : die);
		}
			
		for my $r (qw( b c d e h l a )) {
			add("inr $r", 		0x04+R($r)*8, is_8080 ? 5 : is_8085 ? 4 : die);
			add("inc $r", 		0x04+R($r)*8, is_8080 ? 5 : is_8085 ? 4 : die);

			add("dcr $r", 		0x05+R($r)*8, is_8080 ? 5 : is_8085 ? 4 : die);
			add("dec $r", 		0x05+R($r)*8, is_8080 ? 5 : is_8085 ? 4 : die);
		}

		add("inr m", 			0x04+6*8, is_intel ? 10 : die);
		add("inc (hl)", 		0x04+6*8, is_intel ? 10 : die);

		add("dcr m", 			0x05+6*8, is_intel ? 10 : die);
		add("dec (hl)", 		0x05+6*8, is_intel ? 10 : die);

		for my $r (qw( b bc d de h hl sp )) {
			add("inx $r",		0x03+RP($r)*16, is_8080 ? 5 : is_8085 ? 6 : die);
			add("dcx $r",		0x0B+RP($r)*16, is_8080 ? 5 : is_8085 ? 6 : die);
			add("dad $r",		0x09+RP($r)*16, is_intel ? 10 : die);
		}
		
		for my $r (qw( bc de hl sp )) {
			add("inc $r",		0x03+RP($r)*16, is_8080 ? 5 : is_8085 ? 6 : die);
			add("dec $r",		0x0B+RP($r)*16, is_8080 ? 5 : is_8085 ? 6 : die);
			add("add hl, $r",	0x09+RP($r)*16, is_intel ? 10 : die);
		}

		for my $op (qw( rlca rrca rla  rra
						rlc  rrc  ral  rar )) {
			add("$op",			0x07+OP($op)*8, is_intel ? 4 : die);
		}
		
		add("daa",				0x27, is_intel ? 4 : die);

		add("cpl",				0x2F, is_intel ? 4 : die);
		add("cma",				0x2F, is_intel ? 4 : die);
		
		add("scf",				0x37, is_intel ? 4 : die);
		add("stc",				0x37, is_intel ? 4 : die);
		
		add("ccf",				0x3F, is_intel ? 4 : die);
		add("cmc",				0x3F, is_intel ? 4 : die);

		add("pchl",				0xE9, is_8080 ? 5 : is_8085 ? 6 : die);
		add("jp (hl)",			0xE9, is_8080 ? 5 : is_8085 ? 6 : die);

		for my $r (qw( b bc d de h hl af psw )) {
			add("push $r",		0xC5+RP($r)*16, is_8080 ? 11 : is_8085 ? 12 : die);
			add("pop $r",		0xC1+RP($r)*16, is_intel ? 10 : die);
		}

		add("jmp %m",			[0xC3, '%m', '%m'], is_intel ? 10 : die);
		add("jp  %m",			[0xC3, '%m', '%m'], is_intel ? 10 : die) unless is_intel; # JP in Intel is Jump if Positive

		add("call %m",			[0xCD, '%m', '%m'], is_8080 ? 17 : is_8085 ? 18 : die);
		add("ret",				0xC9, is_intel ? 10 : die);

		for my $f (qw( nz z nc c po pe p m )) {
			add("j$f    %m",	[0xC2+8*F($f), '%m', '%m'], is_8080 ? 10 : is_8085 ? [7,10] : die) unless $f eq 'p' && !is_intel;
			add("jp $f, %m",	[0xC2+8*F($f), '%m', '%m'], is_8080 ? 10 : is_8085 ? [7,10] : die) unless is_intel;		# JP in Intel is Jump if Positive

			add("c$f      %m",	[0xC4+8*F($f), '%m', '%m'], is_8080 ? [11,17] : is_8085 ? [9,18] : die) unless $f eq 'p' && !is_intel;
			add("call $f, %m",	[0xC4+8*F($f), '%m', '%m'], is_8080 ? [11,17] : is_8085 ? [9,18] : die);

			add("r$f",			0xC0+8*F($f), is_8080 ? [5,11] : is_8085 ? [6,12] : die);
			add("ret $f",		0xC0+8*F($f), is_8080 ? [5,11] : is_8085 ? [6,12] : die);
		}
		
		for my $n (0..7) {
			add("rst ".($n*8),	0xC7+$n*8, is_8080 ? 11 : is_8085 ? 12 : die);
			add("rst ".($n),	0xC7+$n*8, is_8080 ? 11 : is_8085 ? 12 : die) if $n;
		}
		
		add("in (%n)",			0xDB, is_intel ? 10 : die);
		add("in a, (%n)",		0xDB, is_intel ? 10 : die);
		
		add("out (%n)",			0xD3, is_intel ? 10 : die);
		add("out (%n), a",		0xD3, is_intel ? 10 : die);

		add("ei",				0xFB, is_intel ? 4 : die);
		add("di",				0xF3, is_intel ? 4 : die);

		add("hlt",				0x76, is_8080 ? 7 : is_8085 ? 5 : die);
		add("halt",				0x76, is_8080 ? 7 : is_8085 ? 5 : die);

		add("nop", 				0x00, is_intel ? 4 : die);

		if (is_8085) {
			add("rim", 			0x20, 4);
			add("sim", 			0x30, 4);
		}
		
		#----------------------------------------------------------------------
		# compound opcodes
		
		for my $r (qw( bc de )) {
			my($rh, $rl) = split(//, $r);

			add_compound("ld a, ($r+)"	=> "ld a, ($r)", "inc $r");
			add_compound("ld ($r+), a"	=> "ld ($r), a", "inc $r");

			add_compound("ldi a, ($r)"	=> "ld a, ($r)", "inc $r");
			add_compound("ldi ($r), a"	=> "ld ($r), a", "inc $r");

			add_compound("ld a, ($r-)"	=> "ld a, ($r)", "dec $r");
			add_compound("ld ($r-), a"	=> "ld ($r), a", "dec $r");

			add_compound("ldd a, ($r)"	=> "ld a, ($r)", "dec $r");
			add_compound("ldd ($r), a"	=> "ld ($r), a", "dec $r");
			
			add_compound("ld $r, (hl)"	=> "ld $rl, (hl)", "inc hl", "ld $rh, (hl)", "dec hl");
			add_compound("ldi $r, (hl)"	=> "ld $rl, (hl)", "inc hl", "ld $rh, (hl)", "inc hl");
			add_compound("ld $r, (hl+)"	=> "ld $rl, (hl)", "inc hl", "ld $rh, (hl)", "inc hl");
			
			add_compound("ld (hl), $r"	=> "ld (hl), $rl", "inc hl", "ld (hl), $rh", "dec hl");
			add_compound("ldi (hl), $r"	=> "ld (hl), $rl", "inc hl", "ld (hl), $rh", "inc hl");
			add_compound("ld (hl+), $r"	=> "ld (hl), $rl", "inc hl", "ld (hl), $rh", "inc hl");
			
			add_compound("jp ($r)"		=> "push $r", "ret");
		}

		for my $r1 (qw( bc de hl )) {
			my($r1h, $r1l) = split(//, $r1);
			for my $r2 (qw( bc de hl )) {
				my($r2h, $r2l) = split(//, $r2);
				
				add_compound("ld $r1, $r2"	=> "ld $r1h, $r2h", "ld $r1l, $r2l");
			}
		}

		for my $r (qw( b c d e h l a )) {
			add_compound("ld $r, (hl+)"	=> "ld $r, (hl)", "inc hl");
			add_compound("ldi $r, (hl)"	=> "ld $r, (hl)", "inc hl");
			
			add_compound("ld $r, (hl-)"	=> "ld $r, (hl)", "dec hl");
			add_compound("ldd $r, (hl)"	=> "ld $r, (hl)", "dec hl");
		}
		
		add_compound("ld (hl+), %n"		=> "ld (hl), %n", "inc hl");
		add_compound("ldi (hl), %n"		=> "ld (hl), %n", "inc hl");

		add_compound("ld (hl-), %n"		=> "ld (hl), %n", "dec hl");
		add_compound("ldd (hl), %n"		=> "ld (hl), %n", "dec hl");

		add_compound("inc (hl+)"		=> "inc (hl)", "inc hl");
		add_compound("inc (hl-)"		=> "inc (hl)", "dec hl");

		add_compound("dec (hl+)"		=> "dec (hl)", "inc hl");
		add_compound("dec (hl-)"		=> "dec (hl)", "dec hl");
		
		for my $op (qw( add adc sub sbc and xor or  cp  )) {
			next if $op eq 'cp' && is_intel;	# CP is Call Positive in Intel
			add_compound("$op a, (hl+)"	=> "$op a, (hl)", "inc hl");
			add_compound("$op    (hl+)"	=> "$op a, (hl)", "inc hl");
			
			add_compound("$op a, (hl-)"	=> "$op a, (hl)", "dec hl");
			add_compound("$op    (hl-)"	=> "$op a, (hl)", "dec hl");
		}
	}
}

#------------------------------------------------------------------------------
sub _add_prog {
	my($asm) = @_;
	$asm =~ s/\s+/ /g;
	
	$Opcodes{$asm}{$cpu} and die;
	my $prog = Prog->new;
	$Opcodes{$asm}{$cpu} = $prog;
	
	return $prog;
}

#------------------------------------------------------------------------------
sub add {
	my($asm, $bytes, $ticks) = @_;
	my $prog = _add_prog($asm);
	$prog->add(Instr->new($asm, $bytes, $ticks));
}

#------------------------------------------------------------------------------
sub add_compound {
	my($asm, @prog) = @_;
	my $prog = _add_prog($asm);
	for my $asm1 (@prog) {
		my $prog1 = $Opcodes{$asm1}{$cpu} or die;
		$prog->add(clone($prog1));
	}
}

#------------------------------------------------------------------------------
sub write_opcodes {
	write_opcodes_1();
	write_opcodes_by_asm();
}

#------------------------------------------------------------------------------
sub write_opcodes_1 {
	my $tb = Text::Table->new("; Assembly", \$table_separator, "CPU", \$table_separator, "Bytes", \$table_separator, "T-States");
	
	for my $asm (sort keys %Opcodes) {
		for $cpu (sort keys %{$Opcodes{$asm}}) {
			my $prog = $Opcodes{$asm}{$cpu};

			my @row;
			push @row, format_asm($asm);
			push @row, $cpu;
			push @row, $prog->format_bytes;
			push @row, format_ticks($prog->ticks);
			
			$tb->add(@row);
		}
	}
	
	my $file = path(path($0)->dirname, "opcodes.csv");
	$file->spew_raw($tb->table);
}

#------------------------------------------------------------------------------
sub write_opcodes_by_asm {
	# build table with assembly per cpu
	my %by_bytes;
	
	# build title and collect cpu column numbers
	my %cpu_column;
	my $column;

	my @title = ("; Assembly");
	for (@CPUS) { 
		push @title, \$table_separator, $_;
	}
		
	my $tb = Text::Table->new(@title);
	
	for my $asm (sort keys %Opcodes) {
		my $f_asm = format_asm($asm);
		my @row_bytes 		= ($f_asm, (" ") x ($tb->n_cols - 1));
		my @row_t_states 	= ((" ") x ($tb->n_cols));
		for $cpu (sort keys %{$Opcodes{$asm}}) {
			my $prog = $Opcodes{$asm}{$cpu};
			$column = 1 + $CPU_I{$cpu};
			
			my $f_bytes = $prog->format_bytes;
			$row_bytes[$column] 	= $f_bytes;
			$row_t_states[$column] 	= format_ticks($prog->ticks);

			# save for later
			$by_bytes{$f_bytes}{$cpu} .= "\n" if $by_bytes{$f_bytes}{$cpu};
			$by_bytes{$f_bytes}{$cpu} .= $f_asm;
			
		}
		$tb->add(span_cells(@row_bytes));
		$tb->add(span_cells(@row_t_states));
		$tb->add((" ") x $tb->n_cols);
	}
	
	my $file = path(path($0)->dirname, "opcodes_by_asm.csv");
	$file->spew_raw($tb->table);
	
	# build table with opcodes per CPU
	$title[0] = ";Bytes";
	$tb = Text::Table->new(@title);
	for my $bytes (sort keys %by_bytes) {
		my @row = ($bytes, (" ") x ($tb->n_cols - 1));
		for $cpu (keys %{$by_bytes{$bytes}}) {
			$column = 1 + $CPU_I{$cpu};
			$row[$column] = $by_bytes{$bytes}{$cpu};
		}
		$tb->add(span_cells(@row));
		$tb->add((" ") x $tb->n_cols);
	}

	$file = path(path($0)->dirname, "opcodes_by_bytes.csv");
	$file->spew_raw($tb->table);
}

#------------------------------------------------------------------------------
sub format_asm {
	my($asm) = @_;
	$asm =~ s/^(((altd|ioi|ioe)\s+)*\w+\s*)/ sprintf("%-4s ", $1) /e;
	return $asm;
}

#------------------------------------------------------------------------------
sub format_ticks {
	my($ticks) = @_;
	my @ticks = @$ticks;
	@ticks==2 or die;
	pop @ticks if $ticks[1]==$ticks[0];
	return sprintf("%5s T", join('/', @ticks));
}

#------------------------------------------------------------------------------
sub span_cells {
	my(@row) = @_;
	
	for my $i (1 .. $#row - 1) {
		for my $j ($i + 1 .. $#row) {
			last if $row[$i] =~ /^\s*$/;
			last if $row[$i] ne $row[$j];
			$row[$j] = "~";
		}
	}

	return @row;
}

#------------------------------------------------------------------------------
# main
#------------------------------------------------------------------------------
init_opcodes();
#dump \%Opcodes;
write_opcodes();
