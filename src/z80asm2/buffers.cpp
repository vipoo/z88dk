//-----------------------------------------------------------------------------
// z80asm assembler
// input buffers
// Copyright (C) Paulo Custodio, 2011-2018
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "buffers.h"
#include "errors.h"
#include "options.h"
#include "preproc.h"
#include <cstring>

Line::Line(const std::string& filename_, int line_nr_, const std::string& text_)
    : filename(make_atom(filename_))
    , line_nr(line_nr_)
    , text(text_)
{
}

Buffer::Buffer(const std::string& filename_, int line_nr_)
    : cur_line(make_atom(filename_), line_nr_)
{
}

Buffer::~Buffer()
{
    if (ifs.is_open())
        ifs.close();
}

bool Buffer::open_file(const std::string& filename_)
{
    if (ifs.is_open())
        ifs.close();

    ifs.open(filename_, std::ios::binary);

    if (!ifs.is_open())
        return false;

    cur_line = Line(filename_);

    return true;
}

void Buffer::push_text(const std::string& text_)
{
    if (text.empty())
        text = text_;
    else
        text = text_ + "\n" + std::string(text.begin() + textp, text.end());

    textp = 0;
}

bool Buffer::getline()
{
    if (textp < text.length()) {
        auto p = text.find('\n', textp);

        if (p == text.npos) {           // only one text line
            cur_line.text = std::string(text.begin() + textp, text.end());
            text.clear();
            textp = 0;
            return true;
        }
        else {                          // more lines follow
            cur_line.text = std::string(text.begin() + textp, text.begin() + p);
            textp = p + 1;
            return true;
        }
    }
    else if (ifs.is_open()) {
        if (!safe_getline(ifs, cur_line.text).eof()) {
            cur_line.line_nr++;
            return true;
        }
        else {
            ifs.close();
            return false;
        }
    }
    else {
        cur_line.text.clear();
        return false;
    }
}

const Line& Input::cur_line() const
{
    static Line empty;

    if (stack.empty())
        return empty;
    else
        return stack.back()->cur_line;
}

void Input::push_text(const std::string& text)
{
    auto buf = std::make_shared<Buffer>(cur_line().filename, cur_line().line_nr);
    buf->push_text(text);
    stack.push_back(buf);
    init_scan_text();
}

bool Input::push_file(const std::string& filename_)
{
    std::string pathname = search_file(filename_, opts.include_path);

    if (pathname.empty()) {
        err.e_file_not_found(*this, filename_);
        return false;
    }

    if (has_file_open(pathname)) {
        err.e_recursive_include(*this, pathname);
        return false;
    }

    auto buf = std::make_shared<Buffer>();

    if (!buf->open_file(pathname)) {
        err.e_read_file(*this, pathname);
        return false;
    }

    stack.push_back(buf);
    init_scan_text();

    // add directory of file to path for includes
    opts.include_path.push_back(get_dirname(pathname));
    buf->pushed_include_path = true;

    return true;
}

void Input::pop()
{
    if (!stack.empty()) {
        if (stack.back()->pushed_include_path)
            opts.include_path.pop_back();

        stack.pop_back();
    }

    init_scan_text();
}

bool Input::getline()
{
    if (stack.empty() || ! stack.back()->getline()) {
        init_scan_text();
        return false;
    }
    else {
        init_scan_text();
        return true;
    }
}

bool Input::has_file_open(const std::string& filename) const
{
    for (const auto& it : stack) {
        if (strcmp(it->cur_line.filename, filename.c_str()) == 0)
            return true;
    }

    return false;
}

void Input::init_scan_text()
{
    if (stack.empty())
        scan_text.clear();
    else
        scan_text = cur_line().text;

    scan_text.reserve(scan_text.length() + preproc_max_fill());
    p = scan_text.c_str();
}
