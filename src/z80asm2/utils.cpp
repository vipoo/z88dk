//-----------------------------------------------------------------------------
// z80asm assembler
// utilities
// Copyright (C) Paulo Custodio, 2011-20180
// License: http://www.perlfoundation.org/artistic_license_2_0
//-----------------------------------------------------------------------------
#include "ccdefs.h"

static inline bool is_word(int c)
{
    return c == '_' || isalnum(c);
}

Atom make_atom(const std::string& value)
{
    static std::unordered_set<std::string> interned;
    return interned.insert(value).first->c_str();
}

std::string slurp(const std::string& filename)
{
    std::ifstream ifs(filename, std::ios::binary);

    if (!ifs.good())
        throw std::runtime_error("open file " +
                            filename + ": " +
                            std::string(std::strerror(errno)));

    // get length of file:
    ifs.seekg(0, ifs.end);
    size_t size = static_cast<size_t>(ifs.tellg());
    ifs.seekg(0, ifs.beg);

    // read in whole file
    std::string text;
    text.resize(size);
    ifs.read(&text[0], size);

    return text;
}

void spew(const std::string& filename, const std::string& text)
{
    std::ofstream ofs(filename, std::ios::binary);

    if (!ofs.good())
        throw std::runtime_error("create file " +
                            filename + ": " +
                            std::string(std::strerror(errno)));

    ofs.write(&text[0], text.length());
}

void make_path(const std::string& dirname)
{
    if (dir_exists(dirname))            // end recursion
        return;

    make_path(get_dirname(dirname));    // recurse to create parent

#ifdef _WIN32
    CreateDirectory(dirname.c_str(), NULL);
#else
    mkdir(dirname.c_str(), 0777);
#endif
}

void remove_file(const std::string& filename)
{
    remove(filename.c_str());
}

void remove_dir(const std::string& dirname)
{
#ifdef _WIN32
    RemoveDirectory(dirname.c_str());
#else
    rmdir(dirname.c_str());
#endif
}

struct iequal {
    bool operator()(int c1, int c2) const
    {
        return toupper(c1) == toupper(c2);
    }
};

bool iequals(const std::string& a, const std::string& b)
{
    return a.size() == b.size() &&
           equal(a.begin(), a.end(), b.begin(), iequal());
}

static inline bool isslash(char c)
{
    return c == '/' || c == '\\';
}

std::string simplify_path(std::string path)
{
    std::replace(path.begin(), path.end(), '\\', '/');
    auto pos = path.find("//");

    while (pos != std::string::npos) {
        path.erase(pos, 1);
        pos = path.find("//", pos);
    }

    return path;
}

std::string canonize_path(std::string path)
{
#ifdef _WIN32
    path = simplify_path(path);
    replace(path.begin(), path.end(), '/', '\\');
    return path;
#else
    return simplify_path(path);
#endif
}

static size_t skip_volume(const std::string& path)
{
#ifdef _WIN32

    if (path.length() >= 2 && isalpha(path[0]) && path[1] == ':')
        return 2;

#endif
    return 0;
}

std::string get_dirname(std::string path)
{
    if (path.empty())
        return ".";

    path = simplify_path(path);
    size_t volume_size = skip_volume(path);

    if (path.length() == volume_size)
        return path + ".";
    else if (path.substr(volume_size) == "/")
        return path;

    // remove end slashes
    while (path.length() > 0 && path.back() == '/')
        path.pop_back();

    // find last slash
    size_t p = path.find_last_of('/');

    if (p == std::string::npos)
        return path.substr(0, volume_size) + ".";
    else if (p == volume_size)
        return path.substr(0, volume_size) + "/";
    else
        return path.substr(0, p);
}

std::string get_basename(std::string path)
{
    path.erase(0, skip_volume(path));
    path = simplify_path(path);

    if (path.empty())
        return ".";
    else if (path == "/")
        return path;

    // remove end slashes
    while (path.length() > 0 && path.back() == '/')
        path.pop_back();

    // find last slash
    size_t p = path.find_last_of('/');

    if (p == std::string::npos)
        return path;
    else
        return path.substr(p + 1);
}

