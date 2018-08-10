//-----------------------------------------------------------------------------
// z80asm assembler
// preprocessor
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "ccdefs.h"

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

int Preproc::get_keyword()
{
	const char *YYMARKER;
	auto p0 = p;
/*!re2c
	ws* 'INCLUDE' 	{ return INCLUDE; }
	*				{ p = p0; return NONE; }
*/
}

#define PUSH(new_text)						\
			auto line = std::make_shared<Line>(cur_line.filename, cur_line.line_nr, new_text);	\
			lines.push_back(line);

#define DO_LABEL()							\
			if (true /*is_opcode(p3, p4)*/) {		\
				std::string new_text = std::string(".") + std::string(p1, p2);	\
				PUSH(new_text);				\
				p = p3;						\
				state = at_opcode;			\
				continue;					\
			}								\
			else {							\
				p = p1;						\
				state = at_opcode;			\
				continue;					\
			}

#define DO_INCLUDE() 						\
			std::string incfile(p1, p2);	\
			if (!input.push_file(incfile)) 	\
				return;						\
			state = at_end;					\
			continue;

void Preproc::parse()
{
	const char *YYMARKER, *p1, *p2, *p3, *p4, *yyt1, *yyt2, *yyt3;
	const Line& cur_line = input.cur_line();
	std::string text(cur_line.text);
	text.reserve(text.length() + YYMAXFILL);		// needed by re2c
	const char *p = text.c_str();
	enum { at_bol, at_opcode, at_end };
	
	for (int state = at_bol; *p; ) {
		if (state == at_bol) {
/*!re2c
			
			        @p1 name @p2     ws+ @p3 name @p4		{ DO_LABEL(); }
			ws* '.' @p1 name @p2     ws+ @p3 name @p4		{ DO_LABEL(); }
			ws*     @p1 name @p2 ':' ws* @p3 name @p4		{ DO_LABEL(); }
			
			pp? ws* 'INCLUDE' ws* @p1 '<' file_ab @p2 '>' 	{ DO_INCLUDE(); }
			pp? ws* 'INCLUDE' ws* @p1 "'" file_sq @p2 "'" 	{ DO_INCLUDE(); }
			pp? ws* 'INCLUDE' ws* @p1 '"' file_dq @p2 '"' 	{ DO_INCLUDE(); }
			pp? ws* 'INCLUDE' ws+ @p1     file_sp @p2     	{ DO_INCLUDE(); }
			pp? ws* 'INCLUDE' ws* 	{ err.e_syntax(input); return; }
			
			*						{ state = at_opcode; continue; }
*/
		}
		else if (state == at_opcode) {
/*!re2c 
			'INCLUDE' ws* @p1 '<' file_ab @p2 '>' 			{ DO_INCLUDE(); }
			'INCLUDE' ws* @p1 "'" file_sq @p2 "'" 			{ DO_INCLUDE(); }
			'INCLUDE' ws* @p1 '"' file_dq @p2 '"' 			{ DO_INCLUDE(); }
			'INCLUDE' ws+ @p1     file_sp @p2     			{ DO_INCLUDE(); }
			'INCLUDE' ws* 			{ err.e_syntax(input); return; }
			
			ws+ 					{ continue; }
			( ';' | "\x00" ) 		{ return; }
			* {
				std::string new_text(p);
				PUSH(new_text);
				return;
			}
*/
		}
		else /* if (state == at_end) */ {
/*!re2c 
			ws+ 					{ continue; }
			( ';' | "\x00" ) 		{ return; }
			* 						{ err.e_syntax(input); return; }
*/
		}
	}
}

