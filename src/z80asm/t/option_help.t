#!/usr/bin/perl

# Z88DK Z80 Macro Assembler
#
# Copyright (C) Paulo Custodio, 2011-2018
# License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
# Repository: https://github.com/z88dk/z88dk/
#
# Test -h

use Modern::Perl;
use Test::More;
require './t/testlib.pl';

my $config = slurp("../config.h");
my($version) = $config =~ /Z88DK_VERSION\s*"(.*)"/;
ok $version, "version $version";

for my $opt (qw( -h --help )) {
	run("z80asm $opt", 0, <<"END", "");
Z80 Module Assembler $version
(c) InterLogic 1993-2009, Paulo Custodio 2011-2018

Usage:
  z80asm [OPTIONS...] {FILE | \@LIST}...

 Help options:
  -h, -?, --help      Show help options
  -v, --verbose       Be verbose

 Environment options:
  -I, --inc-path arg  Append to include search path
  -L, --lib-path arg  Append to library search path
  -D, --define arg    Define a symbol

 Assemble options:
  -m, --cpu arg       z80, z180, z80-zxn (ZX Next z80 variant),
                      r2k, r3k (Rabbit 2000 / 3000),
                      ti83, ti83plus (default: z80)
      --IXIY          Swap IX and IY
  -d, --update        Assemble only updated files
  -s, --symtable      Generate module symbol table
  -l, --list          Generate module list file

 Link options:
  -b, --make-bin      Assemble and link
      --split-bin     One binary file per section
      --filler arg    Filler byte for DEFS
  -r, --origin arg    Link at origin address
  -R, --relocatable   Generate relocation code
      --reloc-info    Generate relocation information
  -m, --map           Generate map file
  -g, --globaldef     Generate global definition file
      --debug         Debug info in map file

 Libraries options:
  -x, --make-lib arg  Create library
  -i, --link-lib arg  Link with library

 Output options:
  -O, --out-dir arg   Output directory
  -o, --output arg    Output file

 Appmake options:
  +zx81               Generate .p file, origin at 16514
  +zx                 Generate .tap file, origin at 23760 or
                      above Ramtop with - rORG > 24000

END

	run("z80asm $opt=x", 1, "", <<END);
Error: illegal option: $opt=x
END
}

# make sure help fist in 80 columns
ok open(my $fh, "<", __FILE__), "open ".__FILE__;
while (<$fh>) {
	next if /^\s*\#/;
	chomp;
	if (length($_) > 80) {
		ok 0, "line $. longer than 80 chars";
	}
}

unlink_testfiles();
done_testing();
