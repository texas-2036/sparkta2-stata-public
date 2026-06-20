*! sparkta2_streamfile v0.2.0  2026-06-20
*! Stream a text file's contents through an open file handle.
program define sparkta2_streamfile
    version 17.0
    syntax , FH(name) PATH(string)
    tempname rf
    file open `rf' using `"`path'"', read text
    file read `rf' line
    while r(eof) == 0 {
        file write `fh' `"`macval(line)'"' _n
        file read `rf' line
    }
    file close `rf'
end
