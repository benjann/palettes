*! version 1.1.1  31jan2019  Ben Jann

if c(stata_version)<14.2 {
    di as err "{bf:colorpalette} requires version 14.2 of Stata" _c
    if c(stata_version)>=9.2 {
        di as err "; use command {helpb colorpalette9}" _c
    }
    di as err ""
    error 9
}

capt findfile lcolrspace.mlib
if _rc {
    di as error "-colrspace- is required; type {stata ssc install colrspace}"
    error 499
}

program colorpalette
    version 14.2
    capt _on_colon_parse `0'
    if _rc==0 {
        local 0 `"`s(before)'"'
        local rhs `"`s(after)'"'
        _parse comma lhs 0 : 0
        if `"`lhs'"'!="" error 198
        if `"`rhs'"'=="" local rhs s2
        local palettes
        local palette
        local space
        while (`"`rhs'"'!="") {
            gettoken p rhs : rhs, parse("/") quotes bind
            if `"`p'"'=="/" {
                local palettes `"`palettes'`"`palette'"' "'
                local palette
                local space
                continue
            }
            local palette `"`palette'`space'`p'"'
            local space " "
        }
        if `"`palette'"'!="" {
            local palettes `"`palettes'`"`palette'"'"'
        }
        Graph2 `palettes' `0'
        exit
    }
    gettoken p rhs : 0, parse("/") quotes bind
    if `"`rhs'"'!="" {
        local rhs: copy local 0
        local 0
        local palettes
        local palette
        local space
        while (`"`rhs'"'!="") {
            gettoken p rhs : rhs, parse("/") quotes bind
            if `"`p'"'=="/" {
                local palettes `"`palettes'`"`palette'"' "'
                local palette
                local space
                continue
            }
            local palette `"`palette'`space'`p'"'
            local space " "
        }
        if `"`palette'"'!="" { // handle syntax after last slash
            _parse comma p rhs : palette
            if `"`p'"'!="" {
                Parse_Graph_Opts `rhs'  // returns rhs and 0
                local palettes `"`palettes'`"`p'`rhs'"'"'
            }
            else local 0: copy local palette
        }
        Palette_Get2 `palettes' `0'
    }
    else {
        Palette_Get `0'
    }
    if "`GRAPH'"=="" {
        tempname hcurrent
        _return hold `hcurrent'
        _return restore `hcurrent', hold // make copy
        Graph, `GROPTS'
        _return restore `hcurrent'
    }
end

/*----------------------------------------------------------------------------*/
/* retrieve palette(s)                                                        */
/*----------------------------------------------------------------------------*/

program Parse_Graph_Opts
    syntax [, noGRaph GRopts(passthru) TItle(passthru) rows(passthru) names NONUMbers * ]
    if `"`graph'`gropts'`title'`rows'"'!="" {
        c_local 0 `", `graph' `gropts' `title' `rows' `names' `nonumbers'"'
    }
    if `"`options'"'!="" c_local rhs `", `options'"'
    else                 c_local rhs
end

program Palette_Get2, rclass
    _parse comma palettes 0 : 0
    syntax [, noGRaph GRopts(str asis) TItle(passthru) rows(passthru) names NONUMbers * ]
    c_local GRAPH "`graph'"
    c_local GROPTS `"`rows' `title' `names' `gropts' `nonumbers'"'
    local space
    local i 0
    foreach p of local palettes {
        _parse comma pnm popts : p
        if `"`popts'"'=="" local popts ,
        Palette_Get `pnm' `popts' `options'
        local plist `"`plist'`space'`r(p)'"'
        local space " "
        forv j = 1/`r(n)' {
            local ++i
            return local p`i' `"`r(p`j')'"'
            return local p`i'info  `"`r(p`j'info )'"'
        }
    }
    return scalar n = `i'
    return local p `"`plist'"'
    return local pname "custom"
    return local ptype "color"
end

program Palette_Get
    _parse comma palette 0 : 0
    syntax [, noGRaph GRopts(str asis) TItle(passthru) rows(passthru) names NONUMbers * ]
    c_local GRAPH "`graph'"
    c_local GROPTS `"`rows' `title' `names' `gropts' `nonumbers'"'
    _Palette_Get `palette', `options'
end

program _Palette_Get, rclass
    local opts [, N(numlist max=1 integer >=1) Select(numlist integer) ///
        order(numlist integer) REVerse ///
        INtensity(numlist >=0 missingokay) ///
        OPacity(numlist int >=0 missingokay) ///
        IPolate(str) intensify(numlist >=0 missingokay) ///
        SATurate(str) LUMinate(str) GScale GScale2(str) CBlind CBlind2(str) ///
        NOEXPAND class(str) FORCErgb cmyk * ]
    syntax [anything(name=palette id="palette" everything equalok)] `opts'
    remove_repeatedopts `"`opts'"' `", `options'"'
    if `"`opacity'"'!="" {
        if c(stata_version)<15 {
            di as err "{bf:opacity()} requires Stata 15"
            exit 9
        }
    }
    if `"`select'"'!="" & `"`order'"'!="" {
        di as err "only one of select() and order() allowed"
        exit 198
    }
    if `"`ipolate'"'!=""    parse_ipolate `ipolate'
    if `"`saturate'"'!=""   parse_saturate `saturate'
    if `"`luminate'"'!=""   parse_luminate `luminate'
    if `"`ipolate'"'!=""    parse_ipolate `ipolate'
    if `"`gscale2'"'!=""    local gscale gscale
    if "`gscale'"!=""       parse_gscale `gscale2'
    if `"`cblind2'"'!=""    local cblind cblind
    if "`cblind'"!=""       parse_cblind `cblind2'
    if `"`class'"'!=""      capture parse_class, `class'
    // get palette
    local ptype 0
    if `"`palette'"'=="" {
        local palette s2
        local ptype 2
    }
    else {
        capt parse_mata, `palette' // returns local mataname
        if _rc==0 local ptype 3
    }
    if `ptype'==0 {
        local ptype = (`: list sizeof palette'!=1)
    }
    if `ptype'==0 {
        capt confirm name _`palette'
        if _rc local ptype 1
    }
    if `ptype'==0 mata: checkpalette() // sets ptype = 2 if found
    if `ptype'==0 {
        capt __Palette_Get `palette', n(`n') `cmyk' `options'
        if _rc local ptype 1
    }
    mata: getpalette(`ptype', strtoreal("`n'"))
    // return palette
    local i 0
    foreach p of local plist {
        local ++i
        gettoken pi pinfo : pinfo
        return local p`i' `"`p'"'
        return local p`i'info `"`pi'"'
    }
    return local p `"`plist'"'
    return local pnote `"`note'"'
    return local pclass `"`class'"'
    return local pname `"`palette'"'
    return local ptype "color"
    return scalar n = `i'
end

program remove_repeatedopts
    args opts 0
    syntax `opts'
    c_local options `"`options'"'
end

program parse_mata
    syntax, Mata(name)
    c_local mataname `"`mata'"'
end

program __Palette_Get
    gettoken palette 0 : 0, parse(" ,")
    syntax [, n(numlist max=1 integer >0) * ]
    colorpalette_`palette', n(`n') `options'
    if `"`P'"'=="" { // palettes that define P#
        local min 1
        while (`"`P`min''"'=="") {
            local ++min
            if `min'>100 {
                c_local n 0
                exit // emergency exit
            }
        }
        local max `min'
        while (`"`P`max''"'!="") {
            local ++max
        }
        local --max
        if "`n'"=="" local n `max'
        local n = max(`min',min(`max',`n'))
        local P `"`P`n''"'
    }
    c_local plist  `"`P'"'
    c_local pinfo  `"`I'"'
    c_local note  `"`note'"'
    c_local class `"`class'"'
    if `"`name'"'!="" c_local palette `"`name'"'
end

program parse_ipolate
    _parse comma n opts : 0
    gettoken comma opts : opts, parse(",")
    local 0 `", n(`n') `opts'"'
    syntax [, n(numlist max=1 integer >=1) RAnge(numlist max=2) ///
        POWer(numlist max=1 >0) POSitions(numlist) PADded * ]
    if "`n'"=="" exit // no number specified
    c_local ipolate_n `n'
    c_local ipolate_range "`range'"
    c_local ipolate_power "`power'"
    c_local ipolate_positions "`positions'"
    c_local ipolate_pad "`padded'"
    c_local ipolate_space `"`options'"'
end

program parse_saturate
    _parse comma p opts : 0
    gettoken comma opts : opts, parse(",")
    local 0 `", p(`p') `opts'"'
    syntax [, p(numlist missingokay) level * ]
    if "`p'"=="" exit // no numbers specified
    c_local saturate_p `"`p'"'
    c_local saturate_level "`level'"
    c_local saturate_method `"`options'"'
end

program parse_luminate
    _parse comma p opts : 0
    gettoken comma opts : opts, parse(",")
    local 0 `", p(`p') `opts'"'
    syntax [, p(numlist missingokay) level * ]
    if "`p'"=="" exit // no numbers specified
    c_local luminate_p `"`p'"'
    c_local luminate_level "`level'"
    c_local luminate_method `"`options'"'
end

program parse_gscale
    _parse comma p opts : 0
    gettoken comma opts : opts, parse(",")
    local 0 `", gscale(`p') `opts'"'
    syntax [, gscale(numlist max=1 >=0 <=1) * ]
    c_local gscale_p `gscale'
    c_local gscale_method `"`options'"'
end

program parse_cblind
    _parse comma p opts : 0
    gettoken comma opts : opts, parse(",")
    local 0 `", cblind(`p') `opts'"'
    syntax [, cblind(numlist max=1 >=0 <=1) * ]
    c_local cblind_p `cblind'
    c_local cblind_method `"`options'"'
end

program parse_class
    syntax [, Qualitative Sequential Diverging ]
    local class `qualitative' `sequential' `diverging'
    if `:list sizeof class'>1 exit 198
    c_local class `class'
end

/*----------------------------------------------------------------------------*/
/* graph of single palette                                                    */
/*----------------------------------------------------------------------------*/

