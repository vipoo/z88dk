//-----------------------------------------------------------------------------
// z80asm assembler
// preprocessor
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "preproc.h"
#include "errors.h"

/*!max:re2c*/
/*!maxnmatch:re2c*/

/*!re2c 
	re2c:define:YYCURSOR = p;
	re2c:define:YYCTYPE = char;
	re2c:yyfill:enable = 0;
	
	ws 		= [\t\v\f\r\n ];
	pp		= [#*%];
	name    = [a-zA-Z_][a-zA-Z_0-9]*;
	file_ab = [^>\x00\t\v\f\r\n;]+;
	file_sq = [^'\x00\t\v\f\r\n;]+;
	file_dq = [^"\x00\t\v\f\r\n;]+;
	file_sp = [^ \x00\t\v\f\r\n;]+;
*/

void Preproc::init_scan(const std::string & text_)
{
	text = text_;
	text.reserve(text.length() + YYMAXFILL);
	p = text.c_str();
}

int Preproc::is_keyword()
{
	const char *YYMARKER;
	auto p0 = p;
/*!re2c
	ws* 'INCLUDE' 	{ return INCLUDE; }
	*				{ p = p0; return NONE; }
*/
}

std::string Preproc::is_label()
{
	const char *YYMARKER, *p1, *p2, *yyt1, *yyt2;
	auto p0 = p;
/*!re2c
	        @p1 name @p2 ws+	{ 
				if (is_keyword() != NONE) {		// column-1 name followed by keyword
					p = p2;						// go back to before keyword
					return std::string(p1, p2);
				}
				else {
					p = p0; return std::string();
				}				    
			}
	ws*     @p1 name @p2 ':' 	{ return std::string(p1, p2); }
	ws* '.' @p1 name @p2 		{ return std::string(p1, p2); }
	*							{ p = p0; return std::string(); }
*/
}

std::string Preproc::get_include_filename()
{
	const char *YYMARKER, *p1, *p2, *yyt1, *yyt2;
	auto p0 = p;
	
/*!re2c
	ws* '<'     file_ab 		{ err.e_syntax(*this); return std::string(); }
	ws* '<' @p1 file_ab @p2 '>'	{ return std::string(p1, p2); }
	
	ws* "'"     file_sq 		{ err.e_syntax(*this); return std::string(); }
	ws* "'" @p1 file_sq @p2 "'"	{ return std::string(p1, p2); }

	ws* '"'     file_dq 		{ err.e_syntax(*this); return std::string(); }
	ws* '"' @p1 file_dq @p2 '"'	{ return std::string(p1, p2); }
	
	ws+     @p1 file_sp @p2		{ return std::string(p1, p2); }
	
	*							{ p = p0; err.e_syntax(*this); return std::string(); }
*/
}
