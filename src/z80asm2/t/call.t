#!perl
#------------------------------------------------------------------------------
# z80asm unit tests
# Copyright (C) Paulo Custodio, 2011-2018
# License: http://www.perlfoundation.org/artistic_license_2_0
#------------------------------------------------------------------------------

use strict;
use warnings;
use v5.10;
use Test::More;
use Capture::Tiny 'capture';
use Path::Tiny;

# run tools from .
my $IS_WIN32 = $^O eq 'MSWin32';
$ENV{PATH} = ".".($IS_WIN32 ? ";" : ":").$ENV{PATH};

my($cmd, $out, $err, $rv);

$cmd = "z80asm2 -v";
ok 1, $cmd;
($out, $err, $rv) = capture{system $cmd};
is $out, <<END;
Usage: z80asm2 [options] [files]
Options:
  -E    preprocess
  -Idir add directory to include path
  -v    verbose
END
is $err, '';
is $rv, 0;

done_testing;
