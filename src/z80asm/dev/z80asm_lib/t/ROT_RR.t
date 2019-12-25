#------------------------------------------------------------------------------
# z80asm assembler
# Test z80asm-*.lib
# Copyright (C) Paulo Custodio, 2011-2020
# License: http://www.perlfoundation.org/artistic_license_2_0
# Repository: https://github.com/z88dk/z88dk
#------------------------------------------------------------------------------

use Modern::Perl;
use Test::More;
use Path::Tiny;
require '../../t/testlib.pl';

my @CPUS = (qw( 8080 8085 gbz80 r2k z180 z80 z80n ));

my $test_nr;

for my $op (qw( rlc rrc rl rr sla sra srl )) {
    for my $cpu (@CPUS) {
        for my $reg (qw( BC DE HL )) {
            for my $carry (0, 1) {
                for my $init (0, 0x1111, 0x2222, 0x8888) {
                    $test_nr++;
                    note "Test $test_nr: op:$op cpu:$cpu reg:$reg carry:$carry init:$init";
                    my $init_carry = $carry ? "scf" : "and a";
                    my $r = ticks(<<END, "-m$cpu");
                            ld		$reg, $init
                            $init_carry 
                            $op     $reg
                            rst     0
END
                    if ($op eq 'rlc') { 
                        is $r->{F_C}, ($init & 0x8000) ? 1 : 0, "carry";
                        my $res = (($init << 1) & 0xffff) | (($init >> 15) & 1);
                        is $r->{$reg}, $res, "result";
                    }
                    elsif ($op eq 'rrc') { 
                        is $r->{F_C}, ($init & 1) ? 1 : 0, "carry";
                        my $res = ($init >> 1) | (($init & 1) << 15);
                        is $r->{$reg}, $res, "result";
                    }
                    elsif ($op eq 'rl') { 
                        is $r->{F_C}, ($init & 0x8000) ? 1 : 0, "carry";
                        my $res = (($init << 1) & 0xffff) | $carry;
                        is $r->{$reg}, $res, "result";
                    }
                    elsif ($op eq 'rr') { 
                        is $r->{F_C}, ($init & 1) ? 1 : 0, "carry";
                        my $res = (($init >> 1) & 0xffff) | ($carry << 15);
                        is $r->{$reg}, $res, "result";
                    }
                    elsif ($op eq 'sla') { 
                        is $r->{F_C}, ($init & 0x8000) ? 1 : 0, "carry";
                        my $res = (($init << 1) & 0xffff);
                        is $r->{$reg}, $res, "result";
                    }
                    elsif ($op eq 'sra') { 
                        is $r->{F_C}, ($init & 1) ? 1 : 0, "carry";
                        my $res = ($init & 0x8000)|($init >> 1);
                        is $r->{$reg}, $res, "result";
                    }
                    elsif ($op eq 'srl') { 
                        is $r->{F_C}, ($init & 1) ? 1 : 0, "carry";
                        my $res = ($init >> 1);
                        is $r->{$reg}, $res, "result";
                    }
                    else {
                        die;
                    }
                            
                    (Test::More->builder->is_passing) or die;
                }
			}
		}
	}
}

unlink_testfiles();
done_testing();
