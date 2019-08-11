#!/usr/bin/perl

use Modern::Perl;

open(my $f, ">:raw", "t/test.def") or die $!;

@ARGV = <t/t_*.c>;
if (@ARGV) {
	my $decl = "";
	my $run = "";
	my $exec = "";
	
	while (<>) {
		if (/^ void \s+ (test_\w*) \s* \( \s* void \s* \) /x) {
			$decl .= "void $1(void);\n";
			$run .= "DIAG(\"$1\"); $1();\n";
		}
		elsif (/^ int \s+ (exec_\w*) \s* \( \s* void \s* \) /x) {
			$decl .= "int  $1(void);\n";
			$exec .= "if (strcmp(name, \"$1\")==0) { int rv = $1(); exit(rv); }\n";
		}
		elsif (/^ int \s+ (exec_\w*) \s* \( \s* int \s+ \w+ \s* \) /x) {
			$decl .= "int  $1(int);\n";
			$exec .= "if (strcmp(name, \"$1\")==0) { int rv = $1(arg); exit(rv); }\n";
		}
		else {
			print "skipped: $_" if /^(void|int)/;
		}
		}
			print $f <<"END";
$decl
#if EXEC_TEST
$exec
#else
$run
#endif
#undef EXEC_TEST
END
}
