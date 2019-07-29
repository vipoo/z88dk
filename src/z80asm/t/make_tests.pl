#!/usr/bin/perl

use Modern::Perl;

open(my $f, ">:raw", "t/test.def") or die $!;

@ARGV = <t/t_*.c>;
if (@ARGV) {
	while (<>) {
		if (/^ \s* void \s+ (test_\w*) \s* \( \s* \) /x) {
			print $f <<"END";
#if !EXEC_TEST
DIAG("$1");
extern void $1();
$1();
#endif

END
		}
		elsif (/^ \s* int \s+ (exec_\w*) \s* \( \s* \) /x) {
			print $f <<"END";
#if EXEC_TEST
if (strcmp(test, "$1") == 0) {
    extern int $1();
    int rv = $1();
    exit(rv);
}
#endif

END
		}
    }
}
