*! sparkta2 v0.5.3  2026-06-20
*! sparkta + interactive choropleth maps in one command.
*!
*! Dispatcher: type(map|bivariate|choropleth) -> sparkta2_map (bundled D3 engine)
*!             everything else                  -> sparkta (Fahad Mirza)
*!
*! Map engine builds on:
*!   https://observablehq.com/@d3/bivariate-choropleth
*!   https://observablehq.com/@mbostock/methods-of-comparison-compared
*!
*! Helpers live in sibling ado files (Stata only auto-loads one program per
*! ado file; named sub-programs each need their own file):
*!   sparkta2_map.ado, sparkta2_findfile.ado, sparkta2_writehtml.ado,
*!   sparkta2_embedjs.ado, sparkta2_streamfile.ado, sparkta2_open.ado

program define sparkta2
    version 17.0

    local sparkta2_version "0.5.3"
    display as text "  [sparkta2 v`sparkta2_version']"

    * Peek at user-supplied type() without consuming any args.
    * If it's a map type, dispatch to sparkta2_map. Otherwise forward to sparkta.
    local _raw `"`0'"'
    local _peek_type ""
    local _lc = lower(`"`_raw'"')
    local _pos = strpos(`"`_lc'"', "type(")
    if `_pos' > 0 {
        local _rest = substr(`"`_raw'"', `_pos' + 5, .)
        local _endpos = strpos(`"`_rest'"', ")")
        if `_endpos' > 0 {
            local _peek_type = lower(strtrim(substr(`"`_rest'"', 1, `_endpos' - 1)))
        }
    }

    local _map_types "map bivariate choropleth bivariatemap univariate hexbin points point"
    if `:list _peek_type in _map_types' {
        sparkta2_map `0'
        exit
    }

    capture which sparkta
    if _rc {
        display as error "sparkta2: type(`_peek_type') needs sparkta.ado to be installed."
        display as error "  Install sparkta first (https://github.com/fahad-mirza/sparkta_stata)"
        display as error "  or use type(map|bivariate|choropleth) to draw a map."
        exit 199
    }
    sparkta `0'
end
