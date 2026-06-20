{smcl}
{* *! version 0.5.2  20jun2026}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] sparkta" "help sparkta"}{...}
{vieweralsosee "[R] spmap" "help spmap"}{...}
{title:Title}

{phang}
{bf:sparkta2} {hline 2} Interactive choropleth, bivariate, hexbin, and point
maps from Stata, with chart pass-through to sparkta.


{title:Description}

{pstd}
{cmd:sparkta2} is a thin dispatcher around two engines:

{phang2}o  A bundled D3 v7 map engine that handles {cmd:type(bivariate)},
{cmd:type(choropleth)}, {cmd:type(hexbin)}, and {cmd:type(points)}.{p_end}

{phang2}o  Fahad Mirza's
{browse "https://github.com/fahad-mirza/sparkta_stata":{bf:sparkta}}
chart package, which is called verbatim for every other {cmd:type()} value
(bar, line, scatter, pie, violin, histogram, CI bar, CI line, area, bubble,
and the stacked variants). Install {cmd:sparkta} separately if you intend
to use those chart types.

{pstd}
Map design borrows from Mike Bostock's Observable notebooks
({browse "https://observablehq.com/@d3/bivariate-choropleth":bivariate-choropleth},
{browse "https://observablehq.com/@mbostock/methods-of-comparison-compared":methods-of-comparison-compared},
{browse "https://observablehq.com/@d3/zoom-to-bounding-box":zoom-to-bounding-box}),
and from the D3 Graph Gallery
({browse "https://d3-graph-gallery.com/graph/hexbinmap_geo_label.html":hexbin map},
{browse "https://d3-graph-gallery.com/graph/backgroundmap_country.html":background map}).
{cmd:d3-hexbin} v0.2.2 is bundled for the hexbin renderer (MIT,
© Mike Bostock).


{title:Syntax}

{p 8 16 2}
Maps (handled by sparkta2 directly):
{p_end}
{p 8 16 2}
{cmd:sparkta2} {it:yvar} [{it:xvar}] {ifin} {cmd:,} {cmd:id(}{it:idvar}{cmd:)}
{cmd:type(}{it:maptype}{cmd:)} [{it:map_options}]
{p_end}

{p 8 16 2}
Charts (forwarded verbatim to sparkta):
{p_end}
{p 8 16 2}
{cmd:sparkta2} {it:varlist} {cmd:,} {cmd:type(}{it:charttype}{cmd:)} [{it:sparkta_options}]
{p_end}

{p 8 16 2}
Combined dashboard:
{p_end}
{p 8 16 2}
{cmd:sparkta2_dashboard,} {cmd:files(}{it:list}{cmd:)} {cmd:export(}{it:path}{cmd:)}
[{cmd:titles(}{it:pipelist}{cmd:)} {it:other}]
{p_end}

{phang}
Map {cmd:type()} values:

{phang2}{bf:bivariate}  - two-variable joint NxN choropleth (default 3x3){p_end}
{phang2}{bf:choropleth} - one-variable sequential or diverging choropleth{p_end}
{phang2}{bf:hexbin}     - hexagonal aggregation of feature centroids or lat/lon points{p_end}
{phang2}{bf:points}     - circles at lat/lon (ZIP centroids, addresses){p_end}
{phang2}{bf:map}        - auto-pick: bivariate if two vars, choropleth if one{p_end}


{title:Options}

