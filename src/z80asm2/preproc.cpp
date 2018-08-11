//-----------------------------------------------------------------------------
// z80asm assembler
// preprocessor
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "ccdefs.h"

// scanner
#define WS           '\t': case '\v': case '\f': case '\r': case '\n': case ' '
#define ALPHA        'a': case 'b': case 'c': case 'd': case 'e': case 'f': case 'g': case 'h': \
                case 'i': case 'j': case 'k': case 'l': case 'm': case 'n': case 'o': case 'p': \
                case 'q': case 'r': case 's': case 't': case 'u': case 'v': case 'w': case 'x': \
                case 'y': case 'z': \
                case 'A': case 'B': case 'C': case 'D': case 'E': case 'F': case 'G': case 'H': \
                case 'I': case 'J': case 'K': case 'L': case 'M': case 'N': case 'O': case 'P': \
                case 'Q': case 'R': case 'S': case 'T': case 'U': case 'V': case 'W': case 'X': \
                case 'Y': case 'Z'

Preproc::~Preproc()
{
    lines.clear();
}

void Preproc::process(const std::string& filename)
{
    if (!input.push_file(filename))         // exit if file could not be opened
        return;

    while (input.getline()) {
        auto cur_line = input.cur_line();
        init_scan(cur_line.text);

        if (!parse_line()) {
            auto line = std::make_shared<Line>(cur_line.filename, cur_line.line_nr,
                                               cur_line.text);
            lines.push_back(line);
        }
    }

    input.pop();
}

void Preproc::do_process(const std::string& asm_filename)
{
    Preproc pp;

    int initial_errors = err.count;
    std::string i_filename = replace_extension(asm_filename, ".i");
    pp.process(asm_filename);

    if (err.count == initial_errors) {              // no parse error in this file

        std::ofstream ofs(i_filename);

        if (!ofs.good()) {
            err.e_write_file(pp.input, i_filename);
            return;
        }

        Line out;

        for (const auto& it : pp.lines) {
            // send out LINE if lines not in sync
            // can compare pointers as these are Atom
            if (out.filename != it->filename || out.line_nr != it->line_nr) {
                ofs << "LINE " << it->line_nr << ", \"" << it->filename << "\"" << std::endl;
                out.filename = it->filename;
                out.line_nr = it->line_nr;
            }

            ofs << it->text << std::endl;
            ++out.line_nr;
        }
    }
}

bool Preproc::get_end_of_statement()
{
    while (*p && isspace(*p))
        p++;

    if (!*p || *p == ';') {
        p += strlen(p);
        return true;
    }
    else {
        err.e_syntax(*this);
        return false;
    }
}

bool Preproc::parse_line()
{
    // check first character
    switch (*p) {
    case '\0':
        return false;

    case '#':
    case '*':
    case '%':
        parse_directive();
        return true;

    case ALPHA:
        if (parse_opt_label_directive())
            return true;

        break;

    default:
        ;
    }

    if (parse_opt_label_directive())
        return true;

    return false;
}

bool Preproc::parse_directive()
{
    int kw = is_keyword();

    switch (kw) {
    case INCLUDE:
        parse_include();
        return true;

    default:
        return false;
    }
}

bool Preproc::parse_opt_label_directive()
{
    auto p0 = p;
    std::string label = is_label();
    do_label(label);

    if (!parse_directive()) {
        undo_label(label);
        p = p0;
        return false;
    }

    return true;
}

void Preproc::parse_include()
{
    auto filename = get_include_filename();

    if (filename.empty())
        return;

    if (!get_end_of_statement())
        return;

    // recurse
    process(filename);
}

std::string Preproc::label_asm(const std::string& label)
{
    if (label.empty())
        return std::string();
    else
        return std::string(".") + label;
}

void Preproc::do_label(const std::string& label)
{
    if (!label.empty()) {
        auto cur_line = input.cur_line();
        auto line = std::make_shared<Line>(cur_line.filename, cur_line.line_nr,
                                           label_asm(label));
        lines.push_back(line);
    }
}

void Preproc::undo_label(const std::string& label)
{
    if (!label.empty() && !lines.empty()
        && lines.back()->text == label_asm(label))
        lines.pop_back();
}
