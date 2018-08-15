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
use Path::Tiny;

# run tools from .
my $IS_WIN32 = $^O eq 'MSWin32';
$ENV{PATH} = ".".($IS_WIN32 ? ";" : ":").$ENV{PATH};

for my $asm (<t/preproc/*.asm>) {
	(my $base =  $asm) =~ s/\.asm$//;
	
	ok 1, "$base.asm -> $base.i";

	my $opts = -f "$base.opts" ? path("$base.opts")->slurp : ""; $opts =~ s/\s+$//;
	my $cmd = "z80asm2 -E $opts $asm >$base.out 2>$base.err";
	ok 1, $cmd;
	my $rv = system($cmd);
	
	if (-f "$base.out.exp") {
		compare("$base.out", "$base.out.exp");
	}
	else {
		ok -s "$base.out" == 0, "$base.out empty";
	}
	
	if (-f "$base.err.exp") {
		compare("$base.err", "$base.err.exp");
		ok $rv != 0, "exit failure";
	}
	else {
		ok -s "$base.err" == 0, "$base.err empty";
		compare("$base.i", "$base.i.exp");
		ok $rv == 0, "exit success";
	}
	
	if (Test::More->builder->is_passing) {
		unlink "$base.out", "$base.err", "$base.i", <$base.*.bak>;
	}
}

sub compare {
	my($got, $exp) = @_;
	my $cmd = "diff -w $exp $got";
	ok system($cmd)==0, $cmd;
}

done_testing;