program Graph
    syntax [, rows(int 5) TItle(passthru) names NONUMbers * ]
    local n = r(n)
    local c = max(3,ceil(sqrt(`n'/12*3)))
    local cut = max(`rows',ceil(`n'/`c'))
    local rows = max(5, `cut')
    local c = max(3,ceil(`n'/`rows'))
    local size = (100-10)/(1.5*`rows')
    local lblgap = `size'/6
    local infogap = `size'/3.75
    local rgap = (100-5)/`c'
    local j 1
    local r 0
    forv i=1/`n' {
        if `i'>(`cut'*`j') {
            local ++j
            local r 0
        }
        local ++r
        if `"`r(p`i')'"'=="" continue
        local jlab `j'
        local plots `plots' (scatteri `r' `j', mlw(vthin) mlc(black) ///
            msymbol(square) msize(`size') mfcolor(`"`r(p`i')'"'))
        local pnum `pnum' `r' `j' "`i'"
        if "`names'"=="" {
            local lbl `lbl' `r' `jlab' `"`r(p`i')'"'
            if `"`r(p`i'info)'"'!="" {
                local info `info' `r' `jlab' `"`r(p`i'info)'"'
            }
        }
        else {
            if `"`r(p`i'info)'"'!="" {
                local lbl `lbl' `r' `jlab' `"`r(p`i'info)'"'
            }
            else {
                local lbl `lbl' `r' `jlab' `"`r(p`i')'"'
            }
        }
    }
    if `"`plots'"'=="" {
        di as txt "(nothing to display)"
        exit
    }
    if `rows'>=30 {
        local pnumsize tiny
        local lblsize tiny
        local infosize half_tiny
    }
    else if `rows'>=15 {
        local pnumsize small
        local lblsize vsmall
        local infosize tiny
    }
    else if `rows'>=10 {
        local pnumsize small
        local lblsize small
        local infosize vsmall
    }
    else {
        local pnumsize medium 3.8194
        local lblsize medsmall
        local infosize small
    }
    local pnum (scatteri `pnum', ms(i) msize(`size') mlabpos(9) ///
            mlabgap(`lblgap') mlabsize(`pnumsize') mlabcolor(black))
    if `"`lbl'"'!="" {
        local lbl (scatteri `lbl', ms(i) msize(`size') mlabpos(3) ///
            mlabgap(`lblgap') mlabsize(`lblsize') mlabcolor(black))
    }
    if `"`info'"'!="" {
        local info (scatteri `info', ms(i) msize(`size') mlabpos(4) ///
            mlabgap(`infogap') mlabsize(`infosize') mlabcolor(black))
    }
    else local info
    local l = `size'/2 + 9
    local r = `size'/2 + `rgap'
    local b = `size'/2 + 5
    local t = `size'/2 + 4
    if `"`title'"'=="" {
        if `"`r(pnote)'"'=="" local title title(`"`r(pname)'"')
        else                  local title title(`"`r(pname)' (`r(pnote)')"')
    }
    if "`nonumbers'"!="" local pnum
    two `plots' `pnum' `lbl' `info' , `title' scheme(s2color) ///
        legend(off) ylabel(none) graphr(color(white)) ///
        xlabel(none) xscale(range(1 3) off) ///
        yscale(range(1 `rows') off reverse) ///
        plotr(margin(`l' `r' `b' `t')) graphr(margin(0 0 0 3)) `options'
end

/*----------------------------------------------------------------------------*/
/* graph of multiple palettes                                                 */
/*----------------------------------------------------------------------------*/

program Graph2
    _parse comma palettes 0 : 0
    syntax [, TItle(passthru) LABels(str asis) PLabels(str asis) NONUMbers ///
        GRopts(str asis) LColor(str) LWidth(str) VERTical HORizontal span * ]
    if `"`labels'"'!="" local plabels `"`labels'"'
    local orientation `vertical' `horizontal'
    if "`orientation'"=="" local orientation horizontal
    if `"`lcolor'"'!="" {
        local lcolor lc(`lcolor' ..) 
        if c(stata_version)>=15 local lcolor `lcolor' lalign(center ..)
    }
    if `"`lwidth'"'!="" {
        local lwidth lw(`lwidth' ..) 
    }
    else local lwidth lw(vthin ..)
    local np: list sizeof palettes
    local r = 4 * `np'
    if (_N > `r') {
        preserve
        qui keep in 1/`r'   // remove extra observations to speed up
    }
    else if (_N < `r') {
        preserve
        qui set obs `r'
    }
    tempvar y
    qui generate `y' = ceil(_n/4) - .35 + inlist(mod(_n-1,4)+1,3,4)*.7 in 1/`r'
    if "`span'"!="" {
        tempvar psize
        qui generate `psize' = .
    }
    local nxvars 0
    local i 0
    local plots
    local ylab
    foreach p of local palettes {
        local ++i
        _parse comma pnm popts : p
        if `"`pnm'"'=="." continue
        if `"`popts'"'=="" local popts ,
        Palette_Get `pnm' `popts' `options'
        local colors `"`r(p)'"'
        local n = r(n)
        gettoken plab plabels : plabels
        if `"`plab'"'=="" {
            if `"`r(pnote)'"'=="" local plab `"`r(pname)'"'
            else                  local plab `"`r(pname)' (`r(pnote)')"'
        }
        local ylab `ylab' `i' `"`plab'"'
        while (`nxvars'<`n') {
            local xx0 `xx`nxvars''
            if mod(`nxvars',20)==0 local xx0
            local ++nxvars
            tempvar x`nxvars'
            local xx`nxvars' `xx0' `x`nxvars''
        }
        local from = (`i' - 1) * 4 + 1
        local to = `i' * 4
        if "`span'"!="" {
            qui replace `psize' = `n' in `from'/`to'
        }
        local n0 0
        while (`n0'<`n') {
            local ctmp
            while (1) {
                local ++n0
                gettoken ci colors : colors, quotes
                local ctmp `"`ctmp'`ci' "'
                if `n0'==`n' continue, break
                if mod(`n0',20)==0 continue, break
            }
            local plots `plots' ///
                (scatter `xx`n0'' `y' in `from'/`to', color(`ctmp') ///
                `lcolor' `lwidth' fintensity(100 ..) ///
                recast(area) `orientation' nodropbase)
        }
    }
    if `"`plots'"'=="" {
        di as txt "(noting to display)"
        exit
    }
    forv i=1/`nxvars' {
        qui gen `x`i'' = `i' + inlist(mod(_n-1,4)+1,2,3) - .5
    }
    if "`span'"!="" {
        forv i=1/`nxvars' {
            qui replace `x`i'' = (`x`i'' - .5) / `psize'
        }
    }
    if "`nonumbers'"=="" {
        local xlab = ceil(`nxvars'/20)
        numlist "1(`xlab')`nxvars'"
        local xlab `r(numlist)'
    }
    else local xlab none
    if "`orientation'"=="horizontal" {
        if "`span'"!="" {
            local xscale xscale(off range(0 1))
            local xlabel
        }
        else {
            local xscale xscale(lstyle(none) range(1 `nxvars'))
            local xlabel xlabel(`xlab', notick)
        }
        local yscale yscale(lstyle(none) range(0.65 `np'.35) reverse)
        local ylabel ylabel(`ylab', nogrid notick angle(hor))
    }
    else {
        local xscale xscale(lstyle(none) range(0.65 `np'.35) alt)
        local xlabel xlabel(`ylab', notick)
        if "`span'"!="" {
            local yscale yscale(off range(0 1) reverse)
            local ylabel ylabel(, nogrid)
        }
        else {
            local yscale yscale(lstyle(none) range(1 `nxvars') reverse)
            local ylabel ylabel(`xlab', nogrid notick angle(hor))
        }
    }
    twoway `plots', `xscale' `xlabel' xti("") `yscale' `ylabel' yti("") ///
        legend(off) graphr(margin(l=2 t=2 b=1 r=2) color(white)) ///
        scheme(s2color) `title' `gropts'
end

/*----------------------------------------------------------------------------*/
/* mata                                                                       */
/*----------------------------------------------------------------------------*/

version 14
mata:
mata set matastrict on

void checkpalette()
{
    string scalar  palettes
    
    palettes = ("Accent", "Dark2", "Paired", "Pastel1", "Pastel2", "Set1",
    "Set2", "Set3", "Blues", "BuGn", "BuPu", "GnBu", "Greens", "Greys", "OrRd",
    "Oranges", "PuBu", "PuBuGn", "PuRd", "Purples", "RdPu", "Reds", "YlGn",
    "YlGnBu", "YlOrBr", "YlOrRd", "BrBG", "PRGn", "PiYG", "PuOr", "RdBu",
    "RdGy", "RdYlBu", "RdYlGn", "Spectral", "sfso")
    if (anyof(palettes, st_local("palette"))) {
        if (st_local("cmyk")!="") return
        st_local("ptype", "2")
        return
    }
    palettes = ("s1", "s1r", "s2", "economist", "mono", "cblind", "plottig",
    "538", "tfl", "mrc", "burd", "lean", "d3", "ptol", "tableau", "lin",
    "spmap", "matplotlib", "magma", "inferno", "plasma", "viridis", "cividis",
    "twilight", "hue", "hcl", "lch", "jmh", "hsv")
    if (anyof(palettes, st_local("palette"))) st_local("ptype", "2")
}

void getpalette(real scalar ptype, real scalar n)
{
    real scalar     rc, noip, ip_n
    string scalar   pal, note, schemes
    class ColrSpace scalar S
    pointer scalar  p

    // setup
    noip = st_local("noexpand")!=""
    S.pclass(st_local("class"))

    // get colors
    if (ptype==0) {
        // colorpalette_<palette>.ado: plist/pinfo contain comma-separated list
        S.colors(st_local("plist"), ",")
        if (st_local("pinfo")!="") S.info(st_local("pinfo"), ",")
        if (n<.) {
            if (n<S.N() & S.pclass()=="qualitative") S.recycle(n)
            if (noip==0) {
                if (S.pclass()=="qualitative") S.recycle(n)
                else                           S.ipolate(n)
            }
        }
        note = st_local("note")
    }
    else if (ptype==1) {
        // custom colors; palette contains space separated list of colors
        S.colors(st_local("palette"))
        if (st_local("options")!="") { // options not allowed
            st_local("0", "," + st_local("options"))
            rc = _stata("syntax [, SOMEW3IRDNAME ]")
            if (rc) exit(rc)
        }
        if (n<.) {
            if (n<S.N() & S.pclass()=="qualitative") S.recycle(n)
            if (noip==0) {
                if (S.pclass()=="qualitative") S.recycle(n)
                else                           S.ipolate(n)
            }
        }
        st_local("palette", "custom")
    }
    else if (ptype==2) {
        // mata palette
        pal = st_local("palette")
        if (anyof(("magma", "inferno", "plasma", "viridis", "cividis"), pal)) {
            st_local("0", "," + st_local("options"))
            rc = _stata("syntax [, RAnge(numlist max=2 >=0 <=1) SHIFTed ]")
            if (rc) exit(rc)
            S.matplotlib(pal, n, strtoreal(tokens(st_local("range"))))
        }
        else if (pal=="twilight") {
            st_local("0", "," + st_local("options"))
            rc = _stata("syntax [, RAnge(numlist max=2 >=0 <=1) SHIFTed ]")
            if (rc) exit(rc)
            S.matplotlib(pal + " " + st_local("shifted"), n, strtoreal(tokens(st_local("range"))))
            st_local("palette", S.pname())
        }
        else if (pal=="matplotlib") {
            st_local("0", "," + st_local("options"))
            rc = _stata("syntax [, RAnge(numlist max=2 >=0 <=1) * ]")
            if (rc) exit(rc)
            if (strtrim(st_local("options"))=="") st_local("options", "jet")
            S.matplotlib(st_local("options"), n, strtoreal(tokens(st_local("range"))))
            st_local("palette", pal + " " + S.pname())
        }
        else if (pal=="hue") {
            st_local("0", "," + st_local("options"))
            rc = _stata("syntax [, Hue(numlist max=2) Chroma(numlist max=1 >=0) " 
                + "Luminance(numlist max=1 >=0 <=100) DIRection(int 1) ]")
            if (rc) exit(rc)
            if (st_local("direction")!="1" & st_local("direction")!="-1") {
                display("{err}direction must be 1 or -1")
                exit(198)
            }
            S.generate(pal, n, strtoreal(tokens(st_local("hue"))), 
                      strtoreal(st_local("chroma")), 
                      strtoreal(st_local("luminance")),
                      st_local("direction")!="1")
        }
        else if (pal=="hcl" | pal=="lch" | pal=="jmh") {
            st_local("0", "," + st_local("options"))
            rc = _stata("syntax [, Hue(numlist max=2) Chroma(numlist max=2 >=0) " 
                    + "Luminance(numlist max=2 >=0 <=100) POWer(numlist max=2 >0) "
                    + " * ]")
            if (rc) exit(rc)
            hclgenerate(S, pal, st_local("options"), n,
                strtoreal(tokens(st_local("hue"))), 
                strtoreal(tokens(st_local("chroma"))), 
                strtoreal(tokens(st_local("luminance"))),
                strtoreal(tokens(st_local("power"))))
        }
        else if (pal=="hsv") {
            st_local("0", "," + st_local("options"))
            rc = _stata("syntax [, Hue(numlist max=2) SATuration(numlist max=2 >=0 <=1) " 
                    + "VALue(numlist max=2 >=0 <=1) " + "POWer(numlist max=2 >0) "
                    + " * ]")
            if (rc) exit(rc)
            hsvgenerate(S, st_local("options"), n,
                strtoreal(tokens(st_local("hue"))), 
                strtoreal(tokens(st_local("saturation"))), 
                strtoreal(tokens(st_local("value"))),
                strtoreal(tokens(st_local("power"))))
        }
        else {
            S.palette(pal + " " + st_local("options"), n, noip)
            st_local("palette", S.pname())
        }
    }
    else if (ptype==3) {
        if (st_local("options")!="") { // options not allowed
            st_local("0", "," + st_local("options"))
            rc = _stata("syntax [, SOMEW3IRDNAME ]")
            if (rc) exit(rc)
        }
        p = findexternal(st_local("mataname"))
        if (p==NULL) {
            display("{err}mata object '" + st_local("mataname") + "' not found")
            exit(498)
        }
        if (classname(*p)!="ColrSpace") {
            display("{err}'" + st_local("mataname") + "' is not a ColrSpace() object")
            exit(498)
        }
        S = *p 
        if (S.pclass()=="") S.pclass(st_local("class"))
        if (n<.) {
            if (n<S.N() & S.pclass()=="qualitative") S.recycle(n)
            if (noip==0) {
                if (S.pclass()=="qualitative") S.recycle(n)
                else                           S.ipolate(n)
            }
        }
        if (S.pname()!="") st_local("palette", S.pname())
        else               st_local("palette", st_local("mataname"))
    }
    // select
    if (st_local("select")!="") S.select(strtoreal(tokens(st_local("select"))))
    // order
    if (st_local("order")!="") S.order(strtoreal(tokens(st_local("order"))))
    // reverse
    if (st_local("reverse")!="") S.reverse()
    // opacity
    if (st_local("opacity")!="") S.opacity(strtoreal(tokens(st_local("opacity"))), 1)
    // intensity
    if (st_local("intensity")!="") S.intensity(strtoreal(tokens(st_local("intensity"))), 1)
    // interpolation
    if ((ip_n  = strtoreal(st_local("ipolate_n")))<.) {
        S.ipolate(ip_n, 
                  st_local("ipolate_space"), 
                  strtoreal(tokens(st_local("ipolate_range"))), 
                  strtoreal(st_local("ipolate_power")),
                  strtoreal(tokens(st_local("ipolate_positions"))),
                  st_local("ipolate_pad")!="")
    }
    if (S.isipolate()) {
        note = note + (note!=""? " " : "") + "interpolated"
    }
    // intensify
    if (st_local("intensify")!="") {
        S.intensify(strtoreal(tokens(st_local("intensify"))))
    }
    // saturate
    if (st_local("saturate_p")!="") {
        S.saturate(strtoreal(tokens(st_local("saturate_p"))), 
                   st_local("saturate_method"),
                   st_local("saturate_level")!="")
    }
    // luminate
    if (st_local("luminate_p")!="") {
        S.luminate(strtoreal(tokens(st_local("luminate_p"))), 
                   st_local("luminate_method"),
                   st_local("luminate_level")!="")
    }
    // grayscale
    if (st_local("gscale")!="") {
        S.gray(strtoreal(st_local("gscale_p")), st_local("gscale_method"))
    }
    // CVD
    if (st_local("cblind")!="") {
        S.cvd(strtoreal(st_local("cblind_p")), st_local("cblind_method"))
        note = note + (note!=""? " " : "") + "CVD"
    }
    // return colors
    st_local("plist", S.colors(st_local("forcergb")!=""))
    st_local("pinfo", S.info(st_local("forcergb")!=""))
    st_local("note", note)
    st_local("class", S.pclass())
}

void hclgenerate(class ColrSpace scalar S, string scalar space, string scalar pal0,
    real scalar n, real vector h, real vector c, real vector l, real vector p)
{
    real scalar    h1, h2, c1, c2, l1, l2, p1, p2
    real rowvector d
    string scalar  pal, pclass
    real matrix    T
    
    pal = strlower(strtrim(pal0))
    if (n>=.)        n = 15
    if (length(h)>0) h1 = h[1]
    if (length(h)>1) h2 = h[2]
    if (length(c)>0) c1 = c[1]
    if (length(c)>1) c2 = c[2]
    if (length(l)>0) l1 = l[1]
    if (length(l)>1) l2 = l[2]
    if (length(p)>0) p1 = p[1]
    if (length(p)>1) p2 = p[2]
    if (space=="hcl") {
    if      (smatch(pal, "qualitative")) d = (1,  15,   .,  60,   ., 70,  .,   .,   .)
    else if (smatch(pal, "intense"    )) d = (1,  15,   ., 100,   ., 65,  .,   .,   .)
    else if (smatch(pal, "dark"       )) d = (1,  15,   .,  80,   ., 60,  .,   .,   .)
    else if (smatch(pal, "light"      )) d = (1,  15,   .,  50,   ., 80,  .,   .,   .)
    else if (smatch(pal, "pastel"     )) d = (1,  15,   .,  35,   ., 85,  .,   .,   .)
    else if (smatch(pal, "sequential" )) d = (2, 260,   .,  80,  10, 25, 95,   1,   .)
    else if (smatch(pal, "blues"      )) d = (2, 260,   .,  80,  10, 25, 95,   1,   .)
    else if (smatch(pal, "greens"     )) d = (2, 145, 125,  80,  10, 25, 95,   1,   .)
    else if (smatch(pal, "grays"      )) d = (2,   0,   .,   0,   0, 15, 95,   1,   .)
    else if (smatch(pal, "oranges"    )) d = (2,  40,   ., 100,  10, 50, 95,   1,   .)
    else if (smatch(pal, "purples"    )) d = (2, 280,   .,  70,  10, 20, 95,   1,   .)
    else if (smatch(pal, "reds"       )) d = (2,  10,  20,  80,  10, 25, 95,   1,   .)
    else if (smatch(pal, "heat"       )) d = (2,   0,  90, 100,  30, 50, 90, 0.2, 1.0)
    else if (smatch(pal, "heat2"      )) d = (2,   0,  90,  80,  30, 30, 90, 0.2, 2.0)
    else if (smatch(pal, "terrain"    )) d = (2, 130,   0,  80,   0, 60, 95, 0.1, 1.0)
    else if (smatch(pal, "terrain2"   )) d = (2, 130,  30,  65,   0, 45, 90, 0.5, 1.5)
    else if (smatch(pal, "viridis"    )) d = (2, 300,  75,  35,  95, 15, 90, 0.8, 1.2)
    else if (smatch(pal, "plasma"     )) d = (2, 100, 100,  60, 100, 15, 95, 2.0, 0.9)
    else if (smatch(pal, "redblue"    )) d = (2,   0,-100,  80,  40, 40, 75, 1.0, 1.0)
    else if (smatch(pal, "diverging"  )) d = (3, 260,   0,  80,   ., 30, 95,   1,   .)
    else if (smatch(pal, "bluered"    )) d = (3, 260,   0,  80,   ., 30, 95,   1,   .)
    else if (smatch(pal, "bluered2"   )) d = (3, 260,   0, 100,   ., 50, 95,   1,   .)
    else if (smatch(pal, "bluered3"   )) d = (3, 180, 330,  60,   ., 75, 95,   1,   .)
    else if (smatch(pal, "greenorange")) d = (3, 130,  45, 100,   ., 70, 95,   1,   .)
    else if (smatch(pal, "browngreen" )) d = (3,  55, 160,  60,   ., 35, 95,   1,   .)
    else if (smatch(pal, "pinkgreen"  )) d = (3, 340, 128,  90,   ., 35, 95,   1,   .) 
    else if (smatch(pal, "purplegreen")) d = (3, 300, 128,  60,   ., 30, 95,   1,   .)
    else {
        display("{err}scheme '" + pal0 + "' not allowed")
        exit(3498)
    }
    }
    else if (space=="lch") {
    if      (smatch(pal, "qualitative")) d = (1,  28,   .,  35,   ., 70,  .,   .,   .)
    else if (smatch(pal, "intense"    )) d = (1,  28,   .,  57,   ., 65,  .,   .,   .)
    else if (smatch(pal, "dark"       )) d = (1,  28,   .,  47,   ., 60,  .,   .,   .)
    else if (smatch(pal, "light"      )) d = (1,  28,   .,  29,   ., 80,  .,   .,   .)
    else if (smatch(pal, "pastel"     )) d = (1,  28,   .,  21,   ., 85,  .,   .,   .)
    else if (smatch(pal, "sequential" )) d = (2, 290,   .,  72,   6, 25, 95,   1,   .)
    else if (smatch(pal, "blues"      )) d = (2, 290,   .,  72,   6, 25, 95,   1,   .)
    else if (smatch(pal, "greens"     )) d = (2, 157, 142,  95,   8, 25, 95,   1,   .)
    else if (smatch(pal, "grays"      )) d = (2,   0,   .,   0,   0, 15, 95,   1,   .)
    else if (smatch(pal, "oranges"    )) d = (2,  70,   .,  95,   6, 50, 95,   1,   .)
    else if (smatch(pal, "purples"    )) d = (2, 310,   .,  90,   7, 20, 95,   1,   .)
    else if (smatch(pal, "reds"       )) d = (2,  30,   .,  56,   6, 25, 95,   1,   .)
    else if (smatch(pal, "heat"       )) d = (2,   9, 112,  61,  21, 50, 90, 0.2, 1.0)
    else if (smatch(pal, "heat2"      )) d = (2,  10, 112,  54,  21, 30, 90, 0.2, 2.0)
    else if (smatch(pal, "terrain"    )) d = (2, 140,  10,  72,   0, 60, 95, 0.4, 1.0)
    else if (smatch(pal, "terrain2"   )) d = (2, 140,  40,  64,   0, 45, 90, 0.5, 1.5)
    else if (smatch(pal, "viridis"    )) d = (2, 324,  96,  49,  82, 15, 90, 1.0, 1.0)
    else if (smatch(pal, "plasma"     )) d = (2, 115, 115,  68,  86, 15, 95, 2.0, 0.9)
    else if (smatch(pal, "redblue"    )) d = (2,   9, -74,  52,  25, 40, 75, 1.0, 1.0)
    else if (smatch(pal, "diverging"  )) d = (3, 293,  10,  59,  .,  30, 95,   1,   .)
    else if (smatch(pal, "bluered"    )) d = (3, 293,  10,  59,  .,  30, 95,   1,   .)
    else if (smatch(pal, "bluered2"   )) d = (3, 293,  10,  64,  .,  50, 95,   1,   .)
    else if (smatch(pal, "bluered3"   )) d = (3, 186, 341,  45,  .,  75, 95,   1,   .)
    else if (smatch(pal, "greenorange")) d = (3, 140,  74,  85,  .,  70, 95,   1,   .)
    else if (smatch(pal, "browngreen" )) d = (3,  84, 171,  73,  .,  35, 95,   1,   .)
    else if (smatch(pal, "pinkgreen"  )) d = (3, 347, 128,  96,  .,  35, 95,   1,   .)
    else if (smatch(pal, "purplegreen")) d = (3, 324, 132,  68,  .,  30, 95,   1,   .)
    else {
        display("{err}scheme '" + pal0 + "' not allowed")
        exit(3498)
    }
    }
    else if (space=="jmh") {
    if      (smatch(pal, "qualitative")) d = (1,  25,   .,  24,  .,  73,  .,   .,   .)
    else if (smatch(pal, "intense"    )) d = (1,  25,   .,  34,  .,  67,  .,   .,   .)
    else if (smatch(pal, "dark"       )) d = (1,  25,   .,  30,  .,  62,  .,   .,   .)
    else if (smatch(pal, "light"      )) d = (1,  25,   .,  20,  .,  82,  .,   .,   .)
    else if (smatch(pal, "pastel"     )) d = (1,  25,   .,  16,  .,  87,  .,   .,   .)
    else if (smatch(pal, "sequential" )) d = (2, 255,   .,  32,  7,  25, 96,   1,   .)
    else if (smatch(pal, "blues"      )) d = (2, 255,   .,  32,  7,  25, 96,   1,   .)
    else if (smatch(pal, "greens"     )) d = (2, 145,   .,  56,  6,  24, 96,   1,   .)
    else if (smatch(pal, "grays"      )) d = (2,   0,   .,   0,  0,  18, 96,   1,   .)
    else if (smatch(pal, "oranges"    )) d = (2,  70,   .,  57,  3,  54, 96,   1,   .)
    else if (smatch(pal, "purples"    )) d = (2, 290,   .,  31,  6,  23, 96,   1,   .)
    else if (smatch(pal, "reds"       )) d = (2,  25,  25,  32,  3,  29, 96,   1,   .)
    else if (smatch(pal, "heat"       )) d = (2,   8, 111,  32, 11,  56, 91, 0.2, 1.0)
    else if (smatch(pal, "heat2"      )) d = (2,   8, 111,  32, 11,  35, 91, 0.2, 2.0)
    else if (smatch(pal, "terrain"    )) d = (2, 140,   8,  32,  0,  61, 96, 0.3, 1.0)
    else if (smatch(pal, "terrain2"   )) d = (2, 140,  30,  30,  0,  46, 91, 0.5, 1.5)
    else if (smatch(pal, "viridis"    )) d = (2, 323,  98,  24, 33,  19, 92, 1.0, 1.0)
    else if (smatch(pal, "plasma"     )) d = (2, 114, 116,  64, 35,  17, 95, 2.0, 0.9)
    else if (smatch(pal, "redblue"    )) d = (2,   8, -92,  39, 18,  45, 77, 1.0, 1.0)
    else if (smatch(pal, "diverging"  )) d = (3, 256,   8,  31,  .,  33, 96,   1,   .)
    else if (smatch(pal, "bluered"    )) d = (3, 256,   8,  31,  .,  33, 96,   1,   .)
    else if (smatch(pal, "bluered2"   )) d = (3, 256,   8,  33,  .,  53, 96,   1,   .)
    else if (smatch(pal, "bluered3"   )) d = (3, 189, 342,  25,  .,  77, 96,   1,   .)
    else if (smatch(pal, "greenorange")) d = (3, 140,  73,  35,  .,  72, 96,   1,   .)
    else if (smatch(pal, "browngreen" )) d = (3,  97, 171,  40,  .,  36, 96,   1,   .)
    else if (smatch(pal, "pinkgreen"  )) d = (3, 351, 127,  51,  .,  37, 96,   1,   .)
    else if (smatch(pal, "purplegreen")) d = (3, 322, 127,  39,  .,  32, 96,   1,   .)
    else {
        display("{err}scheme '" + pal0 + "' not allowed")
        exit(3498)
    }
    }
    if (h1>=.) h1 = d[2]
    if (h2>=.) h2 = (d[3]<. ? d[3] : (d[1]==1 ? h1 + 360*(n-1)/n : h1))
    if (c1>=.) c1 = d[4]
    if (c2>=.) c2 = (d[5]<. ? d[5] : c1)
    if (l1>=.) l1 = d[6]
    if (l2>=.) l2 = (d[7]<. ? d[7] : l1)
    if (p1>=.) p1 = d[8]
    if (p2>=.) p2 = (d[9]<. ? d[9] : p1)
    if      (d[1]==1) pclass = "qualitative"
    else if (d[1]==2) pclass = "sequential"
    else if (d[1]==3) pclass = "diverging"
    if (space=="hcl") S.generate(space+" "+pclass, n, (h1,h2), (c1,c2), (l1,l2), (p1,p2))
    else              S.generate(space+" "+pclass, n, (l1,l2), (c1,c2), (h1,h2), (p1,p2))
    st_local("palette", space + " " + pal)
}

void hsvgenerate(class ColrSpace scalar S, string scalar pal0,
    real scalar n, real vector h, real vector s, real vector v, real vector p)
{
    real scalar    h1, h2, s1, s2, v1, v2, p1, p2
    real rowvector d
    string scalar  pal, pclass
    real matrix    T
    
    pal = strlower(strtrim(pal0))
    if (n>=.)        n = 15
    if (length(h)>0) h1 = h[1]
    if (length(h)>1) h2 = h[2]
    if (length(s)>0) s1 = s[1]
    if (length(s)>1) s2 = s[2]
    if (length(v)>0) v1 = v[1]
    if (length(v)>1) v2 = v[2]
    if (length(p)>0) p1 = p[1]
    if (length(p)>1) p2 = p[2]
    if      (smatch(pal,"qualitative")) d = (1,   0,   ., .4,   ., .85,   .,   .,   .)
    else if (smatch(pal,"intense"    )) d = (1,   0,   ., .6,   ., .9 ,   .,   .,   .)
    else if (smatch(pal,"dark"       )) d = (1,   0,   ., .6,   ., .7 ,   .,   .,   .)
    else if (smatch(pal,"light"      )) d = (1,   0,   ., .3,   ., .9 ,   .,   .,   .)
    else if (smatch(pal,"pastel"     )) d = (1,   0,   ., .2,   ., .9 ,   .,   .,   .)
    else if (smatch(pal,"rainbow"    )) d = (1,   0,   .,  1,   .,  1 ,   .,   .,   .)
    else if (smatch(pal,"sequential" )) d = (2, 240,   ., .8, .05, .6 ,  1 , 1.2,   .)
    else if (smatch(pal,"blues"      )) d = (2, 240,   ., .8, .05, .6 ,  1 , 1.2,   .)
    else if (smatch(pal,"greens"     )) d = (2, 140, 120,  1, .1 , .3 ,  1 , 1.2,   .)
    else if (smatch(pal,"grays"      )) d = (2,   0,   .,  0,  0 , .1 , .95, 1  ,   .)
    else if (smatch(pal,"oranges"    )) d = (2,  30,   .,  1, .1 , .9 ,  1 , 1.2,   .)
    else if (smatch(pal,"purples"    )) d = (2, 270,   .,  1, .1 , .6 ,  1 , 1.2,   .)
    else if (smatch(pal,"reds"       )) d = (2,   0,  20,  1, .1 , .6 ,  1 , 1.2,   .)
    else if (smatch(pal,"heat"       )) d = (2,   0,  60,  1, .2 ,  1 ,  1 , 0.3,   .)
    else if (smatch(pal,"terrain"    )) d = (2, 120,   0,  1,  0 , .65, .95, 0.7, 1.5)
    else if (smatch(pal,"diverging"  )) d = (3, 240,   0, .8,   ., .6 , .95, 1.2,   .)
    else if (smatch(pal,"bluered"    )) d = (3, 240,   0, .8,   ., .6 , .95, 1.2,   .)
    else if (smatch(pal,"bluered2"   )) d = (3, 240,   0, .6,   ., .8 , .95, 1.2,   .)
    else if (smatch(pal,"bluered3"   )) d = (3, 175, 320, .6,   ., .8 , .95, 1.2,   .)
    else if (smatch(pal,"greenorange")) d = (3, 130,  40,  1,   ., .8 , .95, 1.2,   .)
    else if (smatch(pal,"browngreen" )) d = (3,  40, 150, .8,   ., .6 , .95, 1.2,   .)
    else if (smatch(pal,"pinkgreen"  )) d = (3, 330, 120, .9,   ., .6 , .95, 1.2,   .) 
    else if (smatch(pal,"purplegreen")) d = (3, 290, 120, .7,   ., .5 , .95, 1.2,   .)
    else if (smatch(pal,"heat0"      )) d = (4,   0,  60,  1,   0,  1 ,  . ,   .,   .)
    else if (smatch(pal,"terrain0"   )) d = (5, 120,   0,  1,   0, .65,  .9,   .,   .)
    else {
        display("{err}scheme '" + pal0 + "' not allowed")
        exit(3498)
    }
    if (h1>=.) h1 = d[2]
    if (h2>=.) h2 = (d[3]<. ? d[3] : (d[1]==1 ? 360*(n-1)/n : h1))
    if (s1>=.) s1 = d[4]
    if (s2>=.) s2 = (d[5]<. ? d[5] : s1)
    if (v1>=.) v1 = d[6]
    if (v2>=.) v2 = (d[7]<. ? d[7] : v1)
    if (p1>=.) p1 = d[8]
    if (p2>=.) p2 = (d[9]<. ? d[9] : p1)
    if      (d[1]==1) pclass = "qualitative"
    else if (d[1]==2) pclass = "sequential"
    else if (d[1]==3) pclass = "diverging"
    S.generate("hsv"+" "+pclass, n, (h1,h2), (s1,s2), (v1,v2), (p1,p2))
    st_local("palette", "hsv" + " " + pal)
}

real scalar smatch(string scalar A, string scalar B)
{
    if (A==substr(B, 1, strlen(A))) {
        A = B
        return(1)
    }
    return(0)
}

end

/*----------------------------------------------------------------------------*/
/* CMYK palettes; kept for backward compatibility; rest is in ColrSpace()     */
/*----------------------------------------------------------------------------*/

program colorpalette_Accent
c_local P .5 0 .5 0,.25 .25 0 0,0 .25 .4 0,0 0 .4 0,.8 .4 0 0,0 1 0 0,.25 .6 .9 0,0 0 0 .6
c_local note CMYK
c_local class "qualitative"
end

program colorpalette_Dark2
c_local P .9 0 .55 0,.15 .6 1 0,.55 .45 0 0,.05 .85 .05 0,.6 .1 1 0,.1 .3 1 0,.35 .45 .9 0,0 0 0 .6
c_local note CMYK
c_local class "qualitative"
end

program colorpalette_Paired
c_local P .35 .07 0 0,.9 .3 0 0,.3 0 .45 0,.8 0 1 0,0 .4 .25 0,.1 .9 .8 0,0 .25 .5 0,0 .5 1 0,.2 .25 0 0,.6 .7 0 0,0 0 .4 0,.23 .73 .98 .12
c_local note CMYK
c_local class "qualitative"
end

program colorpalette_Pastel1
c_local P 0 .3 .2 0,.3 .1 0 0,.2 0 .2 0,.12 .17 0 0,0 .15 .3 0,0 0 .2 0,.1 .12 .2 0,0 .15 0 0,0 0 0 .05
c_local note CMYK
c_local class "qualitative"
end

program colorpalette_Pastel2
c_local P .3 0 .15 0,0 .2 .25 0,.2 .1 0 0,.03 .2 0 0,.1 0 .2 0,0 .05 .3 0,.05 .1 .15 0,0 0 0 .2
c_local note CMYK
c_local class "qualitative"
end

program colorpalette_Set1
c_local P .1 .9 .8 0,.8 .3 0 0,.7 0 .8 0,.4 .65 0 0,0 .5 1 0,0 0 .8 0,.35 .6 .8 0,0 .5 0 0,0 0 0 .4
c_local note CMYK
c_local class "qualitative"
end

program colorpalette_Set2
c_local P .6 0 .3 0,0 .45 .5 0,.45 .25 0 0,.07 .45 0 0,.35 0 .7 0,0 .15 .8 0,.1 .2 .35 0,0 0 0 .3
c_local note CMYK
c_local class "qualitative"
end

program colorpalette_Set3
c_local P .45 0 .15 0,0 0 .3 0,.25 .2 0 0,0 .5 .4 0,.5 .15 0 0,0 .3 .55 0,.3 0 .6 0,0 .2 0 0,0 0 0 .15,.25 .45 0 0,.2 0 .2 0,0 .07 .55 0
c_local note CMYK
c_local class "qualitative"
end

program colorpalette_Blues
c_local P3 .13 .03 0 0,.38 .08 0 0,.82 .27 0 0
c_local P4 .08 .02 0 0,.28 .07 0 0,.57 .14 0 0,.9 .34 0 0
c_local P5 .08 .02 0 0,.28 .07 0 0,.57 .14 0 0,.82 .27 0 0,1 .45 0 .07
c_local P6 .08 .02 0 0,.24 .06 0 0,.38 .08 0 0,.57 .14 0 0,.82 .27 0 0,1 .45 0 .07
c_local P7 .08 .02 0 0,.24 .06 0 0,.38 .08 0 0,.57 .14 0 0,.75 .22 0 0,.9 .34 0 0,1 .55 0 .05
c_local P8 .03 .01 0 0,.13 .03 0 0,.24 .06 0 0,.38 .08 0 0,.57 .14 0 0,.75 .22 0 0,.9 .34 0 0,1 .55 0 .05
c_local P9 .03 .01 0 0,.13 .03 0 0,.24 .06 0 0,.38 .08 0 0,.57 .14 0 0,.75 .22 0 0,.9 .34 0 0,1 .45 0 .07,1 .55 0 .3
c_local note CMYK
c_local class "sequential"
end

program colorpalette_BuGn
c_local P3 .1 0 0 0,.4 0 .15 0,.83 0 .7 0
c_local P4 .07 0 0 0,.3 0 .05 0,.6 0 .3 0,.87 .1 .83 0
c_local P5 .07 0 0 0,.3 0 .05 0,.6 0 .3 0,.83 0 .7 0,1 .2 1 0
c_local P6 .07 0 0 0,.2 0 .06 0,.4 0 .15 0,.6 0 .3 0,.83 0 .7 0,1 .2 1 0
c_local P7 .07 0 0 0,.2 0 .06 0,.4 0 .15 0,.6 0 .3 0,.75 0 .55 0,.87 .1 .83 0,1 .35 1 0
c_local P8 .03 0 0 0,.1 0 0 0,.2 0 .06 0,.4 0 .15 0,.6 0 .3 0,.75 0 .55 0,.87 .1 .83 0,1 .35 1 0
c_local P9 .03 0 0 0,.1 0 0 0,.2 0 .06 0,.4 0 .15 0,.6 0 .3 0,.75 0 .55 0,.87 .1 .83 0,1 .2 1 0,1 .5 1 0
c_local note CMYK
c_local class "sequential"
end

program colorpalette_BuPu
c_local P3 .12 .03 0 0,.38 .14 0 0,.47 .6 0 0
c_local P4 .07 0 0 0,.3 .1 0 0,.45 .3 0 0,.47 .7 0 0
c_local P5 .07 0 0 0,.3 .1 0 0,.45 .3 0 0,.47 .6 0 0,.47 .95 0 .05
c_local P6 .07 0 0 0,.25 .09 0 0,.38 .14 0 0,.45 .3 0 0,.47 .6 0 0,.47 .95 0 .05
c_local P7 .07 0 0 0,.25 .09 0 0,.38 .14 0 0,.45 .3 0 0,.45 .5 0 0,.47 .7 0 0,.5 1 0 .15
c_local P8 .03 0 0 0,.12 .03 0 0,.25 .09 0 0,.38 .14 0 0,.45 .3 0 0,.45 .5 0 0,.47 .7 0 0,.5 1 0 .15
c_local P9 .03 0 0 0,.12 .03 0 0,.25 .09 0 0,.38 .14 0 0,.45 .3 0 0,.45 .5 0 0,.47 .7 0 0,.47 .95 0 .05,.5 1 0 .4
c_local note CMYK
c_local class "sequential"
end

program colorpalette_GnBu
c_local P3 .12 0 .12 0,.34 0 .25 0,.75 .12 0 0
c_local P4 .06 0 .08 0,.27 0 .23 0,.52 0 .15 0,.8 .2 0 0
c_local P5 .06 0 .08 0,.27 0 .23 0,.52 0 .15 0,.75 .12 0 0,1 .35 0 0
c_local P6 .06 0 .08 0,.2 0 .2 0,.34 0 .25 0,.52 0 .15 0,.75 .12 0 0,1 .35 0 0
c_local P7 .06 0 .08 0,.2 0 .2 0,.34 0 .25 0,.52 0 .15 0,.7 .05 0 0,.85 .2 0 0,1 .42 0 .05
c_local P8 .03 0 .05 0,.12 0 .12 0,.2 0 .2 0,.34 0 .25 0,.52 0 .15 0,.7 .05 0 0,.85 .2 0 0,1 .42 0 .05
c_local P9 .03 0 .05 0,.12 0 .12 0,.2 0 .2 0,.34 0 .25 0,.52 0 .15 0,.7 .05 0 0,.85 .2 0 0,1 .35 0 0,1 .5 0 .2
c_local note CMYK
c_local class "sequential"
end

program colorpalette_Greens
c_local P3 .1 0 .1 0,.37 0 .37 0,.81 0 .76 0
c_local P4 .07 0 .07 0,.27 0 .27 0,.55 0 .55 0,.84 .1 .83 0
c_local P5 .07 0 .07 0,.27 0 .27 0,.55 0 .55 0,.81 0 .76 0,1 .2 1 0
c_local P6 .07 0 .07 0,.22 0 .22 0,.37 0 .37 0,.55 0 .55 0,.81 0 .76 0,1 .2 1 0
c_local P7 .07 0 .07 0,.22 0 .22 0,.37 0 .37 0,.55 0 .55 0,.75 0 .7 0,.87 .1 .83 0,1 .35 .9 0
c_local P8 .03 0 .03 0,.1 0 .1 0,.22 0 .22 0,.37 0 .37 0,.55 0 .55 0,.75 0 .7 0,.87 .1 .83 0,1 .35 .9 0
c_local P9 .03 0 .03 0,.1 0 .1 0,.22 0 .22 0,.37 0 .37 0,.55 0 .55 0,.75 0 .7 0,.87 .1 .83 0,1 .2 1 0,1 .5 1 0
c_local note CMYK
c_local class "sequential"
end

program colorpalette_Greys
c_local P3 0 0 0 .06,0 0 0 .26,0 0 0 .61
c_local P4 0 0 0 .03,0 0 0 .2,0 0 0 .41,0 0 0 .68
c_local P5 0 0 0 .03,0 0 0 .2,0 0 0 .41,0 0 0 .61,0 0 0 .85
c_local P6 0 0 0 .03,0 0 0 .15,0 0 0 .26,0 0 0 .41,0 0 0 .61,0 0 0 .85
c_local P7 0 0 0 .03,0 0 0 .15,0 0 0 .26,0 0 0 .41,0 0 0 .55,0 0 0 .68,0 0 0 .85
c_local P8 0 0 0 0,0 0 0 .06,0 0 0 .15,0 0 0 .26,0 0 0 .41,0 0 0 .55,0 0 0 .68,0 0 0 .85
c_local P9 0 0 0 0,0 0 0 .06,0 0 0 .15,0 0 0 .26,0 0 0 .41,0 0 0 .55,0 0 0 .68,0 0 0 .85,0 0 0 1
c_local note CMYK
c_local class "sequential"
end

program colorpalette_OrRd
c_local P3 0 .09 .18 0,0 .27 .4 0,.1 .7 .7 0
c_local P4 0 .06 .12 0,0 .2 .4 0,0 .45 .55 0,.15 .8 .8 0
c_local P5 0 .06 .12 0,0 .2 .4 0,0 .45 .55 0,.1 .7 .7 0,.3 1 1 0
c_local P6 0 .06 .12 0,0 .17 .32 0,0 .27 .4 0,0 .45 .55 0,.1 .7 .7 0,.3 1 1 0
c_local P7 0 .06 .12 0,0 .17 .32 0,0 .27 .4 0,0 .45 .55 0,.05 .6 .6 0,.15 .8 .8 0,.4 1 1 0
c_local P8 0 .03 .06 0,0 .09 .18 0,0 .17 .32 0,0 .27 .4 0,0 .45 .55 0,.05 .6 .6 0,.15 .8 .8 0,.4 1 1 0
c_local P9 0 .03 .06 0,0 .09 .18 0,0 .17 .32 0,0 .27 .4 0,0 .45 .55 0,.05 .6 .6 0,.15 .8 .8 0,.3 1 1 0,.5 1 1 0
c_local note CMYK
c_local class "sequential"
end

program colorpalette_Oranges
c_local P3 0 .1 .15 0,0 .32 .5 0,.1 .65 .95 0
c_local P4 0 .07 .1 0,0 .26 .4 0,0 .45 .7 0,.15 .7 1 0
c_local P5 0 .07 .1 0,0 .26 .4 0,0 .45 .7 0,.1 .65 .95 0,.35 .75 1 0
c_local P6 0 .07 .1 0,0 .19 .3 0,0 .32 .5 0,0 .45 .7 0,.1 .65 .95 0,.35 .75 1 0
c_local P7 0 .07 .1 0,0 .19 .3 0,0 .32 .5 0,0 .45 .7 0,.05 .58 .9 0,.15 .7 1 0,.45 .78 1 0
c_local P8 0 .04 .06 0,0 .1 .15 0,0 .19 .3 0,0 .32 .5 0,0 .45 .7 0,.05 .58 .9 0,.15 .7 1 0,.45 .78 1 0
c_local P9 0 .04 .06 0,0 .1 .15 0,0 .19 .3 0,0 .32 .5 0,0 .45 .7 0,.05 .58 .9 0,.15 .7 1 0,.35 .75 1 0,.5 .8 1 0
c_local note CMYK
c_local class "sequential"
end

program colorpalette_PuBu
c_local P3 .07 .07 0 0,.35 .15 0 0,.85 .2 0 0
c_local P4 .05 .05 0 0,.26 .13 0 0,.55 .17 0 0,1 .3 0 0
c_local P5 .05 .05 0 0,.26 .13 0 0,.55 .17 0 0,.85 .2 0 0,1 .3 0 .2
c_local P6 .05 .05 0 0,.18 .12 0 0,.35 .15 0 0,.55 .17 0 0,.85 .2 0 0,1 .3 0 .2
c_local P7 .05 .05 0 0,.18 .12 0 0,.35 .15 0 0,.55 .17 0 0,.8 .2 0 0,1 .3 0 0,1 .3 0 .3
c_local P8 0 .03 0 0,.07 .07 0 0,.18 .12 0 0,.35 .15 0 0,.55 .17 0 0,.8 .2 0 0,1 .3 0 0,1 .3 0 .3
c_local P9 0 .03 0 0,.07 .07 0 0,.18 .12 0 0,.35 .15 0 0,.55 .17 0 0,.8 .2 0 0,1 .3 0 0,1 .3 0 .2,1 .3 0 .5
c_local note CMYK
c_local class "sequential"
end

program colorpalette_PuBuGn
c_local P3 .07 .09 0 0,.35 .15 0 0,.9 .12 .27 0
c_local P4 .03 .05 0 0,.26 .13 0 0,.6 .15 0 0,1 .15 .35 0
c_local P5 .03 .05 0 0,.26 .13 0 0,.6 .15 0 0,.9 .12 .27 0,1 .25 .65 0
c_local P6 .03 .05 0 0,.18 .12 0 0,.35 .15 0 0,.6 .15 0 0,.9 .12 .27 0,1 .25 .65 0
c_local P7 .03 .05 0 0,.18 .12 0 0,.35 .15 0 0,.6 .15 0 0,.8 .2 0 0,1 .15 .35 0,1 .3 .7 0
c_local P8 0 .03 0 0,.07 .09 0 0,.18 .12 0 0,.35 .15 0 0,.6 .15 0 0,.8 .2 0 0,1 .15 .35 0,1 .3 .7 0
c_local P9 0 .03 0 0,.07 .09 0 0,.18 .12 0 0,.35 .15 0 0,.6 .15 0 0,.8 .2 0 0,1 .15 .35 0,1 .25 .65 0,1 .5 .8 0
c_local note CMYK
c_local class "sequential"
end

program colorpalette_PuRd
c_local P3 .09 .09 0 0,.2 .38 0 0,.1 .9 .15 0
c_local P4 .05 .05 0 0,.15 .25 0 0,.1 .6 0 0,.17 .95 .35 0
c_local P5 .05 .05 0 0,.15 .25 0 0,.1 .6 0 0,.1 .9 .15 0,.4 1 .47 0
c_local P6 .05 .05 0 0,.16 .23 0 0,.2 .38 0 0,.1 .6 0 0,.1 .9 .15 0,.4 1 .47 0
c_local P7 .05 .05 0 0,.16 .23 0 0,.2 .38 0 0,.1 .6 0 0,.05 .85 .05 0,.17 .95 .35 0,.43 1 .5 0
c_local P8 .03 .03 0 0,.09 .09 0 0,.16 .23 0 0,.2 .38 0 0,.1 .6 0 0,.05 .85 .05 0,.17 .95 .35 0,.43 1 .5 0
c_local P9 .03 .03 0 0,.09 .09 0 0,.16 .23 0 0,.2 .38 0 0,.1 .6 0 0,.05 .85 .05 0,.17 .95 .35 0,.4 1 .47 0,.6 1 .75 0
c_local note CMYK
c_local class "sequential"
end

program colorpalette_Purples
c_local P3 .06 .05 0 0,.28 .18 0 0,.55 .48 0 0
c_local P4 .05 .04 0 0,.2 .15 0 0,.38 .3 0 0,.6 .6 0 0
c_local P5 .05 .04 0 0,.2 .15 0 0,.38 .3 0 0,.55 .48 0 0,.7 .8 0 0
c_local P6 .05 .04 0 0,.14 .1 0 0,.26 .18 0 0,.38 .3 0 0,.55 .48 0 0,.7 .8 0 0
c_local P7 .05 .04 0 0,.14 .1 0 0,.26 .18 0 0,.38 .3 0 0,.5 .4 0 0,.6 .6 0 0,.75 .9 0 0
c_local P8 .01 .01 0 0,.06 .05 0 0,.14 .1 0 0,.26 .18 0 0,.38 .3 0 0,.5 .4 0 0,.6 .6 0 0,.75 .9 0 0
c_local P9 .01 .01 0 0,.06 .05 0 0,.14 .1 0 0,.26 .18 0 0,.38 .3 0 0,.5 .4 0 0,.6 .6 0 0,.7 .8 0 0,.8 1 0 0
c_local note CMYK
c_local class "sequential"
end

program colorpalette_RdPu
c_local P3 0 .12 .08 0,0 .38 .12 0,.2 .9 0 0
c_local P4 0 .08 .08 0,0 .3 .15 0,0 .6 .1 0,.3 1 0 0
c_local P5 0 .08 .08 0,0 .3 .15 0,0 .6 .1 0,.2 .9 0 0,.5 1 0 .05
c_local P6 0 .08 .08 0,0 .23 .15 0,0 .38 .12 0,0 .6 .1 0,.2 .9 0 0,.5 1 0 .05
c_local P7 0 .08 .08 0,0 .23 .15 0,0 .38 .12 0,0 .6 .1 0,.1 .8 0 0,.3 1 0 0,.5 1 0 .05
c_local P8 0 .03 .03 0,0 .12 .08 0,0 .23 .15 0,0 .38 .12 0,0 .6 .1 0,.1 .8 0 0,.3 1 0 0,.5 1 0 .05
c_local P9 0 .03 .03 0,0 .12 .08 0,0 .23 .15 0,0 .38 .12 0,0 .6 .1 0,.1 .8 0 0,.3 1 0 0,.5 1 0 .05,.7 1 0 .15
c_local note CMYK
c_local class "sequential"
end

program colorpalette_Reds
c_local P3 0 .12 .12 0,0 .43 .43 0,.12 .82 .75 0
c_local P4 0 .1 .1 0,0 .32 .32 0,0 .59 .59 0,.2 .9 .8 0
c_local P5 0 .1 .1 0,0 .32 .32 0,0 .59 .59 0,.12 .82 .75 0,.35 .95 .85 0
c_local P6 0 .1 .1 0,0 .27 .27 0,0 .43 .43 0,0 .59 .59 0,.12 .82 .75 0,.35 .95 .85 0
c_local P7 0 .1 .1 0,0 .27 .27 0,0 .43 .43 0,0 .59 .59 0,.05 .77 .72 0,.2 .9 .8 0,.4 1 .9 0
c_local P8 0 .04 .04 0,0 .12 .12 0,0 .27 .27 0,0 .43 .43 0,0 .59 .59 0,.05 .77 .72 0,.2 .9 .8 0,.4 1 .9 0
c_local P9 0 .04 .04 0,0 .12 .12 0,0 .27 .27 0,0 .43 .43 0,0 .59 .59 0,.05 .77 .72 0,.2 .9 .8 0,.35 .95 .85 0,.6 1 .9 0
c_local note CMYK
c_local class "sequential"
end

program colorpalette_YlGn
c_local P3 .03 0 .27 0,.32 0 .43 0,.81 0 .76 0
c_local P4 0 0 .2 0,.24 0 .39 0,.53 0 .53 0,.87 .1 .83 0
c_local P5 0 0 .2 0,.24 0 .39 0,.53 0 .53 0,.81 0 .76 0,1 .25 .9 0
c_local P6 0 0 .2 0,.15 0 .35 0,.32 0 .43 0,.53 0 .53 0,.81 0 .76 0,1 .25 .9 0
c_local P7 0 0 .2 0,.15 0 .35 0,.32 0 .43 0,.53 0 .53 0,.75 0 .7 0,.87 .15 .83 0,1 .35 .9 0
c_local P8 0 0 .1 0,.03 0 .27 0,.15 0 .35 0,.32 0 .43 0,.53 0 .53 0,.75 0 .7 0,.87 .15 .83 0,1 .35 .9 0
c_local P9 0 0 .1 0,.03 0 .27 0,.15 0 .35 0,.32 0 .43 0,.53 0 .53 0,.75 0 .7 0,.87 .15 .83 0,1 .25 .9 0,1 .5 .9 0
c_local note CMYK
c_local class "sequential"
end

program colorpalette_YlGnBu
c_local P3 .07 0 .3 0,.5 0 .2 0,.85 .27 0 0
c_local P4 0 0 .2 0,.37 0 .25 0,.75 0 .1 0,.9 .45 0 0
c_local P5 0 0 .2 0,.37 0 .25 0,.75 0 .1 0,.85 .27 0 0,.9 .7 0 0
c_local P6 0 0 .2 0,.22 0 .27 0,.5 0 .2 0,.75 0 .1 0,.85 .27 0 0,.9 .7 0 0
c_local P7 0 0 .2 0,.22 0 .27 0,.5 0 .2 0,.75 0 .1 0,.9 .15 0 0,.9 .45 0 0,1 .7 0 .1
c_local P8 0 0 .15 0,.07 0 .3 0,.22 0 .27 0,.5 0 .2 0,.75 0 .1 0,.9 .15 0 0,.9 .45 0 0,1 .7 0 .1
c_local P9 0 0 .15 0,.07 0 .3 0,.22 0 .27 0,.5 0 .2 0,.75 0 .1 0,.9 .15 0 0,.9 .45 0 0,.9 .7 0 0,1 .7 0 .4
c_local note CMYK
c_local class "sequential"
end

program colorpalette_YlOrBr
c_local P3 0 .03 .25 0,0 .23 .65 0,.15 .6 .95 0
c_local P4 0 0 .17 0,0 .15 .4 0,0 .4 .8 0,.2 .67 1 0
c_local P5 0 0 .17 0,0 .15 .4 0,0 .4 .8 0,.15 .6 .95 0,.4 .75 1 0
c_local P6 0 0 .17 0,0 .11 .4 0,0 .23 .65 0,0 .4 .8 0,.15 .6 .95 0,.4 .75 1 0
c_local P7 0 0 .17 0,0 .11 .4 0,0 .23 .65 0,0 .4 .8 0,.07 .55 .9 0,.2 .67 1 0,.45 .78 1 0
c_local P8 0 0 .1 0,0 .03 .25 0,0 .11 .4 0,0 .23 .65 0,0 .4 .8 0,.07 .55 .9 0,.2 .67 1 0,.45 .78 1 0
c_local P9 0 0 .1 0,0 .03 .25 0,0 .11 .4 0,0 .23 .65 0,0 .4 .8 0,.07 .55 .9 0,.2 .67 1 0,.4 .75 1 0,.6 .8 1 0
c_local note CMYK
c_local class "sequential"
end

program colorpalette_YlOrRd
c_local P3 0 .07 .35 0,0 .3 .65 0,.05 .77 .8 0
c_local P4 0 0 .3 0,0 .2 .6 0,0 .45 .7 0,.1 .9 .8 0
c_local P5 0 0 .3 0,0 .2 .6 0,0 .45 .7 0,.05 .77 .8 0,.25 1 .7 0
c_local P6 0 0 .3 0,0 .15 .5 0,0 .3 .65 0,0 .45 .7 0,.05 .77 .8 0,.25 1 .7 0
c_local P7 0 0 .3 0,0 .15 .5 0,0 .3 .65 0,0 .45 .7 0,0 .7 .75 0,.1 .9 .8 0,.3 1 .7 0
c_local P8 0 0 .2 0,0 .07 .35 0,0 .15 .5 0,0 .3 .65 0,0 .45 .7 0,0 .7 .75 0,.1 .9 .8 0,.3 1 .7 0
c_local P9 0 0 .2 0,0 .07 .35 0,0 .15 .5 0,0 .3 .65 0,0 .45 .7 0,0 .7 .75 0,.1 .9 .8 0,.25 1 .7 0,.5 1 .7 0
c_local note CMYK
c_local class "sequential"
end

program colorpalette_BrBG
c_local P3 .15 .25 .55 0,0 0 0 .05,.65 .05 .23 0
c_local P4 .35 .55 .9 0,.12 .2 .45 0,.5 0 .17 0,1 .1 .55 0
c_local P5 .35 .55 .9 0,.12 .2 .45 0,0 0 0 .05,.5 0 .17 0,1 .1 .55 0
c_local P6 .45 .6 1 0,.15 .25 .55 0,.03 .08 .2 0,.22 0 .06 0,.65 .05 .23 0,1 .3 .6 0
c_local P7 .45 .6 1 0,.15 .25 .55 0,.03 .08 .2 0,0 0 0 .05,.22 0 .06 0,.65 .05 .23 0,1 .3 .6 0
c_local P8 .45 .6 1 0,.25 .43 .8 0,.12 .2 .45 0,.03 .08 .2 0,.22 0 .06 0,.5 0 .17 0,.8 .12 .35 0,1 .3 .6 0
c_local P9 .45 .6 1 0,.25 .43 .8 0,.12 .2 .45 0,.03 .08 .2 0,0 0 0 .05,.22 0 .06 0,.5 0 .17 0,.8 .12 .35 0,1 .3 .6 0
c_local P10 .45 .6 1 .4,.45 .6 1 0,.25 .43 .8 0,.12 .2 .45 0,.03 .08 .2 0,.22 0 .06 0,.5 0 .17 0,.8 .12 .35 0,1 .3 .6 0,1 .3 .7 .4
c_local P11 .45 .6 1 .4,.45 .6 1 0,.25 .43 .8 0,.12 .2 .45 0,.03 .08 .2 0,0 0 0 .05,.22 0 .06 0,.5 0 .17 0,.8 .12 .35 0,1 .3 .6 0,1 .3 .7 .4
c_local note CMYK
c_local class "diverging"
end

program colorpalette_PRGn
c_local P3 .31 .38 0 0,0 0 0 .03,.5 .05 .5 0
c_local P4 .53 .77 0 0,.23 .3 0 0,.35 0 .35 0,1 0 1 0
c_local P5 .53 .77 0 0,.23 .3 0 0,0 0 0 .03,.35 0 .35 0,1 0 1 0
c_local P6 .55 .8 .1 0,.31 .38 0 0,.09 .14 0 0,.15 0 .15 0,.5 .05 .5 0,.9 .2 .9 0
c_local P7 .55 .8 .1 0,.31 .38 0 0,.09 .14 0 0,0 0 0 .03,.15 0 .15 0,.5 .05 .5 0,.9 .2 .9 0
c_local P8 .55 .8 .1 0,.4 .49 .05 0,.23 .3 0 0,.09 .14 0 0,.15 0 .15 0,.35 0 .35 0,.65 .05 .65 0,.9 .2 .9 0
c_local P9 .55 .8 .1 0,.4 .49 .05 0,.23 .3 0 0,.09 .14 0 0,0 0 0 .03,.15 0 .15 0,.35 0 .35 0,.65 .05 .65 0,.9 .2 .9 0
c_local P10 .6 1 0 .4,.55 .8 .1 0,.4 .49 .05 0,.23 .3 0 0,.09 .14 0 0,.15 0 .15 0,.35 0 .35 0,.65 .05 .65 0,.9 .2 .9 0,1 .5 1 0
c_local P11 .6 1 0 .4,.55 .8 .1 0,.4 .49 .05 0,.23 .3 0 0,.09 .14 0 0,0 0 0 .03,.15 0 .15 0,.35 0 .35 0,.65 .05 .65 0,.9 .2 .9 0,1 .5 1 0
c_local note CMYK
c_local class "diverging"
end

program colorpalette_PiYG
c_local P3 .07 .35 .03 0,0 0 0 .03,.37 0 .6 0
c_local P4 .15 .9 0 0,.04 .28 0 0,.28 0 .47 0,.7 0 1 0
c_local P5 .15 .9 0 0,.04 .28 0 0,0 0 0 .03,.28 0 .47 0,.7 0 1 0
c_local P6 .2 .9 .1 0,.07 .35 .03 0,0 .12 0 0,.1 0 .17 0,.37 0 .6 0,.7 .15 1 0
c_local P7 .2 .9 .1 0,.07 .35 .03 0,0 .12 0 0,0 0 0 .03,.1 0 .17 0,.37 0 .6 0,.7 .15 1 0
c_local P8 .2 .9 .1 0,.11 .52 .06 0,.04 .28 0 0,0 .12 0 0,.1 0 .17 0,.28 0 .47 0,.5 .05 .8 0,.7 .15 1 0
c_local P9 .2 .9 .1 0,.11 .52 .06 0,.04 .28 0 0,0 .12 0 0,0 0 0 .03,.1 0 .17 0,.28 0 .47 0,.5 .05 .8 0,.7 .15 1 0
c_local P10 .1 1 0 .35,.2 .9 .1 0,.11 .52 .06 0,.04 .28 0 0,0 .12 0 0,.1 0 .17 0,.28 0 .47 0,.5 .05 .8 0,.7 .15 1 0,.75 0 1 .4
c_local P11 .1 1 0 .35,.2 .9 .1 0,.11 .52 .06 0,.04 .28 0 0,0 .12 0 0,0 0 0 .03,.1 0 .17 0,.28 0 .47 0,.5 .05 .8 0,.7 .15 1 0,.75 0 1 .4
c_local note CMYK
c_local class "diverging"
end

program colorpalette_PuOr
c_local P3 .05 .35 .7 0,0 0 0 .03,.4 .35 0 0
c_local P4 .1 .6 1 0,0 .28 .55 0,.3 .25 0 0,.65 .7 0 0
c_local P5 .1 .6 1 0,0 .28 .55 0,0 0 0 .03,.3 .25 0 0,.65 .7 0 0
c_local P6 .3 .6 1 0,.05 .35 .7 0,0 .12 .24 0,.15 .1 0 0,.4 .35 0 0,.7 .8 .05 0
c_local P7 .3 .6 1 0,.05 .35 .7 0,0 .12 .24 0,0 0 0 .03,.15 .1 0 0,.4 .35 0 0,.7 .8 .05 0
c_local P8 .3 .6 1 0,.12 .46 .92 0,0 .28 .55 0,0 .12 .24 0,.15 .1 0 0,.3 .25 0 0,.5 .45 .05 0,.7 .8 .05 0
c_local P9 .3 .6 1 0,.12 .46 .92 0,0 .28 .55 0,0 .12 .24 0,0 0 0 .03,.15 .1 0 0,.3 .25 0 0,.5 .45 .05 0,.7 .8 .05 0
c_local P10 .5 .7 1 0,.3 .6 1 0,.12 .46 .92 0,0 .28 .55 0,0 .12 .24 0,.15 .1 0 0,.3 .25 0 0,.5 .45 .05 0,.7 .8 .05 0,.75 1 0 .4
c_local P11 .5 .7 1 0,.3 .6 1 0,.12 .46 .92 0,0 .28 .55 0,0 .12 .24 0,0 0 0 .03,.15 .1 0 0,.3 .25 0 0,.5 .45 .05 0,.7 .8 .05 0,.75 1 0 .4
c_local note CMYK
c_local class "diverging"
end

program colorpalette_RdBu
c_local P3 .05 .45 .5 0,0 0 0 .03,.6 .15 0 0
c_local P4 .2 1 .75 0,.03 .35 .38 0,.43 .08 0 0,1 .3 0 0
c_local P5 .2 1 .75 0,.03 .35 .38 0,0 0 0 .03,.43 .08 0 0,1 .3 0 0
c_local P6 .3 .9 .7 0,.05 .45 .5 0,0 .14 .16 0,.18 .04 0 0,.6 .15 0 0,.9 .4 0 0
c_local P7 .3 .9 .7 0,.05 .45 .5 0,0 .14 .16 0,0 0 0 .03,.18 .04 0 0,.6 .15 0 0,.9 .4 0 0
c_local P8 .3 .9 .7 0,.15 .6 .57 0,.03 .35 .38 0,0 .14 .16 0,.18 .04 0 0,.43 .08 0 0,.75 .2 0 0,.9 .4 0 0
c_local P9 .3 .9 .7 0,.15 .6 .57 0,.03 .35 .38 0,0 .14 .16 0,0 0 0 .03,.18 .04 0 0,.43 .08 0 0,.75 .2 0 0,.9 .4 0 0
c_local P10 .6 1 .75 0,.3 .9 .7 0,.15 .6 .57 0,.03 .35 .38 0,0 .14 .16 0,.18 .04 0 0,.43 .08 0 0,.75 .2 0 0,.9 .4 0 0,1 .5 0 .4
c_local P11 .6 1 .75 0,.3 .9 .7 0,.15 .6 .57 0,.03 .35 .38 0,0 .14 .16 0,0 0 0 .03,.18 .04 0 0,.43 .08 0 0,.75 .2 0 0,.9 .4 0 0,1 .5 0 .4
c_local note CMYK
c_local class "diverging"
end

program colorpalette_RdGy
c_local P3 .05 .45 .5 0,0 0 0 0,0 0 0 .4
c_local P4 .2 1 .75 0,.03 .35 .38 0,0 0 0 .27,0 0 0 .75
c_local P5 .2 1 .75 0,.03 .35 .38 0,0 0 0 0,0 0 0 .27,0 0 0 .75
c_local P6 .3 .9 .7 0,.05 .45 .5 0,0 .14 .16 0,0 0 0 .12,0 0 0 .4,0 0 0 .7
c_local P7 .3 .9 .7 0,.05 .45 .5 0,0 .14 .16 0,0 0 0 0,0 0 0 .12,0 0 0 .4,0 0 0 .7
c_local P8 .3 .9 .7 0,.15 .6 .57 0,.03 .35 .38 0,0 .14 .16 0,0 0 0 .12,0 0 0 .27,0 0 0 .47,0 0 0 .7
c_local P9 .3 .9 .7 0,.15 .6 .57 0,.03 .35 .38 0,0 .14 .16 0,0 0 0 0,0 0 0 .12,0 0 0 .27,0 0 0 .47,0 0 0 .7
c_local P10 .6 1 .75 0,.3 .9 .7 0,.15 .6 .57 0,.03 .35 .38 0,0 .14 .16 0,0 0 0 .12,0 0 0 .27,0 0 0 .47,0 0 0 .7,0 0 0 .9
c_local P11 .6 1 .75 0,.3 .9 .7 0,.15 .6 .57 0,.03 .35 .38 0,0 .14 .16 0,0 0 0 0,0 0 0 .12,0 0 0 .27,0 0 0 .47,0 0 0 .7,0 0 0 .9
c_local note CMYK
c_local class "diverging"
end

program colorpalette_RdYlBu
c_local P3 0 .45 .55 0,0 0 .25 0,.43 .11 0 0
c_local P4 .15 .9 .8 0,0 .32 .55 0,.33 .03 0 0,.85 .3 0 0
c_local P5 .15 .9 .8 0,0 .32 .55 0,0 0 .25 0,.33 .03 0 0,.85 .3 0 0
c_local P6 .15 .8 .75 0,0 .45 .55 0,0 .12 .4 0,.12 0 0 0,.43 .11 0 0,.75 .37 0 0
c_local P7 .15 .8 .75 0,0 .45 .55 0,0 .12 .4 0,0 0 .25 0,.12 0 0 0,.43 .11 0 0,.75 .37 0 0
c_local P8 .15 .8 .75 0,.03 .57 .63 0,0 .32 .55 0,0 .12 .4 0,.12 0 0 0,.33 .03 0 0,.55 .15 0 0,.75 .37 0 0
c_local P9 .15 .8 .75 0,.03 .57 .63 0,0 .32 .55 0,0 .12 .4 0,0 0 .25 0,.12 0 0 0,.33 .03 0 0,.55 .15 0 0,.75 .37 0 0
c_local P10 .35 1 .7 0,.15 .8 .75 0,.03 .57 .63 0,0 .32 .55 0,0 .12 .4 0,.12 0 0 0,.33 .03 0 0,.55 .15 0 0,.75 .37 0 0,.85 .7 0 0
c_local P11 .35 1 .7 0,.15 .8 .75 0,.03 .57 .63 0,0 .35 .55 0,0 .12 .4 0,0 0 .25 0,.12 0 0 0,.33 .03 0 0,.55 .15 0 0,.75 .37 0 0,.85 .7 0 0
c_local note CMYK
c_local class "diverging"
end

program colorpalette_RdYlGn
c_local P3 0 .45 .55 0,0 0 .25 0,.43 0 .65 0
c_local P4 .15 .9 .8 0,0 .32 .55 0,.35 0 .6 0,.9 0 .9 0
c_local P5 .15 .9 .8 0,0 .35 .55 0,0 0 .25 0,.35 0 .6 0,.9 0 .9 0
c_local P6 .15 .8 .75 0,0 .45 .55 0,0 .12 .42 0,.15 0 .45 0,.43 0 .65 0,.9 0 .9 0
c_local P7 .15 .8 .75 0,0 .45 .55 0,0 .12 .42 0,0 0 .25 0,.15 0 .45 0,.43 0 .65 0,.9 0 .8 0
c_local P8 .15 .8 .75 0,.03 .57 .63 0,0 .32 .55 0,0 .12 .42 0,.15 0 .45 0,.35 0 .6 0,.6 0 .65 0,.9 0 .8 0
c_local P9 .15 .8 .75 0,.03 .57 .63 0,0 .32 .55 0,0 .12 .42 0,0 0 .25 0,.15 0 .45 0,.35 0 .6 0,.6 0 .65 0,.9 0 .8 0
c_local P10 .35 1 .7 0,.15 .8 .75 0,.03 .57 .63 0,0 .32 .55 0,0 .12 .42 0,.15 0 .45 0,.35 0 .6 0,.6 0 .65 0,.9 0 .8 0,1 .25 .9 0
c_local P11 .35 1 .75 0,.15 .8 .75 0,.03 .57 .63 0,0 .32 .55 0,0 .12 .42 0,0 0 .25 0,.15 0 .45 0,.35 0 .6 0,.6 0 .65 0,.9 0 .8 0,1 .25 .9 0
c_local note CMYK
c_local class "diverging"
end

program colorpalette_Spectral
c_local P3 0 .45 .55 0,0 0 .25 0,.4 0 .4 0
c_local P4 .15 .9 .8 0,0 .32 .55 0,.33 0 .33 0,.85 .25 0 0
c_local P5 .15 .9 .8 0,0 .32 .55 0,0 0 .25 0,.33 0 .33 0,.85 .25 0 0
c_local P6 .15 .75 .5 0,0 .45 .55 0,0 .12 .42 0,.1 0 .4 0,.4 0 .4 0,.82 .23 0 0
c_local P7 .15 .75 .5 0,0 .45 .55 0,0 .12 .42 0,0 0 .25 0,.1 0 .4 0,.4 0 .4 0,.82 .23 0 0
c_local P8 .15 .75 .5 0,.03 .57 .53 0,0 .32 .55 0,0 .12 .42 0,.1 0 .4 0,.33 0 .33 0,.6 0 .3 0,.82 .23 0 0
c_local P9 .15 .75 .5 0,.03 .57 .63 0,0 .32 .55 0,0 .12 .42 0,0 0 .25 0,.1 0 .4 0,.33 0 .33 0,.6 0 .3 0,.82 .23 0 0
c_local P10 0 1 .2 .35,.15 .75 .5 0,.03 .57 .63 0,0 .32 .55 0,0 .12 .42 0,.1 0 .4 0,.33 0 .33 0,.6 0 .3 0,.82 .23 0 0,.65 .6 0 0
c_local P11 0 1 .2 .35,.15 .75 .5 0,.03 .57 .63 0,0 .32 .55 0,0 .12 .42 0,0 0 .25 0,.1 0 .4 0,.33 0 .33 0,.6 0 .3 0,.82 .23 0 0,.65 .6 0 0
c_local note CMYK
c_local class "diverging"
end

program colorpalette_sfso
    syntax [, BRown ORange red PInk PUrple VIolet BLue LTBLue TUrquoise ///
        green OLive black parties LANGuages VOTEs THemes * ]
    local pal `brown' `orange' `red' `pink' `purple' `violet' `blue' ///
        `ltblue' `turquoise' `green' `olive' `black' `parties' `languages' ///
        `votes' `themes'
    local class "sequential"
    if `:list sizeof pal'>1 {
        di as err "only one scheme allowed"
        exit 198
    }
    if "`pal'"=="" local pal blue // default
    if      "`pal'"=="brown" {
        c_local P 0 1 .7 .6,0 .74 .57 .32,0 .56 .5 .24,0 .4 .4 .16,0 .27 .35 .1,0 .12 .22 .05
        //sRGB: c_local P #6b0616,#a1524f,#b67d6c,#cca590,#ddc3a8,#eee3cd
    }
    else if "`pal'"=="orange" {
        c_local P 0 .75 1 .4,0 .75 1 0,0 .59 1 0,0 .4 1 0,0 .26 .68 0,0 .13 .35 0
        //sRGB: c_local P #91490d,#cd6725,#d68c25,#e1b124,#eccf76,#f6e7be
    }
    else if "`pal'"=="red" {
        c_local P .1 1 .6 .55,.1 1 .6 .15,0 .95 .64 0,0 .71 .48 0,0 .5 .34 0,0 .25 .16 0
        //sRGB: c_local P #6d0724,#a61346,#c62a4f,#d17377,#dea59f,#efd6d1
    }
    else if "`pal'"=="pink" {
        c_local P .12 1 .12 .45,.09 1 .09 .18,0 1 .09 .04,0 .75 .07 .03,0 .53 .04 .02,0 .25 .02 0
        //sRGB: c_local P #7b0051,#a4006f,#c0007b,#cc669d,#da9dbf,#f0d7e5
    }
    else if "`pal'"=="purple" {
        c_local P .45 1 0 .45,.45 1 0 .05,.32 .9 0 0,.15 .75 0 0,.05 .53 0 0,0 .25 0 0
        //sRGB: c_local P #5e0058,#890783,#a23092,#be63a6,#d79dc5,#f0d7e8
    }
    else if "`pal'"=="violet" {
        c_local P .75 1 0 .5,.65 .9 0 .12,.51 .75 0 0,.38 .56 0 0,.25 .38 0 0,.12 .2 0 0
        //sRGB: c_local P #3a0054,#682b86,#8c58a3,#a886bc,#c5b0d4,#e1d7eb
    }
    else if "`pal'"=="blue" {
        c_local P .83 .45 0 .7,.85 .55 0 .4,.7 .45 0 .2,.63 .36 0 0,.43 .22 0 0,.22 .1 0 0,.13 .07 0 0
        //sRGB: c_local P #1c3258,#374a83,#6473aa,#8497cf,#afbce2,#d8def2,#e8eaf7
        c_local I ,,,BFS-Blau,,,BFS-Blau 20%
    }
    else if "`pal'"=="ltblue" {
        c_local P .98 0 .14 .45,.98 0 .14 .05,.72 0 .1 .03,.49 0 .07 .02,.35 0 .04 0,.12 0 0 0
        //sRGB: c_local P #086e8c,#159dc9,#76b7da,#abd0e7,#c8e0f2,#edf5fd
    }
    else if "`pal'"=="turquoise" {
        c_local P 1 0 .55 .65,1 0 .55 .35,.94 0 .5 0,.6 0 .3 0,.33 0 .17 0,.15 0 .05 0
        //sRGB: c_local P #005046,#107a6d,#3aa59a,#95c6c3,#cbe1df,#e9f2f5
    }
    else if "`pal'"=="green" {
        c_local P .75 0 1 .6,.75 0 1 .15,.6 0 .85 0,.45 0 .68 0,.28 0 .45 0,.12 0 .28 0
        //sRGB: c_local P #3a6419,#68a139,#95c15c,#b3d07f,#d3e3af,#ecf2d1
    }
    else if "`pal'"=="olive" {
        c_local P .05 0 1 .7,.05 0 1 .45,0 0 1 .3,0 0 .6 .15,0 0 .35 .09,0 0 .17 0
        //sRGB: c_local P #6f6f01,#a3a20a,#c5c00c,#e3df85,#eeecbc,#fffde6
    }
    else if "`pal'"=="black" {
        c_local P 0 0 0 .9,0 0 0 .65,0 0 0 .43,0 0 0 .25,0 0 0 .15,0 0 0 .05
        //sRGB: c_local P #3c3c3c,#828282,#b2b2b2,#d4d4d4,#e6e6e6,#f6f6f6
    }
    else if "`pal'"=="parties" {
        local class "qualitative"
        c_local P .76 .6 .02 0,0 .57 .78 0,0 .85 .58 0,.8 .3 1 .2,.28 .01 .96 0,.01 0 .96 0,.72 0 1 0,.6 .92 0 0,.5 .29 0 0,0 .2 .5 0,0 0 0 .35
        c_local I FDP,CVP,SP,SVP,GLP,BDP,Grüne, "small leftwing parties (PdA, Sol.)","small middle parties (EVP, CSP)","small rightwing parties (EDu, Lega)",other parties
    }
    else if "`pal'"=="languages" {
        local class "qualitative"
        c_local P 0 .9 .9 0,.9 .5 0 0,.9 0 .8 0,0 .25 .9 0,.6 .7 0 0
        c_local I German,French,Italian,Rhaeto-Romanic,English
    }
    else if "`pal'"=="votes" {
        local class "diverging"
        c_local P .6 .9 0 .15,.6 .9 0 .15*.8,.6 .9 0 .15*.6,.6 .9 0 .15*.4,.6 .9 0 .15*.2,.9 0 .9 .15*.2,.9 0 .9 .15*.4,.9 0 .9 .15*.6,.9 0 .9 .15*.8,.9 0 .9 .15
        c_local I No,,,,,,,,,Yes
    }
    else if "`pal'"=="themes" {
        local class "qualitative"
        c_local P .63 .36 0 0,0 .38 1 0,0 .59 1 0,0 .76 .88 0,0 .95 .64 0,0 1 .09 .04,.32 .9 0 0,.51 .57 0 0,.62 .6 0 0,.63 .22 0 .03,.8 .29 0 0,.98 0 .14 .05,.94 0 .5 0,.6 0 .85 0,.42 0 .76 0,0 0 1 .3,0 .19 .98 .35,.13 0 .6 .32,0 .36 .5 .24,0 .74 .57 .32,0 .5 .16 .14,.32 0 .18 .37
        c_local I 00 Basics and overviews,01 Population,02 Territory and environment,03 Work and income,/*
        */04 National economy,05 Prices,06 Industry and services,07 Agriculture and forestry,/*
        */08 Energy,09 Construction and housing,10 Tourism,11 Mobility and transport,/*
        */"12 Money, banks and insurance",13 Social security,14 Health,15 Education and science,/*
        */"16 Culture, media, information society, sport",17 Politics,18 General Government and finance,/*
        */19 Crime and criminal justice,20 Economic and social situation of the population,/*
        */21 Sustainable development
        local cmyk cmyk
    }
    c_local name sfso `pal'
    c_local note CMYK
    c_local class "`class'"
end

program colorpalette_webcolors_pink
c_local P Pink,LightPink,HotPink,DeepPink,PaleVioletRed,MediumVioletRed
c_local class "qualitative"
end

program colorpalette_webcolors_purple
c_local P Lavender,Thistle,Plum,Orchid,Violet,Fuchsia,Magenta,MediumOrchid,/*
*/DarkOrchid,DarkViolet,BlueViolet,DarkMagenta,Purple,MediumPurple,/*
*/MediumSlateBlue,SlateBlue,DarkSlateBlue,RebeccaPurple,Indigo
c_local class "qualitative"
end

program colorpalette_webcolors_redorange
c_local P LightSalmon,Salmon,DarkSalmon,LightCoral,IndianRed,Crimson,Red,/*
*/FireBrick,DarkRed,Orange,DarkOrange,Coral,Tomato,OrangeRed
c_local class "qualitative"
end

program colorpalette_webcolors_yellow
c_local P Gold,Yellow,LightYellow,LemonChiffon,LightGoldenRodYellow,PapayaWhip,/*
*/Moccasin,PeachPuff,PaleGoldenRod,Khaki,DarkKhaki
c_local class "qualitative"
end

program colorpalette_webcolors_green
c_local P GreenYellow,Chartreuse,LawnGreen,Lime,LimeGreen,PaleGreen,LightGreen,/*
*/MediumSpringGreen,SpringGreen,MediumSeaGreen,SeaGreen,ForestGreen,Green,/*
*/DarkGreen,YellowGreen,OliveDrab,DarkOliveGreen,MediumAquaMarine,DarkSeaGreen,/*
*/LightSeaGreen,DarkCyan,Teal
c_local class "qualitative"
end

program colorpalette_webcolors_cyan
c_local P Aqua,Cyan,LightCyan,PaleTurquoise,Aquamarine,Turquoise,MediumTurquoise,DarkTurquoise
c_local class "qualitative"
end

program colorpalette_webcolors_blue
c_local P CadetBlue,SteelBlue,LightSteelBlue,LightBlue,PowderBlue,LightSkyBlue,/*
*/SkyBlue,CornflowerBlue,DeepSkyBlue,DodgerBlue,RoyalBlue,Blue,MediumBlue,/*
*/DarkBlue,Navy,MidnightBlue
c_local class "qualitative"
end

program colorpalette_webcolors_brown
c_local P Cornsilk,BlanchedAlmond,Bisque,NavajoWhite,Wheat,BurlyWood,Tan,/*
*/RosyBrown,SandyBrown,GoldenRod,DarkGoldenRod,Peru,Chocolate,Olive,/*
*/SaddleBrown,Sienna,Brown,Maroon
c_local class "qualitative"
end

program colorpalette_webcolors_white
c_local P White,Snow,HoneyDew,MintCream,Azure,AliceBlue,GhostWhite,WhiteSmoke,/*
*/SeaShell,Beige,OldLace,FloralWhite,Ivory,AntiqueWhite,Linen,LavenderBlush,MistyRose
c_local class "qualitative"
end

program colorpalette_webcolors_grey
c_local P Gainsboro,LightGray,Silver,DarkGray,DimGray,Gray,LightSlateGray,SlateGray,DarkSlateGray,Black
c_local class "qualitative"
end

exit