std::string get_extension(const std::string& path)
{
    auto name = get_basename(path);
    size_t pos = name.find_last_of('.');

    if (pos != std::string::npos && pos != 0)
        return name.substr(pos);
    else
        return "";
}

std::string replace_extension(const std::string& path,
                         const std::string& new_ext)
{
    size_t ext_len = get_extension(path).length();
    return simplify_path(path.substr(0, path.length() - ext_len) + new_ext);
}

std::string combine_path(std::string dir, std::string filename)
{
    dir = simplify_path(dir);

    while (dir.length() > 0 && dir.back() == '/')
        dir.pop_back();

    filename = simplify_path(filename);
    size_t pos = skip_volume(filename);

    while (pos < filename.length() && filename[pos] == '/')
        pos++;

    filename.erase(0, pos);

    return dir + "/" + filename;
}

std::string search_file(const std::string& filename,
                   const std::vector<std::string>& dirs)
{
    if (file_exists(filename))
        return filename;

    for (auto& dir : dirs) {
        auto combined = combine_path(dir, filename);

        if (file_exists(combined))
            return combined;
    }

    return std::string();   // not found
}

// https://stackoverflow.com/questions/6089231/getting-std-ifstream-to-handle-lf-cr-and-crlf
std::istream& safe_getline(std::istream& is, std::string& t)
{
    t.clear();

    // The characters in the stream are read one-by-one using a streambuf.
    // That is faster than reading them one-by-one using the istream.
    // Code that uses streambuf this way must be guarded by a sentry object.
    // The sentry object performs various tasks,
    // such as thread synchronization and updating the stream state.

	std::istream::sentry se(is, true);
	std::streambuf* sb = is.rdbuf();

    for (;;) {
        int c = sb->sbumpc();

        switch (c) {
        case '\n':
            return is;

        case '\r':
            if (sb->sgetc() == '\n')
                sb->sbumpc();

            return is;

        case std::streambuf::traits_type::eof():

            // Also handle the case when the last line has no line ending
            if (t.empty())
                is.setstate(std::ios::eofbit);

            return is;

        default:
            t += (char)c;
        }
    }
}

bool file_exists(const std::string& filename)
{
    struct stat sb;

    if (stat(filename.c_str(), &sb) == 0 && (sb.st_mode & S_IFREG))
        return true;
    else
        return false;
}

bool dir_exists(const std::string& dirname)
{
    struct stat sb;

    if ((stat(dirname.c_str(), &sb) == 0) && (sb.st_mode & S_IFDIR))
        return true;
    else
        return false;
}

void trim(std::string& text)
{
    text.erase(text.begin(), find_if(text.begin(), text.end(),
    [](int ch) {
        return !isspace(ch);
    }));
    text.erase(find_if(text.rbegin(), text.rend(),
    [](int ch) {
        return !isspace(ch);
    }).base(), text.end());
}

void chomp(std::string& text)
{
    text.erase(find_if(text.rbegin(), text.rend(),
    [](int ch) {
        return !(ch == '\r' || ch == '\n');
    }).base(), text.end());
}

void replace_words(std::string& text, const std::string& old_word,
                   const std::string& new_word)
{
    bool old_start_is_word = is_word(old_word.front());
    bool old_end_is_word = is_word(old_word.back());
    size_t old_word_length = old_word.length();
    size_t new_word_length = new_word.length();

    std::string::size_type pos = 0;

    while ((pos = text.find(old_word, pos)) != std::string::npos) {
        if (old_start_is_word &&
            pos > 0 && is_word(text[pos - 1])
           ) {
            pos++;                      // replace only across \b
        }
        else if (old_end_is_word &&
                 pos + old_word_length < text.length() && is_word(text[pos + old_word_length])
                ) {
            pos++;                      // replace only across \b
        }
        else {
            text.replace(pos, old_word_length, new_word);
            pos += new_word_length;
        }
    }
}
