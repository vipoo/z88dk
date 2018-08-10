	ld a,1
	include 03_include_ok.inc;comment
	ld a,3
	include'03_include_ok.inc';comment
	ld a,5
	include"03_include_ok.inc";comment
	ld a,7
	include<03_include_ok.inc>;comment
	ld a,9
#include 03_include_ok.inc		;comment
	ld a,11
*include '03_include_ok.inc'	;comment
	ld a,13
%include "03_include_ok.inc"	;comment
	ld a,15
# INCLUDE <03_include_ok.inc>	;comment
	ld a,17
* INCLUDE 03_include_ok.inc	;comment
	ld a,19
% INCLUDE '03_include_ok.inc'	;comment
	ld a,21
INCLUDE 03_include_ok.inc;comment
	ld a,23
INCLUDE'03_include_ok.inc';comment
	ld a,25
INCLUDE"03_include_ok.inc";comment
	ld a,27
INCLUDE<03_include_ok.inc>;comment
	ld a,29
