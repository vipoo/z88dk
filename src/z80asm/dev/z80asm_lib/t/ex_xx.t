#------------------------------------------------------------------------------
# z80asm assembler
# Test z80asm-*.lib
# Copyright (C) Paulo Custodio, 2011-2020
# License: http://www.perlfoundation.org/artistic_license_2_0
# Repository: https://github.com/z88dk/z88dk
#------------------------------------------------------------------------------

use Modern::Perl;
use Test::More;
require '../../t/testlib.pl';

my @CPUS = (qw( 8080 gbz80 r2k z180 z80 ));
my $test_nr;

for my $cpu (@CPUS) {
    my @REGS = ($cpu eq '8080')     ? (split(" ", " bc de hl                   ")) :
               ($cpu eq 'gbz80')    ? (split(" ", " bc de hl                   ")) :
               ($cpu eq 'r2k')      ? (split(" ", " bc de hl bc' de' hl' ix iy ")) :
               ($cpu eq 'z180')     ? (split(" ", " bc de hl bc' de' hl' ix iy ")) :
               ($cpu eq 'z80')      ? (split(" ", " bc de hl bc' de' hl' ix iy ")) : die;
    for my $r1 (@REGS) {
        my $r1_main = substr($r1, 0, 2);
        my $r1_exx = $r1 =~ /\'/ ? "exx" : "";
        for my $r2 (@REGS) {
            my $r2_main = substr($r2, 0, 2);
            my $r2_exx = $r2 =~ /\'/ ? "exx" : "";
            next if $r1 eq $r2;
            $test_nr++;
            ok 1, "Test $test_nr: cpu:$cpu op: ex $r1, $r2";

            my $r = ticks(<<END, "-m$cpu");
                        ; $cpu : ex $r1, $r2
                        jp start                ; skip data
                        defs 0x100
            start:
                        ld hl, 0xffff           ; reset data
                        ld sp, 8
                        push hl                 ; gbz80 does not have ld (nn), hl
                        push hl
                        push hl
                        push hl
                        ld sp, 8
                        
                        ld $r1, 1
                        $r1_exx
                        push $r1_main           ; 6 = initial r1
                        $r1_exx
                        
                        ld $r2, 2
                        $r2_exx
                        push $r2_main           ; 4 = initial r2
                        $r2_exx
                        
                        ex $r1, $r2
                        
                        $r1_exx
                        push $r1_main           ; 2 = final r1
                        $r1_exx
                        
                        $r2_exx
                        push $r2_main           ; 0 = final r2
                        $r2_exx
                        
                        jp 0
END
            my $ok = ($r->{mem}[7] == 0 && $r->{mem}[6] == 1);
            ok $ok, "initial $r1" if $ENV{DEBUG} || !$ok;
            
            $ok = ($r->{mem}[5] == 0 && $r->{mem}[4] == 2);
            ok $ok, "initial $r2" if $ENV{DEBUG} || !$ok;

            $ok = ($r->{mem}[3] == 0 && $r->{mem}[2] == 2);
            ok $ok, "final $r1" if $ENV{DEBUG} || !$ok;

            $ok = ($r->{mem}[1] == 0 && $r->{mem}[0] == 1);
            ok $ok, "final $r2" if $ENV{DEBUG} || !$ok;

            (Test::More->builder->is_passing) or die;
        }
    }
}

unlink_testfiles();
done_testing();