{synoptset 32 tabbed}{...}
{synopthdr}
{synoptline}
{syntab :Identification + geometry}
{synopt :{cmd:id(}{it:varname}{cmd:)}}id variable. 5-digit county FIPS, 5-digit ZIP, 2-digit state FIPS, 11-digit tract GEOID, etc. Numeric ids are zero-padded to {cmd:idwidth()}.{p_end}
{synopt :{cmd:name(}{it:varname}{cmd:)}}display name for tooltips and the search box{p_end}
{synopt :{cmd:geo(}{it:string}{cmd:)}}geography label; chooses {it:<geo>_counties.topojson}. Default {bf:texas}{p_end}
{synopt :{cmd:layer(}{it:string}{cmd:)}}topojson object to render: {bf:counties} (default), {bf:states}, {bf:nation}, {bf:zctas}, {bf:tracts}, {bf:auto}{p_end}
{synopt :{cmd:idwidth(}{it:#}{cmd:)}}zero-pad width for {cmd:id()} values; default 5{p_end}
{synopt :{cmd:lat(}{it:varname}{cmd:)}}numeric latitude (required for {cmd:type(points)}; optional for {cmd:type(hexbin)}){p_end}
{synopt :{cmd:lon(}{it:varname}{cmd:)}}numeric longitude{p_end}

{syntab :Rendering style}
{synopt :{cmd:type(}{it:string}{cmd:)}}{bf:bivariate} | {bf:choropleth} | {bf:hexbin} | {bf:points} | {bf:map}{p_end}
{synopt :{cmd:scheme(}{it:string}{cmd:)}}bivariate: {bf:rdbu|bupu|gnbu|puor}; sequential: {bf:blues|reds|greens|oranges|purples|viridis|magma|inferno|plasma|cividis}{p_end}
{synopt :{cmd:bins(}{it:#}{cmd:)}}quantile bins per axis (bivariate); 2-5, default 3{p_end}
{synopt :{cmd:basemap}}draw a faded states/nation outline behind the focused features (background-map style){p_end}
{synopt :{cmd:hexradius(}{it:#}{cmd:)}}hexagon radius in SVG units; default 18{p_end}
{synopt :{cmd:hexstat(}{it:string}{cmd:)}}hexbin aggregate: {bf:mean} (default) | {bf:sum} | {bf:median} | {bf:count} | {bf:min} | {bf:max}{p_end}
{synopt :{cmd:pointsize(}{it:#}{cmd:)}}circle radius for {cmd:type(points)}; default 4{p_end}

{syntab :Comparison-mode toggle}
{synopt :{cmd:mode(}{it:string}{cmd:)}}initial mode: {bf:bivariate|x|y|diff|ratio}{p_end}
{synopt :{cmd:modes(}{it:string}{cmd:)}}allowed modes in toggle (pipe-sep), e.g. {bf:bivariate|diff|ratio}{p_end}
{synopt :{cmd:comparable}}declare x/y on the same scale (enables value diff/ratio){p_end}
{synopt :{cmd:multiples}}small-multiples: one panel per mode in a responsive grid{p_end}

{syntab :Interactivity}
{synopt :{cmd:filters(}{it:varlist}{cmd:)}}categorical filter dropdowns; one per variable{p_end}
{synopt :{cmd:sliders(}{it:varlist}{cmd:)}}dual-handle range sliders (numeric); one per variable{p_end}
{synopt :{cmd:tooltipvars(}{it:varlist}{cmd:)}}extra fields rendered as a data table inside the tooltip{p_end}
{synopt :{cmd:search}}in-browser name-search box (filters by {cmd:name()}){p_end}
{synopt :{cmd:counties(}{it:idlist}{cmd:)}}restrict the map to a pipe- or space-separated list of {cmd:id()} values{p_end}
{synopt :{cmd:zoomto(}{it:idlist}{cmd:)}}auto-zoom to the bounding box of these ids on load{p_end}
{synopt :{cmd:nozoom}}disable pan, zoom, and click-to-zoom{p_end}
{synopt :{cmd:swapbutton}}include a "Swap axes" button (bivariate / diff / ratio){p_end}
{synopt :{cmd:download}}include a "Download PNG" button (full SVG, all panels){p_end}

{syntab :Output}
{synopt :{cmd:title(}{it:string}{cmd:)}}{p_end}
{synopt :{cmd:subtitle(}{it:string}{cmd:)}}{p_end}
{synopt :{cmd:note(}{it:string}{cmd:)}}{p_end}
{synopt :{cmd:xlabel(}{it:string}{cmd:)}}{p_end}
{synopt :{cmd:ylabel(}{it:string}{cmd:)}}{p_end}
{synopt :{cmd:export(}{it:path}{cmd:)}}output HTML path{p_end}
{synopt :{cmd:offline}}embed D3 + topojson-client + d3-hexbin inline (no CDN at runtime){p_end}
{synopt :{cmd:noopen}}do not auto-open the result in the default browser{p_end}
{synopt :{cmd:width(}{it:#}{cmd:)}}svg viewBox width; default 980{p_end}
{synopt :{cmd:height(}{it:#}{cmd:)}}svg viewBox height; default 720{p_end}
{synoptline}

{phang}
{cmd:[if] [in]} qualifiers are honored: excluded rows are not embedded
in the map at all (the corresponding feature renders as dim grey).


{title:Browser interactions and the Stata options that produce them}

{pstd}
Every interactive control in the rendered HTML is enabled by a specific
Stata option. The table below maps the option to the in-browser behavior.

{synoptset 32 tabbed}{...}
{synopthdr:Browser control / behavior}
{synoptline}
{synopt :{cmd:mode(...) modes(...)}}A row of buttons appears at the top of the controls panel. Clicking switches the colour palette among bivariate / x-only / y-only / y - x (diff) / y/x (ratio). Only one panel is shown at a time.{p_end}
{synopt :{cmd:multiples}}Suppresses the mode toggle and instead lays out every mode in {cmd:modes()} side-by-side in a responsive grid. Filters and sliders update all panels simultaneously.{p_end}
{synopt :{cmd:comparable}}Switches the diff palette from rank-difference (default) to value-difference. Only set when x and y share units.{p_end}
{synopt :{cmd:filters(varlist)}}Each variable becomes a dropdown. Selecting a value dims every county whose value differs (it keeps its outline but goes to light grey).{p_end}
{synopt :{cmd:sliders(varlist)}}Each variable becomes a dual-handle range slider. Dragging the handles dims counties whose value lies outside the range.{p_end}
{synopt :{cmd:search}}Adds a text input. Typing dims counties whose {cmd:name()} doesn't contain the typed substring (case-insensitive).{p_end}
{synopt :{cmd:counties(fips_list)}}Counties not in the list are not embedded at all — they don't render, even as grey.{p_end}
{synopt :{cmd:[if] [in]}}Same effect as {cmd:counties()} but expressed as a Stata logical condition. Excluded rows don't ship.{p_end}
{synopt :{cmd:zoomto(fips_list)}}On page load, the projection is auto-zoomed to the bounding box of the listed features.{p_end}
{synopt :{i:default (no} {cmd:nozoom}{i:)}}Mouse wheel zooms in/out. Drag pans. {bf:Clicking a feature} zooms the map to that feature's bounding box. {bf:Double-clicking} the map resets to the initial view. A {bf:Reset zoom} button appears in the controls panel.{p_end}
{synopt :{cmd:nozoom}}All of the above are disabled — the map renders statically. Use for slide exports.{p_end}
{synopt :{cmd:swapbutton}}A "Swap axes (X ⇄ Y)" button appears. Clicking flips the variable assignment for bivariate/diff/ratio.{p_end}
{synopt :{cmd:download}}A "Download PNG" button appears. Clicking rasterises the full SVG (all panels in multiples mode) at 2x.{p_end}
{synopt :{cmd:tooltipvars(varlist)}}Each listed variable becomes a labelled row in the tooltip table when hovering over a county/ZIP/state. Labels use {cmd:variable label} when present.{p_end}
{synopt :{cmd:basemap}}A faded {bf:states} (or {bf:nation}) outline is drawn behind the focused features and remains visible at every zoom level.{p_end}
{synopt :{cmd:hexradius() hexstat()}}Active only for {cmd:type(hexbin)}. Hovering a hex shows its aggregate value and a sample of the points it contains.{p_end}
{synopt :{cmd:pointsize()}}Active only for {cmd:type(points)}. Hovering a circle shows the underlying ZIP/feature record.{p_end}
{synopt :Mode toggle (auto)}If two or more modes are allowed, a button row appears.  Click a button to switch the active mode.  Disabled when {cmd:multiples} is on.{p_end}
{synoptline}


{title:Data prep — getting your data into the right shape}

{pstd}
{bf:Three columns are always required:} an {cmd:id} (county FIPS, ZIP, state
FIPS, …), at least one numeric measure to color by, and — if you want
readable hover text — a {cmd:name} variable.  Beyond that, prep needs differ
by map type:

{phang}
{bf:choropleth / bivariate (polygon types)}{break}
{cmd:id()} must match the topojson's feature ids exactly after zero-padding
to {cmd:idwidth()}. For Texas counties that means 5-digit FIPS; pad to 5
with {cmd:tostring fips, replace force format("%05.0f")} or pass the
numeric var and let sparkta2 do it.  Pre-aggregate to one row per feature
({cmd:collapse (mean) value, by(fips)}) — duplicate rows overwrite each
other silently in the embedded data array.  Missing values render as
{bf:no data} (grey); use {cmd:[if] !missing(value)} if you want to drop
them entirely.

{phang}
{bf:points (graduated symbols at lat/lon)}{break}
You need {cmd:lat()} and {cmd:lon()} (decimal degrees, WGS84) and they must
both be non-missing on every row you want to plot. Drop missing-coord rows
first: {cmd:drop if missing(lat) | missing(lon)}.  {cmd:id()} can be ZIP,
parcel id, or anything unique; the topojson is still used for the underlying
geography (county outline shows beneath the points).

{phang}
{bf:hexbin}{break}
Two modes. If you pass {cmd:lat()} and {cmd:lon()}, each row is one point
and the hex aggregation runs over the lat/lon set (used for ZIP-level data
in the bundled demo).  If you don't pass lat/lon, the engine falls back to
the feature centroids of {cmd:layer()} and aggregates the value bound to
each feature (used for county-level hexagons).  {cmd:hexstat()} chooses the
aggregator; default {bf:mean}.

{phang}
{bf:Categorical filters and labelled numerics}{break}
{cmd:filters(varlist)} understands two shapes: a string variable, or a
numeric variable with a value label.  Pass {cmd:label define} + {cmd:label
values} on your numeric region/category codes BEFORE calling sparkta2 —
the dropdown shows the value label, not the raw number.  Without a value
label, numeric codes are displayed as raw numbers.

{phang}
{bf:Sliders}{break}
{cmd:sliders(varlist)} require numeric variables only.  The slider range is
auto-set from the {cmd:summarize, meanonly} min/max; the data shouldn't
have a single repeated value (span 0 collapses the slider).  Reasonable
ranges produce reasonable bins.

{phang}
{bf:Tooltipvars}{break}
{cmd:tooltipvars(varlist)} accepts any mix of string, labelled numeric, and
unlabelled numeric.  String and labelled-numeric values render verbatim;
plain numerics get formatted with {cmd:%,.2f} (or {cmd:%,.0f} when abs ≥
1000).  Set a {cmd:variable label} on each var so the tooltip row gets a
readable left column.

{phang}
{bf:Sanity checks before plotting}{break}
{cmd:assert !missing(fips)}; {cmd:isid fips} (one row per feature);
{cmd:tab region_n, missing} (verify your filter categories aren't all
missing); {cmd:summarize lat lon} (decimal degrees, not radians, not
degrees-minutes).


{title:Working outside Texas}

{pstd}
{cmd:sparkta2} ships Texas-centric assets, but the engine itself is
geography-agnostic.  Two paths to map something other than Texas counties:

{phang}
{bf:Reuse the bundled topojson at a different layer.}{break}
{cmd:texas_counties.topojson} actually contains three layers: {bf:counties}
(254 TX, 5-digit FIPS), {bf:states} (56 US states + DC + territories,
2-digit FIPS), and {bf:nation} (one US outline). To draw an all-US state
choropleth, supply 2-digit state FIPS in {cmd:id()} and pass {cmd:layer(states)
idwidth(2)}. The same data drives {cmd:type(hexbin)} for a state-level
hexbin variant.

{phang}
{bf:Add a new geography.}{break}
Drop a {bf:<geo>_counties.topojson} file next to the ado files and pass
{cmd:geo(<geo>)}.  The file should be a TopoJSON (not GeoJSON) with at
least one object — the engine picks the first one unless you specify
{cmd:layer()}. Pipeline:

{phang2}1.  Download a shapefile (US Census TIGER for US geographies; Natural
Earth or GADM for international).{p_end}
{phang2}2.  Convert to TopoJSON with
{browse "https://mapshaper.org":mapshaper} or
{browse "https://github.com/topojson/topojson-server":topojson-server}.
Mapshaper has a GUI: drop the shapefile, "Export" as TopoJSON, pick a
quantization (1e5 is a good default).{p_end}
{phang2}3.  In mapshaper, set the {bf:id} attribute to whatever you'll
pass in {cmd:id()} (e.g. {cmd:GEOID} for US Census features); pad it to
the width you'll use with {cmd:idwidth()}.{p_end}
{phang2}4.  Save the file as
{it:<geo>_counties.topojson} next to {cmd:sparkta2_engine.js}, and
re-run {cmd:adopath ++ "<that dir>"}.{p_end}

{pstd}
If you want a custom backdrop (e.g. an Asia-Pacific map), include a
{bf:states} (regions/admin1) and {bf:nation} (country outline) object in
the same topojson; {cmd:basemap} will pick them up automatically.

{pstd}
For US-wide work outside Texas, the bundled topojson is sufficient via the
{cmd:layer(states)} trick — see the bonus examples below.


{title:Examples}

{pstd}
A runnable do-file containing every example below sits at
{bf:examples/test_helpfile_examples.do} in the package; both the
Texas-county and ZIP datasets are bundled (the ZIP path is the Texas 2036
{bf:_datashare/Zipcode_Crosswalks/02_cleaned/TX_ZIP_Crosswalk.dta}).


{dlgtab:1. County bivariate choropleth — full UI}

{phang}{cmd}sparkta2 poverty_rate uninsured_rate,                          ///{p_end}
{phang}{cmd}    id(fips) name(county) type(bivariate) scheme(rdbu)         ///{p_end}
{phang}{cmd}    modes(bivariate|x|y|diff|ratio) comparable                 ///{p_end}
{phang}{cmd}    filters(region_n urban) sliders(poverty_rate uninsured_rate) ///{p_end}
{phang}{cmd}    tooltipvars(median_income life_expect)                     ///{p_end}
{phang}{cmd}    swapbutton download search offline                         ///{p_end}
{phang}{cmd}    title("Texas counties: poverty vs uninsured")              ///{p_end}
{phang}{cmd}    export("01_bivariate.html"){p_end}


{dlgtab:2. Small-multiples — three modes side by side}

{phang}{cmd}sparkta2 poverty_rate uninsured_rate,                          ///{p_end}
{phang}{cmd}    id(fips) name(county) type(bivariate)                      ///{p_end}
{phang}{cmd}    modes(bivariate|diff|ratio) multiples comparable           ///{p_end}
{phang}{cmd}    filters(region_n) width(1300) height(620) offline          ///{p_end}
{phang}{cmd}    export("02_multiples.html"){p_end}


{dlgtab:3. Subset to specific counties + auto-zoom}

{phang}{cmd}local big8 "48201 48029 48113 48439 48453 48141 48215 48085"{p_end}
{phang}{cmd}sparkta2 poverty_rate uninsured_rate,                          ///{p_end}
{phang}{cmd}    id(fips) name(county) type(bivariate)                      ///{p_end}
{phang}{cmd}    counties("`big8'") zoomto("`big8'")                         ///{p_end}
{phang}{cmd}    tooltipvars(median_income pop_thou)                        ///{p_end}
{phang}{cmd}    download offline                                           ///{p_end}
{phang}{cmd}    export("03_big8.html"){p_end}


{dlgtab:4. Hexbin — aggregate county centroids}

{phang}{cmd}sparkta2 poverty_rate,                                         ///{p_end}
{phang}{cmd}    id(fips) name(county) type(hexbin) scheme(viridis)         ///{p_end}
{phang}{cmd}    hexradius(22) hexstat(mean) download offline               ///{p_end}
{phang}{cmd}    title("Mean poverty rate per hex")                         ///{p_end}
{phang}{cmd}    export("04_hexbin.html"){p_end}


{dlgtab:5. Basemap — faded US-state backdrop}

{phang}{cmd}sparkta2 poverty_rate uninsured_rate,                          ///{p_end}
{phang}{cmd}    id(fips) name(county) type(bivariate) basemap              ///{p_end}
{phang}{cmd}    modes(bivariate|x|y|diff|ratio) comparable offline         ///{p_end}
{phang}{cmd}    export("05_basemap.html"){p_end}


{dlgtab:6. US 50-state choropleth — works outside Texas}

{phang}{cmd}* user data: 2-digit string state_fips + numeric value pop_mil{p_end}
{phang}{cmd}sparkta2 pop_mil,                                              ///{p_end}
{phang}{cmd}    id(state_fips) name(state_name) geo(texas)                 ///{p_end}
{phang}{cmd}    layer(states) idwidth(2)                                   ///{p_end}
{phang}{cmd}    type(choropleth) scheme(blues) download                    ///{p_end}
{phang}{cmd}    tooltipvars(gdp_thou)                                      ///{p_end}
{phang}{cmd}    title("US state population")                               ///{p_end}
{phang}{cmd}    width(1200) height(720) offline                            ///{p_end}
{phang}{cmd}    export("06_us_states.html"){p_end}


{dlgtab:7. US 50-state bivariate — works outside Texas}

{phang}{it:Note:} hexbin assumes a dense point cloud; with only 50 state
centroids the bins are sparse and align oddly. Use {cmd:type(bivariate)} or
{cmd:type(choropleth)} for state-level data instead.{p_end}

{phang}{cmd}sparkta2 pop_mil gdp_thou,                                     ///{p_end}
{phang}{cmd}    id(state_fips) name(state_name) geo(texas)                 ///{p_end}
{phang}{cmd}    layer(states) idwidth(2)                                   ///{p_end}
{phang}{cmd}    type(bivariate) scheme(rdbu)                                ///{p_end}
{phang}{cmd}    modes(bivariate|x|y|diff|ratio) swapbutton download         ///{p_end}
{phang}{cmd}    width(1200) height(720) offline                            ///{p_end}
{phang}{cmd}    export("07_us_states_bivariate.html"){p_end}


{dlgtab:8. School-district choropleth (bundled NCES boundaries)}

{phang}{cmd}use "NCES_EDGE_Texas_District_Map.dta", clear{p_end}
{phang}{cmd}destring intptlat intptlon, replace force{p_end}
{phang}{cmd}generate float frpl_pct100 = frpl_pct * 100{p_end}
{phang}{cmd}sparkta2 frpl_pct100 students_per_teacher,                    ///{p_end}
{phang}{cmd}    id(leaid) name(name) geo(texas_districts) idwidth(7)      ///{p_end}
{phang}{cmd}    type(bivariate) scheme(rdbu)                              ///{p_end}
{phang}{cmd}    filters(sdtyp) sliders(frpl_pct100 student_count)         ///{p_end}
{phang}{cmd}    tooltipvars(student_count teacher_fte school_count)       ///{p_end}
{phang}{cmd}    download search offline                                   ///{p_end}
{phang}{cmd}    export("08_districts.html"){p_end}


{dlgtab:9. District hexbin (centroids from `intptlat'/`intptlon')}

{phang}{cmd}sparkta2 frpl_pct100,                                         ///{p_end}
{phang}{cmd}    id(leaid) name(name) geo(texas_districts) idwidth(7)      ///{p_end}
{phang}{cmd}    type(hexbin) lat(intptlat) lon(intptlon)                  ///{p_end}
{phang}{cmd}    hexradius(20) hexstat(mean) scheme(viridis) offline       ///{p_end}
{phang}{cmd}    export("09_districts_hexbin.html"){p_end}


{dlgtab:10. Chart pass-through to sparkta}

{phang}{cmd}sparkta2 poverty_rate uninsured_rate,                          ///{p_end}
{phang}{cmd}    type(scatter) fit(lfit) fitci offline                      ///{p_end}
{phang}{cmd}    export("10_scatter.html"){p_end}
{phang}{cmd}sparkta2 poverty_rate uninsured_rate,                          ///{p_end}
{phang}{cmd}    type(bar) over(region_n) stat(mean) offline                ///{p_end}
{phang}{cmd}    export("10_bar.html"){p_end}


{title:Returned values}

{phang}{bf:r(export)} - path of the written HTML.{p_end}
{phang}{bf:r(type)}   - resolved map type.{p_end}
{phang}{bf:r(geo)}    - {cmd:geo()} as resolved.{p_end}
{phang}{bf:r(n_rows)} - number of data rows actually written.{p_end}


{title:References}

{phang}
Bostock, M. {it:Bivariate choropleth}, {it:Methods of comparison compared},
and {it:Zoom to bounding box} — Observable notebooks at
{browse "https://observablehq.com/@d3":observablehq.com/@d3}.

{phang}
Holtz, Y. {it:D3 Graph Gallery — Hexbin map} and {it:Background map} at
{browse "https://d3-graph-gallery.com":d3-graph-gallery.com}.

{phang}
Mirza, F. {bf:sparkta} — interactive HTML charts from Stata.
{browse "https://github.com/fahad-mirza/sparkta_stata":github.com/fahad-mirza/sparkta_stata}.


{title:Embedding in webdoc2}

{pstd}
sparkta2 maps embed in webdoc2 reports via {cmd:wdiframe}, the same way
sparkta dashboards do. Write the map .html into the same folder as the
parent report (file:// enforces same-origin per directory), then:

{phang}{cmd}sparkta2 ..., offline noopen export("mymap.html"){p_end}
{phang}{cmd}wdiframe mymap.html, height(820px){p_end}

{pstd}
The do-file must be invoked via {cmd:webdoc do mydoc.do, replace} (not
plain {cmd:do}) for {cmd:wdinit}/{cmd:webdoc put}/{cmd:wdiframe} to
register. A runnable proof-of-concept lives at
{bf:examples/test_sparkta2_in_webdoc2.do}.


{title:See also}

{phang}{help sparkta} — Fahad Mirza's chart engine that this command wraps.{p_end}
{phang}{help spmap} — Maurizio Pisati's static Stata mapping package.{p_end}
{phang}{help webdoc2} — Texas 2036 webdoc2 wrapper around Ben Jann's {cmd:webdoc}.{p_end}


{title:Author}

{pstd}
Eric Booth, Texas 2036.{break}
eric.booth@texas2036.org

{pstd}
Map renderer, dispatcher, dashboard helper, and all sparkta2-specific
plumbing.  When called with a non-map {cmd:type()}, {cmd:sparkta2}
forwards to {help sparkta} — credit for those chart types belongs entirely
to Fahad Mirza.
