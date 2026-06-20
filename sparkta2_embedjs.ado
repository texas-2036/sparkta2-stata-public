*! sparkta2_embedjs v0.2.0  2026-06-20
*! Inline-embed a JS file as <script>...</script> in the given HTML output.
*! Uses sparkta2_appendfile to bypass Stata's parser limits on long lines /
*! `"' sequences in minified JS.
program define sparkta2_embedjs
    version 17.0
    syntax , FH(name) PATH(string) OUTPATH(string)
    file write `fh' `"<script>"' _n
    sparkta2_appendfile, fh(`fh') path("`path'") outpath(`"`outpath'"')
    file write `fh' _n `"</script>"' _n
end
