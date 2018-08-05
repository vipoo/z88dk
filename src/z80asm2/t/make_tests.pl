#!/usr/bin/perl

#------------------------------------------------------------------------------
# z80asm unit tests
# Copyright (C) Paulo Custodio, 2011-20180
# License: http://www.perlfoundation.org/artistic_license_2_0
#------------------------------------------------------------------------------

open(my $f, ">:raw", "t/test.def") or die $!;
@ARGV = <t/*.cpp>;
while (<>) {
    /^\s*void\s+(test_\w*)\s*\(\s*\)/ and print $f "DIAG(\"$1\"); void $1(); $1();\n";
}
