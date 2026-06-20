*! sparkta2_appendfile v0.2.0  2026-06-20
*! Close an open file handle, shell-append another file's contents byte-for-byte,
*! then reopen the same handle in append mode. Bypasses Stata's file write parser
*! so we can embed arbitrary content (incl. minified JS that contains `"' sequences,
*! large lines exceeding macro length, etc.) into the HTML output safely.
program define sparkta2_appendfile
    version 17.0
    syntax , FH(name) PATH(string) OUTPATH(string)

    file close `fh'

    local os = lower("`c(os)'")
    if strpos("`os'", "win") {
        shell type "`path'" >> "`outpath'"
    }
    else {
        shell cat "`path'" >> "`outpath'"
    }

    file open `fh' using `"`outpath'"', write text append
end
