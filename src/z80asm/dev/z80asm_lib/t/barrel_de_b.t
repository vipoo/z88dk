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

my @CPUS = (qw( 8080 8085 gbz80 z80 r2k z80n ));

my $test_nr;

for my $cpu (@CPUS) {
    for my $op (qw( bsla bsra bsrl bsrf brlc )) {
        for my $carry (0, 1) {
            for my $init (0, 0x1234, 0xaaaa) {
                for my $shift (0, 1, 8, 15, 16, 31, 32) {
                    $test_nr++;
                    note "Test $test_nr: cpu:$cpu carry:$carry: $op $init, $shift";
                    my $init_carry = $carry ? "scf" : "and a";
                    my $r = ticks(<<END, "-m$cpu");
                            ld      hl, 1234
                            ld      c, 12
                            ld      a, 34
                            ld      de, $init
                            ld      b, $shift    
                            $init_carry 
                            $op     de, b
                            rst     0
END
                    my $count = ($op =~ /bsla|bsra|bsrl|bsrf/) ? 
                                    ($shift & 0x1f) : ($shift & 0x0f);
                    my $res = $init;
                    for (1..$count) {
                        if    ($op eq 'bsla') { $res <<= 1; }
                        elsif ($op eq 'bsra') { $res = ($res & 0x8000) | ($res >> 1); }
                        elsif ($op eq 'bsrl') { $res = ($res >> 1); }
                        elsif ($op eq 'bsrf') { $res = ($res >> 1)|0x8000; }
                        elsif ($op eq 'brlc') { $res = (($res << 1)&0xffff)|(($res >> 15)&1); }
                    }
                    
                    is $r->{F_C}, $carry, "carry";
                    is $r->{DE}, ($res & 0xffff), "result";
                    is $r->{HL}, 1234, "hl unchanged";
                    is $r->{B}, $shift, "b unchanged";
                    is $r->{C}, 12, "c unchanged";
                    is $r->{A}, 34, "a unchanged";
                            
                    (Test::More->builder->is_passing) or die;
                }
            }
        }
    }
}

unlink_testfiles();
done_testing();
