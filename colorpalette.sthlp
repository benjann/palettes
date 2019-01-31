{smcl}
{* 31jan2019}{...}
{hi:help colorpalette}{...}
{right:{browse "http://repec.sowi.unibe.ch/stata/palettes/"}}
{hline}

{title:Title}

{pstd}{hi:colorpalette} {hline 2} Color palettes


{marker syntax}{...}
{title:Syntax}

{pstd}
    Syntax 1: Retrieve/display colors from one or multiple palettes

{p 8 15 2}
    {cmd:colorpalette} [{it:argument}]
        [{cmd:,} {help colorpalette##opts:{it:palette_options}}
        {help colorpalette##gopts:{it:graph_options}} ]

{pstd}
    where {it:argument} is

{p 8 15 2}
    {help colorpalette##palette:{it:palette}}
    [[, {help colorpalette##opts:{it:palette_options}}] /
    [ {help colorpalette##palette:{it:palette}}
    [, {help colorpalette##opts:{it:palette_options}}] / ... ]]

{pstd}
    Syntax 2: Display an overview of multiple palettes

{p 8 15 2}
    {cmd:colorpalette} [{cmd:,} {help colorpalette##opts:{it:palette_options}}
        {help colorpalette##gopts:{it:graph_options}} ] {cmd::} {it:pspec} [ {cmd:/} {it:pspec} {cmd:/} ... ]

{pstd}
    where {it:pspec} is

{p 8 15 2}
    {help colorpalette##palette:{it:palette}} [{cmd:,} {help colorpalette##opts:{it:palette_options}}]

{pstd}
or {cmd:.} to insert a gap.


{synoptset 20 tabbed}{...}
{marker palette}{synopthdr:palette}
{synoptline}
{syntab:Color list}
{synopt:{it:{help colorpalette##colorlist:colorlist}}}custom list of colors (including 140 named {help colorpalette##webcolors:web colors}){p_end}

{syntab:Stata palettes ({stata "colorpalette, lc(black): s2 / s1 / s1r / economist / mono":{it:view}})}
{synopt:{helpb colorpalette##s2:s2}}15 colors as in Stata's {helpb scheme s2:s2color} scheme; the default{p_end}
{synopt:{helpb colorpalette##s1:s1}}15 colors as in Stata's {helpb scheme s1:s1color} scheme{p_end}
{synopt:{helpb colorpalette##s1r:s1r}}15 colors as in Stata's {helpb scheme s1:s1rcolor} scheme{p_end}
{synopt:{helpb colorpalette##economist:economist}}15 colors as in Stata's {helpb scheme economist:economist} scheme{p_end}
{synopt:{helpb colorpalette##mono:mono}}15 gray scales as in Stata's monochrome schemes{p_end}

{syntab:Other palettes ({stata "colorpalette, lc(black): cblind / plottig / 538 / mrc / tfl / burd / lean / tableau":{it:view}})}
{synopt:{helpb colorpalette##cblind:cblind}}9 colorblind-friendly by Okabe and Ito (2002){p_end}
{synopt:{helpb colorpalette##plottig:plottig}}15 colors as in {cmd:plottig} by Bischof (2017b){p_end}
{synopt:{helpb colorpalette##538:538}}6 + 7 colors as in {cmd:538} by Bischof (2017a){p_end}
{synopt:{helpb colorpalette##mrc:mrc}}7 colors as in {cmd:mrc} by Morris (2013){p_end}
{synopt:{helpb colorpalette##tfl:tfl}}8 colors as in {cmd:tfl} by Morris (2015){p_end}
{synopt:{helpb colorpalette##burd:burd}}9 + 4 colors as in {cmd:burd} by Briatte (2013){p_end}
{synopt:{helpb colorpalette##lean:lean}}15 gray scales as in {cmd:lean} by Juul (2003){p_end}
{synopt:{helpb colorpalette##tableau:tableau}}20 categorical colors by Lin et al. (2013){p_end}

{syntab:Color generators}
{synopt:{helpb colorpalette##hue:hue}}evenly spaced HCL hues{p_end}
{synopt:{helpb colorpalette##hcl:hcl} | {helpb colorpalette##hcl:lch} | {helpb colorpalette##hcl:jmh}}HCL, LCh, or J'M'h color generator{p_end}
{synopt:{helpb colorpalette##hsv:hsv}}HSV color generator{p_end}

{syntab:Collections}
{synopt:{it:{help colorpalette##cbrew:colorbrewer}}}ColorBrewer palettes from {browse "http://colorbrewer2.org":colorbrewer2.org}{p_end}
{synopt:{it:{help colorpalette##viridis:viridis}}}perceptually uniform colormaps from {browse "http://matplotlib.org":matplotlib.org}{p_end}
{synopt:{helpb colorpalette##matplotlib:matplotlib}}other colormaps from {browse "http://matplotlib.org":matplotlib.org}{p_end}
{synopt:{helpb colorpalette##ptol:ptol}}color schemes from Tol (2012){p_end}
{synopt:{helpb colorpalette##d3:d3}}categorical color schemes from {browse "http://d3js.org/":D3.js}{p_end}
{synopt:{helpb colorpalette##lin:lin}}semantic colors schemes by Lin et al. (2013){p_end}
{synopt:{helpb colorpalette##spmap:spmap}}color schemes from {cmd:spmap} by Pisati (2007){p_end}
{synopt:{helpb colorpalette##sfso:sfso}}color schemes used by the Swiss Federal
    Statistical Office{p_end}

{syntab:Custom}
{synopt:{it:{help colorpalette##myname:myname}}}custom palette provided by program {cmd:colorpalette_}{it:myname}{p_end}
{synopt:{help colorpalette##mata:{bf:{ul:m}ata(}{it:name}{bf:)}}}custom palette provided by {helpb colrspace:ColrSpace} object {it:name}{p_end}
{synoptline}


{synoptset 20 tabbed}{...}
{marker opts}{synopthdr:palette_options}
{synoptline}
{syntab:Main}
{synopt:{helpb colorpalette##n:n({it:#})}}size of the palette (number of colors)
    {p_end}
{synopt:{helpb colorpalette##select:{ul:s}elect({it:numlist})}}select (and order) the colors
    {p_end}
{synopt:{helpb colorpalette##order:order({it:numlist})}}order the colors
    {p_end}
{synopt:{helpb colorpalette##reverse:{ul:rev}erse}}arrange palette in reverse order
    {p_end}
{synopt:{helpb colorpalette##opacity:{ul:op}acity({it:numlist})}}set opacity, in percent
    {p_end}
{synopt:{helpb colorpalette##intensity:{ul:in}tensity({it:numlist})}}set color intensity multipliers
    {p_end}
{synopt:{helpb colorpalette##ipolate:{ul:ip}olate({it:spec})}}interpolate the colors
    {p_end}
{synopt:{helpb colorpalette##intensify:{ul:in}tensify({it:numlist})}}modify intensity
    {p_end}
{synopt:{helpb colorpalette##saturate:{ul:sat}urate({it:spec})}}modify saturation (colorfulness)
    {p_end}
{synopt:{helpb colorpalette##luminate:{ul:lum}inate({it:spec})}}modify luminance (brightness)
    {p_end}
{synopt:{helpb colorpalette##gscale:{ul:gs}cale{sf:[}({it:spec}){sf:]}}}convert to grayscale
    {p_end}
{synopt:{helpb colorpalette##cblind:{ul:cb}lind{sf:[}({it:spec}){sf:]}}}simulate color vision deficiency
    {p_end}
{synopt:{help colorpalette##other:{it:other}}}palette-specific options
    {p_end}

{syntab:Technical}
{synopt:{helpb colorpalette##forcergb:{ul:force}rgb}}enforce translation to RGB
    {p_end}
{synopt:{helpb colorpalette##noexpand:noexpand}}omit automatic interpolation/recycling
    {p_end}
{synopt:{helpb colorpalette##class:class({it:class})}}set palette class
    {p_end}
{synoptline}


{synoptset 20 tabbed}{...}
{marker gopts}{synopthdr:graph_options}
{synoptline}
{syntab:Main}
{synopt:{helpb colorpalette##title:{ul:ti}tle({it:string})}}custom graph title
    {p_end}
{synopt:{helpb colorpalette##nonumbers:{ul:nunum}bers}}omit color IDs
    {p_end}
{synopt:{helpb colorpalette##gropts:{ul:gr}opts({it:options})}}options
    passed through to graph command
    {p_end}

{syntab:Syntax 1 only}
{synopt:{helpb colorpalette##rows:rows({it:#})}}minimum number of rows; default is 5
    {p_end}
{synopt:{helpb colorpalette##names:names}}print names instead of codes
    (if available)
    {p_end}
{synopt:{helpb colorpalette##nograph:{ul:nogr}aph}}do not generate a graph
    {p_end}

{syntab:Syntax 2 only}
{synopt:{helpb colorpalette##horizontal:{ul:hor}izontal}}horizontal plot; the default
    {p_end}
{synopt:{helpb colorpalette##vertical:{ul:vert}ical}}vertical plot
    {p_end}
{synopt:{helpb colorpalette##span:span}}use all available space for each palette
    {p_end}
{synopt:{helpb colorpalette##labels:{ul:lab}els({it:strlist})}}custom palette labels
    {p_end}
{synopt:{helpb colorpalette##lcolor:{ul:lc}olor({it:colorstyle})}}custom outline color
    {p_end}
{synopt:{helpb colorpalette##lwidth:{ul:lw}idth({it:lwstyle})}}custom outline thickness
    {p_end}
{synoptline}


{marker description}{...}
{title:Description}

{pstd}
    {cmd:colorpalette} is a utility command to retrieve or display color
    palettes. Palette entries are returned in
    {helpb colorpalette##returns:r()}.

{pstd}
    {cmd:colorpalette} is used by {helpb grstyle set}.

{pstd}
    {cmd:colorpalette} requires version 14.2 of Stata or newer. Users of older
    Stata versions can use command {helpb colorpalette9}, which has limited
    functionality but runs under Stata 9.2 or newer.

{pstd}
    {cmd:colorpalette} requires the {helpb colrspace} package to be installed;
    type {stata ssc install colrspace}.


{marker options}{...}
{title:Options}

{dlgtab:Palette options}

{marker n}{...}
{phang}
    {opt n(#)} specifies the size of the palette (the number of colors). Many
    palettes, such as, e.g., the color generators or the sequential and
    diverging ColorBrewer palettes, are adaptive to {opt n()} in the sense that
    they return different colors depending on {opt n()}. Other palettes, such
    as {cmd:s2}, contain a fixed set of colors. If {opt n()} is different from
    the (maximum or minimum) number of colors returned by a palette, the colors
    are either recycled or interpolated, depending on the class of palette; see
    option {helpb colorpalette##class:class()} below. To prevent automatic
    recycling/interpolation, specify option {helpb colorpalette##noexpand:noexpand}
    (see below).

{marker select}{...}
{phang}
    {opth select(numlist)} selects (and reorders) the colors retrieved from
    the palette. Positive numbers refer to positions from the start;
    negative numbers refer to positions from the end. Only one of {cmd:select()}
    and {cmd:order()} is allowed.

{marker order}{...}
{phang}
    {opth order(numlist)} reorders the colors. Positive numbers refer to positions
    from the start; negative numbers refer to positions from the end. Colors
    not covered in {it:numlist} will be placed last, in their original order. Only
    one of {cmd:select()} and {cmd:order()} is allowed.

{marker reverse}{...}
{phang}
    {opt reverse} returns the colors in reverse order.

{marker opacity}{...}
{phang}
    {opth opacity(numlist)} sets the opacity level(s) (0: fully transparent,
    100: fully opaque; Stata 15 required). Specify multiple values to use
    different opacity levels across the colors. If the number of specified
    opacity levels is smaller than the number of colors, the levels will be
    recycled; if the number of opacity levels is larger than the number of
    colors, the colors will be recycled. To skip assigning opacity to a
    particular color, you may set the corresponding element to 
    {cmd:.} (missing). {cmd:opacity()} will be applied after {cmd:n()}, {cmd:select()}, 
    {cmd:order()}, and {cmd:reverse} have been applied.

{marker intensity}{...}
{phang}
    {opth intensity(numlist)} sets the color intensity adjustment multipliers.
    The values in {it:numlist} must be between 0 and 255. Values below 1 make
    the colors lighter; values larger than 1 make the colors darker (although
    the allowed scale goes up to 255, values as low as 5 or 10 may already make
    a color black). Specify multiple values to assign different
    multipliers across the colors. If the number of specified multipliers is
    smaller than the number of colors, the multipliers will be recycled; if the
    number of multipliers is larger than the number of colors, the colors will
    be recycled. To skip assigning an intensity multiplier to a particular
    color, you may set the corresponding element to {cmd:.} (missing).
    {cmd:intensity()} will be applied after {cmd:n()}, {cmd:select()},
    {cmd:order()}, and {cmd:reverse} have been applied.

{pmore}
    Example: {stata `"colorpalette "189 30 36", intensity(0.1(.05)1)"'}

{marker ipolate}{...}
{phang}
    {cmd:ipolate(}{it:n}[{cmd:,} {it:suboptions}]{cmd:)} 
    interpolates the colors to a total of {it:n} colors. {cmd:ipolate()}
    will be applied after {cmd:n()}, {cmd:select()}, {cmd:order()}, {cmd:reverse},
    {cmd:opacity()}, and {cmd:intensity()} have been applied (intensity multipliers 
    and opacity levels, if defined, will also be interpolated).
    
{pmore}
    Example: {stata colorpalette cranberry dkorange, ipolate(5)}
    
{pmore}
    Suboptions are as follows.

{phang2}
    {it:space} selects the color space in which the colors are
    interpolated. The default space is {cmd:Jab} (perceptually uniform
    CIECAM02-based J'a'b'). Other possibilities are, for example, {cmd:RGB}, {cmd:lRGB},
    {cmd:Lab}, {cmd:LCh}, {cmd:Luv}, {cmd:HCL}, {cmd:JMh}, or {cmd:HSV}; see
    help {helpb colrspace##ipolate:colrspace} for details.
    
{pmore2}
    Example: {stata "colorpalette: #fafa6e #2a4858, ipolate(10) / #fafa6e #2a4858, ipolate(10, JMh)"}

{phang2}
    {opt ra:nge(lb [ub])} sets the interpolation range, where {it:lb} and
    {it:ub} are the lower and upper bounds. The default is {cmd:range(0 1)}. If
    {it:lb} is larger than {it:ub}, the colors are returned in reverse 
    order. Extrapolation will be applied if the specified range exceeds [0,1].

{pmore2}
    Example: {stata "colorpalette: #fafa6e #2a4858, ipolate(11, HCL) / #fafa6e #2a4858, ipolate(6, HCL range(0 .5))"}

{phang2}
    {opt pow:er(#)}, with # > 0, determines how the destination colors are
    distributed across the interpolation range. The default is to distribute
    them evenly; this is equivalent to {cmd:power(1)}. A power value larger
    than 1 squishes the positions towards the lower bound. If interpolating
    between two colors, this means that the first color will dominate most of
    the interpolation range (slow to fast transition). A value between 0 and 1
    squishes the positions towards the upper bound, thus making the second
    color the dominant color for most of the range (fast to slow 
    transition). Another way to think of the effect of {cmd:power()} is that 
    it moves the center of the color gradient up (if # > 1) or down (if 0 < # < 1).

{pmore2}
    Example: {stata "colorpalette: #fafa6e #2a4858, ipolate(30, HCL power(1.5)) / #fafa6e #2a4858, ipolate(30, HCL power(0.7))"}

{phang2}
    {opth pos:itions(numlist)} specifies the positions of the origin colors
    with respect to the interpolation range. The default is to arrange them on
    a regular grid from 0 and 1. If the number of specified positions is smaller
    than the number of origin colors, default positions are used for the
    remaining colors. If the same position is specified for multiple 
    colors, these colors will be averaged before applying interpolation.

{pmore2}
    Example: {stata "colorpalette: Black Crimson Gold, ipolate(30, position(0 .3 1)) / Black Crimson Gold, ipolate(30, position(0 .7 1))"}
    
{phang2}
    {opt pad:ded} requests padded interpolation. By
    default, the first color and the last color are taken as the end points of
    the interpolation range; these colors thus remain unchanged. Alternatively,
    if you specify option {cmd:padded}, the first and last colors will be interpreted as
    interval midpoints on an equally-spaced grid. This increases the
    interpolation range by half an interval on each side and causes the
    first color and the last color to be affected by the interpolation.

{pmore2}
    Example (the difference is subtle, but the padded variant is a bit darker at the 
    bottom and the top, which represents the original 11-color scale better 
    than the unpadded variant): 

{p 16 18 2}
    . {stata "colorpalette, span vertical: BrBG / BrBG, ipolate(30) / BrBG, ipolate(30, padded)"}

{marker intensify}{...}
{phang}
    {opth intensify(numlist)} modifies the intensity of the colors. The values
    in {it:numlist} must be between 0 and 255. Values below 1 make the colors
    lighter; values larger than 1 make the colors darker (although the allowed
    scale goes up to 255, values as low as 5 or 10 may already make a color
    black). Specify multiple values to apply different adjustments
    across the colors. If the number of specified values is smaller than
    the number of colors, the values will be recycled; if the number of
    values is larger than the number of colors, the colors will be
    recycled. To skip adjusting the intensity of a particular color, you may
    set the corresponding element to {cmd:.} (missing). {cmd:intensify()} will 
    be applied after {cmd:ipolate()} has been applied.

{pmore}
    {cmd:intensify()} applies the same kind of intensity adjustment as  
    implemented by the intensity adjustment multipliers set by {cmd:intensity()}.
    The difference between {cmd:intensify()} and {cmd:intensity()} is that
    {cmd:intensity()} only records the intensity multipliers (which are then
    returned as part of the color definitions), whereas {cmd:intensify()}
    directly applies intensity adjustment by transforming the RGB values. A
    second difference is that {cmd:intensity()} is applied before
    interpolation, whereas {cmd:intensify()} is applied after interpolation.

{pmore}
    Example: {stata `"colorpalette "189 30 36", intensify(0.1(.05)1)"'}

{marker saturate}{...}
{phang}
    {cmd:saturate(}{it:{help numlist}}[{cmd:,} {it:space} {cmd:level}]{cmd:)}
    modifies the saturation (colorfulness) of the colors. Positive numbers will
    increase the chroma channel of the colors by the specified amount, negative
    numbers will reduce chroma. Specify multiple values to apply different
    adjustments across the colors. If the number of values is smaller than the
    number of colors, the values will be recycled; if the number of values is
    larger than the number of colors, the colors will be recycled. To skip
    adjusting the saturation of a particular color, you may set the
    corresponding element to {cmd:.} (missing). {cmd:saturate()} will be
    applied after {cmd:ipolate()} has been applied. Suboptions are as 
    follows.

{phang2}
    {it:space} specifies the color space in which the colors are manipulated.
    Possible spaces are {cmd:LCh} (cylindrical representation of CIE L*a*b*),
    {cmd:HCL} (cylindrical representation of CIE L*u*v*), {cmd:JCh} (CIECAM02
    JCh), and {cmd:JMh} (CIECAM02-based J'M'h). The default is {cmd:LCh}.

{phang2}
    {cmd:level} specifies that the provided numbers are levels, not
    differences. The default is to adjust the chroma values of the colors by
    adding/subtracting the specified amounts. Alternatively, if {cmd:levels} is
    specified, the chroma values of the colors will be set to the specified
    levels. Chroma values of typical colors lie between 0 and 100 or maybe 150.

{pmore}
    Example: {stata "colorpalette: RdYlGn, saturate(25) / RdYlGn / RdYlGn, saturate(-25)"}

{marker luminate}{...}
{phang}
    {cmd: luminate(}{it:{help numlist}}[{cmd:,} {it:space} {cmd:level}]{cmd:)}
    modifies the luminance (brightness) of the colors. Positive numbers will
    increase the luminance of the colors by the specified amount, negative
    numbers will reduce luminance. Specify multiple values to apply different
    adjustments across the colors. If the number of values is smaller than the
    number of colors, the values will be recycled; if the number of values is
    larger than the number of colors, the colors will be recycled. To skip
    adjusting the luminance of a particular color, you may set the
    corresponding element to {cmd:.} (missing). {cmd:luminate()} will be
    applied after {cmd:ipolate()} has been applied. Suboptions are as 
    follows.

{phang2}
    {it:space} specifies the color space in which the colors are manipulated.
    Possible spaces are {cmd:Lab} (CIE L*a*b*), {cmd:Luv} (CIE L*u*v*),
    {cmd:JCh} (CIECAM02 JCh), and {cmd:JMh} (CIECAM02-based J'M'h) ({cmd:LCh},
    {cmd:HCL}, and {cmd:Jab} are also allowed, but result in the same colors as 
    {cmd:Lab}, {cmd:Luv}, and {cmd:JMh}, respectively). The
    default is {cmd:JMh}.

{phang2}
    {cmd:level} specifies that the provided numbers are levels, not
    differences. The default is to adjust the luminance values of the colors by
    adding/subtracting the specified amounts. Alternatively, if {cmd:levels} is
    specified, the luminance values of the colors will be set to the specified
    levels. Luminance values of typical colors lie between 0 and 100.

{pmore}
    Examples:

{p 12 16 2}
    . {stata "colorpalette: ptol, luminate(15) / ptol / ptol, luminate(-15)"}
    {p_end}
{p 12 16 2}
    . {stata "colorpalette: blue red green, select(1 1 2 2 3 3) luminate(. 40)"}

{marker gscale}{...}
{phang}
    {cmd:gscale}[{cmd:(}{it:p} [{cmd:,} {it:space} ]{cmd:)}] converts the
    colors to gray, where {it:p} in [0,1] specifies the proportion of gray. The
    default is {cmd:1} (full conversion). Suboption {it:space} specifies the
    color space in which the conversion is performed; it may be {cmd:LCh}
    (cylindrical representation of CIE L*a*b*), {cmd:HCL} (cylindrical
    representation of CIE L*u*v*), {cmd:JCh} (CIECAM02 JCh), and {cmd:JMh}
    (CIECAM02-based J'M'h). The default is {cmd:LCh}. Example:

{p 12 16 2}
    . {stata "colorpalette: s2 / s2, gscale(.5) / s2, gscale"}

{marker cblind}{...}
{phang}
    {cmd:cblind}[{cmd:(}{it:severity} [{cmd:,} {it:type} ]{cmd:)}]
    simulates color vision deficiency, where {it:severity} in [0,1] specifies the severity
    of the deficiency and {it:type} specifies type of color vision deficiency, which
    may be {cmdab:d:euteranomaly} (the default),
    {cmdab:p:rotanomaly}, or {cmdab:t:ritanomaly}. The default {it:severity} is
    {cmd:1} (i.e. deuteranopia, protanopia, or tritanopia, respectively). See
    {browse "https://en.wikipedia.org/wiki/Color_blindness":Wikipedia} for basic
    information on color blindness. Example:

{p 12 16 2}
    . {stata "colorpalette: Set1 / Set1, cblind(.5, deut) / Set1, cblind(.5, prot) / Set1, cblind(1, trit)"}

{marker other}{...}
{phang}
    {it:other} are additional palette-specific options. See the descriptions of
    the palettes below. Palette-specific options have to be unique, that is, they 
    can only be specified once per palette. When collecting results from multiple
    palettes, palette options can be specified at the global level, to define
    default settings for all palettes, or at the local level of an individual 
    palette. For general palette options, defaults set at the global 
    level can be overridden by repeating an option at the local level. Such 
    repetitions are not allowed for palette-specific options.

{marker forcergb}{...}
{phang}
    {opt forcergb} enforces translation of all colors to RGB. By default,
    {cmd:colorpalette} does not translate colors specified as Stata color names
    or CMYK codes, because these specifications are understood by
    Stata graphics. Specify {opt forcergb} to return these colors as RGB values.

{marker noexpand}{...}
{phang}
    {opt noexpand} omits recycling or interpolating colors if the number of
    requested colors is larger than the maximum number of colors defined in a palette.

{marker class}{...}
{phang}
    {opt class(class)} declares the class of the the palette, where {it:class}
    may be {cmdab:q:ualitative}, {cmdab:s:equential}, {cmdab:d:iverging}, or any
    other string. Palettes declared as {cmd:qualitative} will be recycled, all
    other palettes will be interpolated (if recycling or interpolation is
    necessary). Specifying {cmd:class()} only affects palettes that do not set
    the class as part of their definition.

{dlgtab:Graph options}

{marker title}{...}
{phang}
    {opt title(string)} specifies a custom title for the graph.

{marker nonumbers}{...}
{phang}
    {opt nonumbers} suppresses the numbers identifying the colors in the graph.

{marker gropts}{...}
{phang}
    {cmd:gropts(}{it:{help twoway_options}}{cmd:)} provides options to
    be passed through to the graph command.

{marker rows}{...}
{phang}
    {opt rows(#)} specifies the minimum number of rows in the graph (syntax 1
    only). The default is 5.

{marker names}{...}
{phang}
    {opt names} replaces the RGB values in the graph by the information found in
    {cmd:r(p#info)} (e.g. the color names), if such information is available (syntax 1 only).

{marker nograph}{...}
{phang}
    {opt nograph} suppresses the graph (syntax 1 only).

{marker horizontal}{...}
{phang}
    {opt horizontal} displays the palettes horizontally (syntax 2 only). This
    is the default.

{marker vertical}{...}
{phang}
    {opt vertical} displays the palettes vertically (syntax 2 only).

{marker span}{...}
{phang}
    {opt span} adjusts the size of the color fields such that each palette
    spans the full plot region, irrespective of the
    number of colors (syntax 2 only).

{marker labels}{...}
{phang}
    {opt labels(strlist)} provides custom labels for the palettes (syntax 2
    only). Enclose labels with spaces in double quotes.

{marker lcolor}{...}
{phang}
    {opth lcolor(colorstyle)} specifies a custom outline color (syntax 2 only).
    The default is to use the same color for the outline as for the fill.

{marker lwidth}{...}
{phang}
    {opth lwidth(linewidthstyle)} specifies a custom outline thickness (syntax 2
    only). The default is {cmd:lwidth(vthin)}.

{marker palettes}{...}
{title:Palettes}

{marker colorlist}{...}
{dlgtab:colorlist}

{pstd}
    Instead of selecting a named color palette you can specify
    a space-separated list of colors using syntax

{p 8 15 2}
    [{cmd:"}]{it:color}[{cmd:%}{it:#}][*{it:#}][{cmd:"}] ...

{pstd}
    where {cmd:%}{it:#} sets the opacity (in percent; 0 = fully transparent,
    100 = fully opaque; Stata 15 required), {cmd:*}{it:#} adjusts the intensity
    (values between 0 and 1 make the color lighter; values larger than one
    make the color darker), and {it:color} is one of the following:

{p2colset 9 28 30 2}{...}
{p2col:{help colorstyle##colorstyle:{it:name}}}official Stata color name as listed in {help colorstyle##colorstyle:{it:colorstyle}}{p_end}
{p2col:{help colorpalette##webcolors:{it:webname}}}web color name as listed {help colorpalette##webcolors:below}{p_end}
{p2col:{cmd:#}{it:rrggbb}}6-digit hex RGB value; white = {cmd:#FFFFFF} or {cmd:#ffffff}, navy = {cmd:#1A476F} or {cmd:#1a476f} {p_end}
{p2col:{cmd:#}{it:rgb}}3-digit abbreviated hex RGB value; white = {cmd:#FFF} or {cmd:#fff}{p_end}
{p2col:{it:# # #}}RGB value in 0-255 scaling; navy = {cmd:"26 71 111"}{p_end}
{p2col:{it:# # # #}}CMYK value in 0-255 or 0-1 scaling; navy = {cmd:"85 40 0 144"} or {cmd:".333 .157 0 .565"}{p_end}
{p2col:{it:space ...}}color value in one of the color spaces supported by {helpb colrspace##strinput:colrspace}; e.g., navy =
    {cmd:"XYZ 5.55 5.87 15.9"} or {cmd:"Lab 29 -.4 -27.5"} or {cmd:"Jab 30.1 -8.9 -19"} (see help
    {helpb colrspace##strinput:colrspace} for more examples)

{pstd}
    Example: navy in 5 different ways

{p 8 12 2}
        . {stata colorpalette navy "26 71 111" "85 40 0 144" "hsv 208 .766 .435" "hcl 246.6 38.8 29"}

{pstd}
    Example: hex colors (using colors from
    {browse "http://getbootstrap.com/docs/3.3":Bootstrap v3.3})

        . {stata colorpalette #337ab7 #5cb85c #5bc0de #f0ad4e #d9534f}

{pmore}
    For background information on hex colors see
    {browse "http://en.wikipedia.org/wiki/Web_colors":en.wikipedia.org/wiki/Web_colors}. Some
    websites providing collections of colors are
    {browse "http://www.w3schools.com/colors/":www.w3schools.com/colors},
    {browse "http://htmlcolorcodes.com/":htmlcolorcodes.com}, or
    {browse "http://www.color-hex.com/":www.color-hex.com}).

{pstd}
    Example: specifying opacity and intensity adjustment

        . {stata colorpalette "26 71 111%80" "26 71 111*.7" "26 71 111%80*.7"}

{marker webcolors}{...}
{pstd}
    Example: web colors

        . {stata colorpalette slate paleviolet lightsea sandy}

{pstd}
    Supported are the standard web colors listed at
    {browse "https://www.w3schools.com/colors/colors_names.asp":www.w3schools.com}. The 140 color
    names, sorted by color groups, are as follows.

{phang}
    Pink colors ({stata colorpalette webcolors_pink, title(Pink colors) nonumbers:{it:view}}):{p_end}
{pmore}
    {cmd:Pink}, {cmd:LightPink}, {cmd:HotPink}, {cmd:DeepPink},
    {cmd:PaleVioletRed}, {cmd:MediumVioletRed}

{phang}
    Purple colors ({stata colorpalette webcolors_purple, title(Purple colors) nonumbers:{it:view}}):{p_end}
{pmore}
    {cmd:Lavender}, {cmd:Thistle}, {cmd:Plum}, {cmd:Orchid}, {cmd:Violet},
    {cmd:Fuchsia}, {cmd:Magenta}, {cmd:MediumOrchid}, {cmd:DarkOrchid},
    {cmd:DarkViolet}, {cmd:BlueViolet}, {cmd:DarkMagenta}, {cmd:Purple},
    {cmd:MediumPurple}, {cmd:MediumSlateBlue}, {cmd:SlateBlue},
    {cmd:DarkSlateBlue}, {cmd:RebeccaPurple}, {cmd:Indigo}

{phang}
    Red and orange colors ({stata colorpalette webcolors_redorange, title(Red and orange colors) nonumbers:{it:view}}):{p_end}
{pmore}
    {cmd:LightSalmon}, {cmd:Salmon}, {cmd:DarkSalmon}, {cmd:LightCoral},
    {cmd:IndianRed}, {cmd:Crimson}, {cmd:Red}, {cmd:FireBrick}, {cmd:DarkRed},
    {cmd:Orange}, {cmd:DarkOrange}, {cmd:Coral}, {cmd:Tomato}, {cmd:OrangeRed}

{phang}
    Yellow colors ({stata colorpalette webcolors_yellow, title(Yellow colors) nonumbers:{it:view}}):{p_end}
{pmore}
    {cmd:Gold}, {cmd:Yellow}, {cmd:LightYellow}, {cmd:LemonChiffon},
    {cmd:LightGoldenRodYellow}, {cmd:PapayaWhip}, {cmd:Moccasin}, {cmd:PeachPuff},
    {cmd:PaleGoldenRod}, {cmd:Khaki}, {cmd:DarkKhaki}

{phang}
    Green colors ({stata colorpalette webcolors_green, title(Green colors) nonumbers:{it:view}}):{p_end}
{pmore}
    {cmd:GreenYellow}, {cmd:Chartreuse}, {cmd:LawnGreen}, {cmd:Lime},
    {cmd:LimeGreen}, {cmd:PaleGreen}, {cmd:LightGreen}, {cmd:MediumSpringGreen},
    {cmd:SpringGreen}, {cmd:MediumSeaGreen}, {cmd:SeaGreen}, {cmd:ForestGreen},
    {cmd:Green}, {cmd:DarkGreen}, {cmd:YellowGreen}, {cmd:OliveDrab},
    {cmd:DarkOliveGreen}, {cmd:MediumAquaMarine}, {cmd:DarkSeaGreen},
    {cmd:LightSeaGreen}, {cmd:DarkCyan}, {cmd:Teal}

{phang}
    Cyan colors ({stata colorpalette webcolors_cyan, title(Cyan colors) nonumbers:{it:view}}):{p_end}
{pmore}
    {cmd:Aqua}, {cmd:Cyan}, {cmd:LightCyan}, {cmd:PaleTurquoise}, {cmd:Aquamarine},
    {cmd:Turquoise}, {cmd:MediumTurquoise}, {cmd:DarkTurquoise}

{phang}
    Blue colors ({stata colorpalette webcolors_blue, title(Blue colors) nonumbers:{it:view}}):{p_end}
{pmore}
    {cmd:CadetBlue}, {cmd:SteelBlue}, {cmd:LightSteelBlue}, {cmd:LightBlue},
    {cmd:PowderBlue}, {cmd:LightSkyBlue}, {cmd:SkyBlue}, {cmd:CornflowerBlue},
    {cmd:DeepSkyBlue}, {cmd:DodgerBlue}, {cmd:RoyalBlue}, {cmd:Blue},
    {cmd:MediumBlue}, {cmd:DarkBlue}, {cmd:Navy}, {cmd:MidnightBlue}

{phang}
    Brown colors ({stata colorpalette webcolors_brown, title(Brown colors) nonumbers:{it:view}}):{p_end}
{pmore}
    {cmd:Cornsilk}, {cmd:BlanchedAlmond}, {cmd:Bisque}, {cmd:NavajoWhite},
    {cmd:Wheat}, {cmd:BurlyWood}, {cmd:Tan}, {cmd:RosyBrown}, {cmd:SandyBrown},
    {cmd:GoldenRod}, {cmd:DarkGoldenRod}, {cmd:Peru}, {cmd:Chocolate}, {cmd:Olive},
    {cmd:SaddleBrown}, {cmd:Sienna}, {cmd:Brown}, {cmd:Maroon}

{phang}
    White colors ({stata colorpalette webcolors_white, title(White colors) nonumbers:{it:view}}):{p_end}
{pmore}
    {cmd:White}, {cmd:Snow}, {cmd:HoneyDew}, {cmd:MintCream}, {cmd:Azure},
    {cmd:AliceBlue}, {cmd:GhostWhite}, {cmd:WhiteSmoke}, {cmd:SeaShell},
    {cmd:Beige}, {cmd:OldLace}, {cmd:FloralWhite}, {cmd:Ivory}, {cmd:AntiqueWhite},
    {cmd:Linen}, {cmd:LavenderBlush}, {cmd:MistyRose}

{phang}
    Grey colors ({stata colorpalette webcolors_grey, title(Grey colors) nonumbers:{it:view}}):{p_end}
{pmore}
    {cmd:Gainsboro}, {cmd:LightGray}, {cmd:Silver}, {cmd:DarkGray}, {cmd:DimGray},
    {cmd:Gray}, {cmd:LightSlateGray}, {cmd:SlateGray}, {cmd:DarkSlateGray},
    {cmd:Black}

{pstd}
    The color names can be abbreviated and typed in lowercase letters. If abbreviation is
    ambiguous, the first matching name in the alphabetically ordered list will be used. Furthermore,
    in case of name conflict, official Stata colors will take precedence over web colors; use
    the uppercase names as shown above to prevent such conflict (for example, {cmd:pink} will refer
    to official Stata pink, {cmd:Pink} will refer to web color pink).

{marker s2}{...}
{dlgtab:s2}

{pstd}
    Palette {cmd:s2} ({stata colorpalette s2:{it:view}}) contains the 15 colors
    used for p1 to p15 in Stata's {helpb scheme s2:s2color} scheme. {cmd:s2} is
    the default palette.

{marker s1}{...}
{dlgtab:s1}

{pstd}
    Palette {cmd:s1} ({stata colorpalette s1:{it:view}}) contains the colors
    used for p1 to p15 in Stata's {helpb scheme s1:s1color} scheme.

{marker s1r}{...}
{dlgtab:s1r}

{pstd}
    Palette {cmd:s1r} ({stata colorpalette s1r:{it:view}}) contains the colors
    used for p1 to p15 in Stata's {helpb scheme s1:s1rcolor} scheme.

{marker economist}{...}
{dlgtab:economist}

{pstd}
    Palette {cmd:economist} ({stata colorpalette economist:{it:view}}) contains the colors
    used for p1 to p15 in Stata's {helpb scheme economist:economist} scheme.

{marker mono}{...}
{dlgtab:mono}

{pstd}
    Palette {cmd:mono} ({stata colorpalette mono:{it:view}}) contains the gray scales
    used for p1 to p15 in Stata's monochrome schemes ({helpb scheme s2:s2mono},
    {helpb scheme s1:s1mono}).

{marker cblind}{...}
{dlgtab:cblind}

{pstd}
    The {cmd:cblind} palette ({stata colorpalette cblind:{it:view}}) contains
    colorblind-friendly colors suggested by
    {browse "http://jfly.iam.u-tokyo.ac.jp/color/":Okabe and Ito (2002)}, including
    gray as suggested at
    {browse "http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/#a-colorblind-friendly-palette":www.cookbook-r.com}.
    The same colors are also used (in different order and using {cmd:gs10} for gray)
    in the {cmd:plotplainblind} and {cmd:plottigblind} schemes by
    {browse "http://www.stata-journal.com/article.html?article=gr0070":Bischof (2017b)}. Type
    {stata colorpalette cblind, select(1 2 4 5 9 8 7 3 6)} for a palette equivalent to
    the one used in {cmd:plotplainblind}, and
    {stata colorpalette cblind, select(1 4 5 9 8 7 3 6)} for {cmd:plottigblind}.

{marker plottig}{...}
{dlgtab:plottig}

{pstd}
    Palette {cmd:plottig} ({stata colorpalette plottig:{it:view}}) contains the colors
    used for p1 to p15 in the {cmd:plottig} scheme by
    {browse "http://www.stata-journal.com/article.html?article=gr0070":Bischof (2017b)}. Most of these colors
    are the same as the colors produced by the {helpb colorpalette##hue:hue}
    color generator with default options ({stata colorpalette hue:{it:view}}), although
    in different order.

{marker 538}{...}
{dlgtab:538}

{pstd}
    Palette {cmd:538} ({stata colorpalette 538:{it:view}}) contains the colors
    used for p1 to p6, background, labels, axes etc., and CIs
    in the {cmd:538} scheme by
    {browse "http://ideas.repec.org/c/boc/bocode/s458404.html":Bischof (2017a)}. The palette replicates colors
    used at {browse "http://fivethirtyeight.com":fivethirtyeight.com}.

{marker mrc}{...}
{dlgtab:mrc}

{pstd}
    Palette {cmd:mrc} ({stata colorpalette mrc:{it:view}}) contains the colors
    used for p1 to p7 in the {cmd:mrc} scheme by
    {browse "http://ideas.repec.org/c/boc/bocode/s457703.html":Morris (2013)}. These are colors
    according to guidelines by the UK Medical Research Council.

{marker tfl}{...}
{dlgtab:tfl}

{pstd}
    Palette {cmd:tfl} ({stata colorpalette tfl:{it:view}}) contains the colors
    used for p1 to p8 in the {cmd:tfl} scheme by
    {browse "http://ideas.repec.org/c/boc/bocode/s458103.html":Morris (2015)}. The palette replicates
    Transport for London's corporate colors.

{marker burd}{...}
{dlgtab:burd}

{pstd}
    Palette {cmd:burd} ({stata colorpalette burd:{it:view}}) contains the colors
    used for p1 to p9 and for CIs in the {cmd:burd} scheme by
    {browse "http://ideas.repec.org/c/boc/bocode/s457623.html":Briatte (2013)}. The p1 to p9
    colors are a selection of colors from various
    {browse "http://colorbrewer2.org/":ColorBrewer} schemes.

{marker lean}{...}
{dlgtab:lean}

{pstd}
    Palette {cmd:lean} ({stata colorpalette lean:{it:view}}) contains
    gray scales used for p1area to p15area in schemes {cmd:lean1} and {cmd:lean2}
    by {browse "http://www.stata-journal.com/article.html?article=gr0002":Juul (2003)}.

{marker tableau}{...}
{dlgtab:tableau}

{pstd}
    The {cmd:tableau} ({stata colorpalette tableau, rows(10):{it:view}}) contains 20 categorical
    colors provided by {browse "http://dx.doi.org/10.1111/cgf.12127":Lin et al. (2013)}. The
    hex values of the colors have been taken from code provided by the authors at
    {browse "http://github.com/StanfordHCI/semantic-colors":GitHub}. The same colors are also used
    in {helpb colorpalette##d3:d3}.

{marker hue}{...}
{dlgtab:hue}

{pstd}
    The {cmd:hue} palette implements an algorithm that generates HCL colors with
    evenly spaced hues. The palette has been modeled after function {cmd:hue_pal()} from
    R's {cmd:scales} package by Hadley Wickham (see {browse "http://github.com/hadley/scales"}). This
    is the default color scheme used by R's {cmd:ggplot2} for categorical data
    (see {browse "http://ggplot2.tidyverse.org/reference/scale_hue.html"}). The {cmd:hue} palette
    with default options produces the same colors as the
    {cmd:intense} scheme of the {helpb colorpalette##hcl:hcl} color generator.

{pstd}
    Syntax:

{p 8 15 2}
    {cmd:hue} [{cmd:,} {opt h:ue(start end)} {opt c:hroma(#)} {opt l:uminance(#)}
        {opt dir:ection(#)} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    Options:

{phang}
    {opt hue(start end)} sets the range of hues on the 360 degree color
    wheel. The default is {bind:{cmd:hue(15 375)}}. If the difference between
    {it:start} and {it:end} is a multiple of 360, {it:end} will be reduced by
    360/n, where n is the number of requested colors (so that the space between
    the last and the first color is the same as between the other colors).

{phang}
    {opt chroma(#)} sets the colorfulness (color intensity), with
    {it:#} >= 0. The default is {cmd:chroma(100)}.

{phang}
    {opt luminance(#)} sets the brightness (amount of gray), with {it:#}
    in [0, 100]. The default is {cmd:luminance(65)}.

{phang}
    {opt direction(#)} determines the direction to travel around the color
    wheel. {cmd:direction(1)}, the default, travels clockwise; {cmd:direction(-1)}
    travels counter-clockwise.

{pstd}
    Examples:

        . {stata "colorpalette, span: hue, n(3) / hue, n(5) / hue, n(7) / hue, n(9)"}
        . {stata colorpalette hue, n(5) hue(90 -30) chroma(50) luminance(70)}

{marker hcl}{...}
{dlgtab:hcl/lch/jmh}

{pstd}
    The {cmd:hcl}, {cmd:lch}, and {cmd:jmh} palettes are color generators in the
    HCL (Hue-Chroma-Luminance) space (cylindrical representation of CIE L*u*v*), the LCh space
    (cylindrical representation of CIE L*a*b*), and the CIECAM02-based J'M'h space,
    respectively. The {cmd:hcl} implementation is based on R's {cmd:colorspace} package by
    {browse "http://CRAN.R-project.org/package=colorspace":Ihaka et al. (2016)}; also
    see {browse "http://dx.doi.org/10.1016/j.csda.2008.11.033":Zeileis et al. (2009)}
    and {browse "http://hclwizard.org":hclwizard.org}. The {cmd:lch} and
    {cmd:jmh} generators are implemented analogously.

{pstd}
    Let h1 and h2 be two hues on the 360 degree color wheel, c1 and c2 two
    chroma levels (M' in case of {cmd:jmh}), l1 and l2 two luminance levels (J' in case of
    {cmd:jmh}), p1 and p2 two power parameters, and i an index from 1 to n,
    where n is the number of requested colors. The colors are then generated
    according to the following formulas.

        Qualitative:
            H = h1 + (h2 - h1) * (i - 1) / (n - 1)
            C = c1
            L = l1

        Sequential:
            H = h2 - (h2 - h1) * j
            C = c2 - (c2 - c1) * j^p1
            L = l2 - (l2 - l1) * j^p2
            with j = (n - i) / (n - 1)

        Diverging:
            H = cond(j > 0, h1, h2)
            C = c1 * abs(j)^p1
            L = l2 - (l2 - l1) * abs(j)^p2
            with j = (n - 2*j + 1) / (n - 1)

{pstd}
    Syntax:

{p 8 15 2}
    {c -(}{cmd:hcl}|{cmd:lhc}|{cmd:jmh}{c )-} [{cmd:,} {it:scheme} {opt h:ue(h1 [h2])} {opt c:hroma(c1 [c2])} {opt l:uminance(l1 [l2])}
        {opt pow:er(p1 [p2])} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    Options:

{phang}
    {it:scheme} picks the type of color formula (qualitative, sequential,
    or diverging) and sets the default parameter values. {it:scheme} can be one of
    following ({cmd:qualitative} is the default; abbreviations are allowed).

        Qualitative {...}
(view: {stata "colorpalette, lc(white) n(9): hcl, qual / hcl, intense / hcl, dark / hcl, light / hcl, pastel":{it:hcl}}, {...}
{stata "colorpalette, lc(white) n(9): lch, qual / lch, intense / lch, dark / lch, light / lch, pastel":{it:lch}}, {...}
{stata "colorpalette, lc(white) n(9): jmh, qual / jmh, intense / jmh, dark / jmh, light / jmh, pastel":{it:jmh}})
{col 28} h1              h2   c1   l1
        {stata colorpalette hcl, qualitative:{bf:qualitative}}{col 28} 15  h1+360*(n-1)/n   60   70
        {stata colorpalette hcl, intense:{bf:intense}}        {col 28} 15  h1+360*(n-1)/n  100   65
        {stata colorpalette hcl, dark:{bf:dark}}              {col 28} 15  h1+360*(n-1)/n   80   60
        {stata colorpalette hcl, light:{bf:light}}            {col 28} 15  h1+360*(n-1)/n   50   80
        {stata colorpalette hcl, pastel:{bf:pastel}}          {col 28} 15  h1+360*(n-1)/n   35   85

        Sequential {...}
(view: {stata "colorpalette, n(9): hcl, blues / hcl, greens / hcl, grays / hcl, oranges / hcl, purples / hcl, reds / hcl, heat / hcl, heat2 / hcl, terrain / hcl, terrain2 / hcl, viridis / hcl, plasma / hcl, redblue":{it:hcl}}, {...}
{stata "colorpalette, n(9): lch, blues / lch, greens / lch, grays / lch, oranges / lch, purples / lch, reds / lch, heat / lch, heat2 / lch, terrain / lch, terrain2 / lch, viridis / lch, plasma / lch, redblue":{it:lch}}, {...}
{stata "colorpalette, n(9): jmh, blues / jmh, greens / jmh, grays / jmh, oranges / jmh, purples / jmh, reds / jmh, heat / jmh, heat2 / jmh, terrain / jmh, terrain2 / jmh, viridis / jmh, plasma / jmh, redblue":{it:jmh}})
{col 28} h1   h2   c1   c2   l1   l2   p1   p2
        {stata colorpalette hcl, sequential:{bf:sequential}}{col 28}260   h1   80   10   25   95    1   p1
        {stata colorpalette hcl, blues:{bf:blues}}          {col 28}260   h1   80   10   25   95    1   p1
        {stata colorpalette hcl, greens:{bf:greens}}        {col 28}145  125   80   10   25   95    1   p1
        {stata colorpalette hcl, grays:{bf:grays}}          {col 28}  0   h1    0    0   15   95    1   p1
        {stata colorpalette hcl, oranges:{bf:oranges}}      {col 28} 40   h1  100   10   50   95    1   p1
        {stata colorpalette hcl, purples:{bf:purples}}      {col 28}280   h1   70   10   20   95    1   p1
        {stata colorpalette hcl, reds:{bf:reds}}            {col 28} 10   20   80   10   25   95    1   p1
        {stata colorpalette hcl, heat:{bf:heat}}            {col 28}  0   90  100   30   50   90  0.2  1.0
        {stata colorpalette hcl, heat2:{bf:heat2}}          {col 28}  0   90   80   30   30   90  0.2  2.0
        {stata colorpalette hcl, terrain:{bf:terrain}}      {col 28}130    0   80    0   60   95  0.1  1.0
        {stata colorpalette hcl, terrain2:{bf:terrain2}}    {col 28}130   30   65    0   45   90  0.5  1.5
        {stata colorpalette hcl, viridis:{bf:viridis}}      {col 28}300   75   35   95   15   90  0.8  1.2
        {stata colorpalette hcl, plasma:{bf:plasma}}        {col 28}100   h1   60  100   15   95  2.0  0.9
        {stata colorpalette hcl, redblue:{bf:redblue}}      {col 28}  0 -100   80   40   40   75  1.0  1.0

        Diverging {...}
(view: {stata "colorpalette, n(9): hcl, bluered / hcl, bluered2 / hcl, bluered3 / hcl, greenorange / hcl, browngreen / hcl, pinkgreen / hcl, purplegreen":{it:hcl}}, {...}
{stata "colorpalette, n(9): lch, bluered / lch, bluered2 / lch, bluered3 / lch, greenorange / lch, browngreen / lch, pinkgreen / lch, purplegreen":{it:lch}}, {...}
{stata "colorpalette, n(9): jmh, bluered / jmh, bluered2 / jmh, bluered3 / jmh, greenorange / jmh, browngreen / jmh, pinkgreen / jmh, purplegreen":{it:jmh}})
{col 28} h1   h2   c1   l1   l2   p1   p2
        {stata colorpalette hcl, diverging:{bf:diverging}}    {col 28}260    0   80   30   95    1   p1
        {stata colorpalette hcl, bluered:{bf:bluered}}        {col 28}260    0   80   30   95    1   p1
        {stata colorpalette hcl, bluered2:{bf:bluered2}}      {col 28}260    0  100   50   95    1   p1
        {stata colorpalette hcl, bluered3:{bf:bluered3}}      {col 28}180  330   60   75   95    1   p1
        {stata colorpalette hcl, greenorange:{bf:greenorange}}{col 28}130   45  100   70   95    1   p1
        {stata colorpalette hcl, browngreen:{bf:browngreen}}  {col 28} 55  160   60   35   95    1   p1
        {stata colorpalette hcl, pinkgreen:{bf:pinkgreen}}    {col 28}340  128   90   35   95    1   p1
        {stata colorpalette hcl, purplegreen:{bf:purplegreen}}{col 28}300  128   60   30   95    1   p1

{pmore}
    The shown parameter values are for
   {cmd:hcl}; {cmd:lch} and {cmd:jmh} use adjusted values such that the end points
   of the generated colors are similar to the ones generated by {cmd:hcl} (see the source code of
   {stata viewsource colorpalette.ado:colorpalette.ado}).

{phang}
    {opt hue(h1 [h2])} overwrites the default values for h1 and h2. h1 and h2 are hues on
    the 360 degree color wheel.

{phang}
    {opt chroma(c1 [c2])} overwrites the default values for c1 and c2, with {it:c#} >= 0. c1 and c2
    determine the colorfulness (color intensity).

{phang}
    {opt luminance(l1 [l2])} overwrites the default values for l1 and l2, with {it:l#} in [0, 100]. l1 and l2
    determine the brightness.

{phang}
    {opt power(p1 [p2])} overwrites the default values for p1 and p2,
    with {it:p#} > 0. p1 and p2 determine the shape of the transition between
    chroma and luminance levels. For linear transitions, set {it:p#}=1; {it:p#}>1 makes
    the transition faster, {it:p#}<1 makes the transition slower.

{marker hsv}{...}
{dlgtab:hsv}

{pstd}
    The {cmd:hsv} palette is a HSV color generator (Hue-Saturation-Value). The
    implementation is partially based on R's {cmd:grDevices} package (which is
    part of the R core) and partially on {cmd:colorspace} by
    {browse "http://CRAN.R-project.org/package=colorspace":Ihaka et al. (2016)}.

{pstd}
    Let h1 and h2 be two hues on the 360 degree color wheel, s1 and s2 two
    saturation levels, v1 and v2 two value levels, p1 and p2 two power
    parameters, and i an index from 1 to n, where n is the number of requested
    colors. The HSV colors are then generated according to the following
    formulas.

        Qualitative:
            H = h1 + (h2 - h1) * (i - 1) / (n - 1)
            S = s1
            V = v1

        Sequential:
            H = h2 - (h2 - h1) * j
            S = s2 - (s2 - s1) * j^p1
            V = v2 - (v2 - v1) * j^p2
            with j = (n - i) / (n - 1)

        Diverging:
            H = cond(j > 0, h1, h2)
            S = s1 * abs(j)^p1
            V = v2 - (v2 - v1) * abs(j)^p2
            with j = (n - 2*j + 1) / (n - 1)

{pstd}
    Syntax:

{p 8 15 2}
    {cmd:hsv} [{cmd:,} {it:scheme} {opt h:ue(h1 [h2])} {opt sat:uration(s1 [s2])} {opt val:ue(v1 [v2])}
        {opt pow:er(p1 [p2])} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    Options:

{phang}
    {it:scheme} picks the type of color formula (qualitative, sequential,
    or diverging) and sets the default parameter values. {it:scheme} can be one of
    following ({cmd:qualitative} is the default; abbreviations are allowed).

        Qualitative {...}
({stata "colorpalette, lc(white) n(9): hsv, qual / hsv, intense / hsv, dark / hsv, light / hsv, pastel / hsv, rainbow":{it:view}}){...}
{col 28} h1              h2   s1   v1
        {stata colorpalette hsv, qualitative:{bf:qualitative}}{col 28} 15  h1+360*(n-1)/n   .4  .85
        {stata colorpalette hsv, intense:{bf:intense}}        {col 28} 15  h1+360*(n-1)/n   .6  .9
        {stata colorpalette hsv, dark:{bf:dark}}              {col 28} 15  h1+360*(n-1)/n   .6  .7
        {stata colorpalette hsv, light:{bf:light}}            {col 28} 15  h1+360*(n-1)/n   .3  .9
        {stata colorpalette hsv, pastel:{bf:pastel}}          {col 28} 15  h1+360*(n-1)/n   .2  .9
        {stata colorpalette hsv, rainbow:{bf:rainbow}}        {col 28} 15  h1+360*(n-1)/n    1   1

        Sequential {...}
({stata "colorpalette, n(9): hsv, blues / hsv, greens / hsv, grays / hsv, oranges / hsv, purples / hsv, reds / hsv, heat / hsv, terrain":{it:view}}){...}
{col 28} h1   h2   s1   s2   v1   v2   p1   p2
        {stata colorpalette hsv, sequential:{bf:sequential}}{col 28}240   h1   .8  .05   .6   1   1.2   p1
        {stata colorpalette hsv, blues:{bf:blues}}          {col 28}240   h1   .8  .05   .6   1   1.2   p1
        {stata colorpalette hsv, greens:{bf:greens}}        {col 28}140  120   1   .1    .3   1   1.2   p1
        {stata colorpalette hsv, grays:{bf:grays}}          {col 28}  0   h1   0    0    .1  .95  1.0   p1
        {stata colorpalette hsv, oranges:{bf:oranges}}      {col 28} 30   h1   1   .1    .9   1   1.2   p1
        {stata colorpalette hsv, purples:{bf:purples}}      {col 28}270   h1   1   .1    .6   1   1.2   p1
        {stata colorpalette hsv, reds:{bf:reds}}            {col 28}  0   20   1   .1    .6   1   1.2   p1
        {stata colorpalette hsv, heat:{bf:heat}}            {col 28}  0   60   1   .2     1   1   0.3   p1
        {stata colorpalette hsv, terrain:{bf:terrain}}      {col 28}120    0   1    0    .65 .95  0.7  1.5

        Diverging {...}
({stata "colorpalette, n(9): hsv, bluered / hsv, bluered2 / hsv, bluered3 / hsv, greenorange / hsv, browngreen / hsv, pinkgreen / hsv, purplegreen":{it:view}}){...}
{col 28} h1   h2   s1   v1   v2   p1   p2
        {stata colorpalette hsv, diverging:{bf:diverging}}    {col 28}240    0   .8   .6  .95  1.2   p1
        {stata colorpalette hsv, bluered:{bf:bluered}}        {col 28}240    0   .8   .6  .95  1.2   p1
        {stata colorpalette hsv, bluered2:{bf:bluered2}}      {col 28}240    0   .6   .8  .95  1.2   p1
        {stata colorpalette hsv, bluered3:{bf:bluered3}}      {col 28}175  320   .6   .8  .95  1.2   p1
        {stata colorpalette hsv, greenorange:{bf:greenorange}}{col 28}130   40   1    .8  .95  1.2   p1
        {stata colorpalette hsv, browngreen:{bf:browngreen}}  {col 28} 40  150   .8   .6  .95  1.2   p1
        {stata colorpalette hsv, pinkgreen:{bf:pinkgreen}}    {col 28}330  120   .9   .6  .95  1.2   p1
        {stata colorpalette hsv, purplegreen:{bf:purplegreen}}{col 28}290  120   .7   .5  .95  1.2   p1

{phang}
    {opt h:ue(h1 [h2])} overwrites the default values for h1 and h2. h1 and h2
    are hues on the 360 degree color wheel.

{phang}
    {opt sat:uration(s1 [s2])} sets overwrites the default values for
    s1 and s2, with {it:s#} in [0, 1]. s1 and s2 determine the colorfulness
    (color intensity).

{phang}
    {opt val:ue(v1 [v2])} overwrites the default values for v1 and v2, with
    {it:v#} in [0, 1]. l1 and l2 determine the brightness.

{phang}
    {opt power(p1 [p2])} overwrites the default values for p1 and p2,
    with {it:p#} > 0. p1 and p2 determine the shape of the transition between
    saturation and value levels. For linear transitions, set {it:p#}=1; {it:p#}>1 makes
    the transition faster, {it:p#}<1 makes the transition slower.

{marker cbrew}{...}
{dlgtab:ColorBrewer}

{pstd}
    ColorBrewer is a set of color schemes developed by Brewer et al. (2003; also
    see Brewer 2016). The colors are licensed under Apache License Version 2.0; see
    the copyright notes at
    {browse "http://www.personal.psu.edu/cab38/ColorBrewer/ColorBrewer_updates.html":ColorBrewer_updates.html}. For
    more information on ColorBrewer also see {browse "http://colorbrewer2.org/"}. The
    RGB values for the implementation of the colors in {cmd:colorpalette}
    have been taken from the Excel spreadsheet provided at
    {browse "http://www.personal.psu.edu/cab38/ColorBrewer/ColorBrewer_RGB.html":ColorBrewer_RGB.html}.
    The CMYK values have been taken from file cb.csv provided at
    {browse "http://github.com/axismaps/colorbrewer/":GitHub}. ColorBrewer palettes for Stata
    are also provided by {browse "http://github.com/matthieugomez/stata-colorscheme":Gomez (2015)}
    and by {browse "http://ideas.repec.org/c/boc/bocode/s458050.html":Buchanan (2015)}.

{pstd}The syntax for the ColorBrewer palettes is

{p 8 15 2}
    {it:scheme} [{cmd:,} {cmd:cmyk} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    where {it:scheme} is one of the following

{p2colset 9 22 24 2}{...}
{p2col:Qualitative ({stata "colorpalette, lc(black): Accent / Dark2 / Paired / Pastel1 / Pastel2 / Set1 / Set2 / Set3":{it:view}})}{p_end}
{p2col:{stata colorpalette Accent:{bf:Accent}}}8 accented colors for qualitative data{p_end}
{p2col:{stata colorpalette Dark2:{bf:Dark2}}}8 dark colors for qualitative data{p_end}
{p2col:{stata colorpalette Paired:{bf:Paired}}}12 paired colors for qualitative data{p_end}
{p2col:{stata colorpalette Pastel1:{bf:Pastel1}}}9 pastel colors for qualitative data{p_end}
{p2col:{stata colorpalette Pastel2:{bf:Pastel2}}}8 pastel colors for qualitative data{p_end}
{p2col:{stata colorpalette Set1:{bf:Set1}}}9 colors for qualitative data{p_end}
{p2col:{stata colorpalette Set2:{bf:Set2}}}8 colors for qualitative data{p_end}
{p2col:{stata colorpalette Set3:{bf:Set3}}}12 colors for qualitative data{p_end}

{p2col:Sequential (single hue) ({stata "colorpalette: Blues / Greens / Greys / Oranges / Purples / Reds":{it:view}})}{p_end}
{p2col:{stata colorpalette Blues:{bf:Blues}}}light blue to blue (3-9 colors){p_end}
{p2col:{stata colorpalette Greens:{bf:Greens}}}light green to green (3-9 colors){p_end}
{p2col:{stata colorpalette Greys:{bf:Greys}}}light gray to gray (3-9 colors){p_end}
{p2col:{stata colorpalette Oranges:{bf:Oranges}}}light orange to orange (3-9 colors){p_end}
{p2col:{stata colorpalette Purples:{bf:Purples}}}light purple to purple (3-9 colors){p_end}
{p2col:{stata colorpalette Reds:{bf:Reds}}}light red to red (3-9 colors){p_end}

{p2col:Sequential (multi-hue) ({stata "colorpalette: BuGn / PuBu / GnBu / OrRd / PuBu / PuBuGn / PuRd / RdPu / YlGn / YlGnBu / YlOrBr / YlOrRd":{it:view}})}{p_end}
{p2col:{stata colorpalette BuGn:{bf:BuGn}}}light blue to green (3-9 colors){p_end}
{p2col:{stata colorpalette BuPu:{bf:BuPu}}}light blue to purple (3-9 colors){p_end}
{p2col:{stata colorpalette GnBu:{bf:GnBu}}}light green to blue (3-9 colors){p_end}
{p2col:{stata colorpalette OrRd:{bf:OrRd}}}light orange to red (3-9 colors){p_end}
{p2col:{stata colorpalette PuBu:{bf:PuBu}}}light purple to blue (3-9 colors){p_end}
{p2col:{stata colorpalette PuBuGn:{bf:PuBuGn}}}light purple over blue to green (3-9 colors){p_end}
{p2col:{stata colorpalette PuRd:{bf:PuRd}}}light purple to red (3-9 colors){p_end}
{p2col:{stata colorpalette RdPu:{bf:RdPu}}}light red to purple (3-9 colors){p_end}
{p2col:{stata colorpalette YlGn:{bf:YlGn}}}light yellow to green (3-9 colors){p_end}
{p2col:{stata colorpalette YlGnBu:{bf:YlGnBu}}}light yellow over green to blue (3-9 colors){p_end}
{p2col:{stata colorpalette YlOrBr:{bf:YlOrBr}}}light yellow over orange to brown (3-9 colors){p_end}
{p2col:{stata colorpalette YlOrRd:{bf:YlOrRd}}}light yellow over orange to red (3-9 colors){p_end}

{p2col:Diverging ({stata "colorpalette: BrBG / PRGn / PiYG / PuOr / RdBu / RdGy / RdYlBu / RdYlGn / Spectral":{it:view}})}{p_end}
{p2col:{stata colorpalette BrBG:{bf:BrBG}}}brown to green, light gray mid (3-11 colors){p_end}
{p2col:{stata colorpalette PiYG:{bf:PiYG}}}pink to green, light gray mid (3-11 colors){p_end}
{p2col:{stata colorpalette PRGn:{bf:PRGn}}}purple to green, light gray mid (3-11 colors){p_end}
{p2col:{stata colorpalette PuOr:{bf:PuOr}}}purple to orange, light gray mid (3-11 colors){p_end}
{p2col:{stata colorpalette RdBu:{bf:RdBu}}}red to blue, light gray mid (3-11 colors){p_end}
{p2col:{stata colorpalette RdGy:{bf:RdGy}}}red to gray, white mid (3-11 colors){p_end}
{p2col:{stata colorpalette RdYlBu:{bf:RdYlBu}}}red to blue, yellow mid (3-11 colors){p_end}
{p2col:{stata colorpalette RdYlGn:{bf:RdYlGn}}}red to green, yellow mid (3-11 colors){p_end}
{p2col:{stata colorpalette Spectral:{bf:Spectral}}}red - orange - yellow - green - blue (3-11 colors){p_end}

{phang}
    and option {cmd:cmyk} requests the CMYK variant of the scheme. The default is to use
    the RGB variant.

{marker viridis}{...}
{dlgtab:viridis}

{pstd}
    The viridis collection provides perceptually uniform colormaps from
    {browse "http://matplotlib.org":matplotlib}, a Python 2D plotting library (Hunter 2007). The
    color values have been taken from file
    {browse "https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/_cm_listed.py":_cm_listed.py}
    at GitHub.

{pstd}The syntax for the viridis palettes is

{p 8 15 2}
    {it:colormap} [{cmd:,} {opt ra:nge(lb [ub])} {opt shift:ed} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    where {it:colormap} is one of the following
    ({stata "colorpalette: viridis / plasma / inferno / magma / cividis / twilight / twilight, shifted":{it:view}}).

{p2colset 9 22 24 2}{...}
{p2col:{stata colorpalette viridis:{bf:viridis}}}blue - green - yellow (sequential){p_end}
{p2col:{stata colorpalette plasma:{bf:plasma}}}blue - red - yellow (sequential){p_end}
{p2col:{stata colorpalette inferno:{bf:inferno}}}black - blue - orange - yellow (sequential){p_end}
{p2col:{stata colorpalette magma:{bf:magma}}}black - blue - red - yellow (sequential){p_end}
{p2col:{stata colorpalette cividis:{bf:cividis}}}blue - olive - yellow (sequential){p_end}
{p2col:{stata colorpalette twilight:{bf:twilight}}}blue - russet (diverging){p_end}

{pstd}
    Options:

{phang}
    {opt range(lb [ub])} selects the range of the colormap to be used, where {it:lb} and {it:ub}
    must be in [0,1]. The default is {cmd:range(0 1)}. If {it:lb} is larger than
    {it:ub}, the colors are returned in reverse order.

{phang}
    {opt shifted} only has an effect on {cmd:twilight} and shifts
    the color pattern from light extremes and dark in the middle to dark extremes and
    light in the middle.

{marker matplotlib}{...}
{dlgtab:matplotlib}

{pstd}
    The {cmd:matplotlib} palette provides several colormaps from
    {browse "http://matplotlib.org":matplotlib}, a Python 2D plotting library (Hunter 2007). The
    definitions of the colormaps have been taken from file
    {browse "https://github.com/matplotlib/matplotlib/blob/master/lib/matplotlib/_cm.py":_cm.py}
    at GitHub.

{pstd}The syntax for the {cmd:matplotlib} palette is

{p 8 15 2}
    {cmd:matplotlib} [{cmd:,} {it:colormap} {opt ra:nge(lb [ub])} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    where {it:colormap} is one of the following (abbreviations allowed)
    ({stata "colorpalette: matplotlib, jet / matplotlib, autumn / matplotlib, spring / matplotlib, summer / matplotlib, winter / matplotlib, bone / matplotlib, cool / matplotlib, copper / matplotlib, coolwarm / matplotlib, hot":{it:view}})

{p2colset 9 22 24 2}{...}
{p2col:{stata colorpalette matplotlib, jet:{bf:jet}}}blue - green - yellow - red; the default{p_end}
{p2col:{stata colorpalette matplotlib, autumn:{bf:autumn}}}red - yellow{p_end}
{p2col:{stata colorpalette matplotlib, spring:{bf:spring}}}magenta - yellow{p_end}
{p2col:{stata colorpalette matplotlib, summer:{bf:summer}}}green - yellow{p_end}
{p2col:{stata colorpalette matplotlib, winter:{bf:winter}}}blue - lime{p_end}
{p2col:{stata colorpalette matplotlib, bone:{bf:bone}}}black - bluish gray - white{p_end}
{p2col:{stata colorpalette matplotlib, cool:{bf:cool}}}cyan - magenta{p_end}
{p2col:{stata colorpalette matplotlib, copper:{bf:copper}}}black - orange/brown{p_end}
{p2col:{stata colorpalette matplotlib, coolwarm:{bf:coolwarm}}}blue - red (diverging){p_end}
{p2col:{stata colorpalette matplotlib, hot:{bf:hot}}}heat colors{p_end}

{pstd}
    and {opt range(lb [ub])} selects the range of the colormap to be used, where {it:lb} and {it:ub}
    must be in [0,1]. The default is {cmd:range(0 1)}. If {it:lb} is larger than
    {it:ub}, the colors are returned in reverse order.

{marker ptol}{...}
{dlgtab:ptol}

{pstd}
    The {cmd:ptol} collection provides color schemes suggested by
    {browse "https://personal.sron.nl/~pault/colourschemes.pdf":Tol (2012)}. The
    syntax is

{p 8 15 2}
    {cmd:ptol} [{cmd:,} {it:scheme} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    where {it:scheme} is one of the following (abbreviations allowed)
    ({stata "colorpalette: ptol, n(3) / ptol, n(5) / ptol, n(9) / ptol, div n(3) / ptol, div n(5) / ptol, div n(9) / ptol, rain n(4) / ptol, rain n(6) / ptol, rain n(8)":{it:view}}).

{p2colset 9 24 26 2}{...}
{p2col:{stata colorpalette ptol, qualitative:{bf:qualitative}}}1-12 qualitative colors; the default{p_end}
{p2col:{stata colorpalette ptol, diverging:{bf:diverging}}}3-11 diverging colors; very similar to reverse {helpb colorpalette##cbrew:RdYlBu}{p_end}
{p2col:{stata colorpalette ptol, rainbow:{bf:rainbow}}}4-12 rainbow colors{p_end}

{marker d3}{...}
{dlgtab:d3}

{pstd}
    The {cmd:d3} collection provides color schemes from
    {browse "http://d3js.org/":D3.js}, using the color values found at
    {browse "https://github.com/d3/d3-scale/blob/master/README.md#category-scales":github.com/d3}. The
    syntax is

{p 8 15 2}
    {cmd:d3} [{cmd:,} {it:scheme} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    where {it:scheme} is one of the following
    ({stata "colorpalette: d3, 10 / d3, 20 / d3, 20b / d3, 20c":{it:view}}).

{p2colset 9 16 18 2}{...}
{p2col:{stata colorpalette d3, 10:{bf:10}}}10 categorical colors; the default; same as first 10 colors in {helpb colorpalette##tableau:tableau}{p_end}
{p2col:{stata colorpalette d3, 20:{bf:20}}}20 categorical colors in pairs; same colors as in {helpb colorpalette##tableau:tableau}, but ordered differently{p_end}
{p2col:{stata colorpalette d3, 20b:{bf:20b}}}20 categorical colors in groups of four{p_end}
{p2col:{stata colorpalette d3, 20c:{bf:20c}}}20 categorical colors in groups of four{p_end}

{marker lin}{...}
{dlgtab:lin}

{pstd}
    The {cmd:lin} collection provides semantic color schemes suggested by
    {browse "http://dx.doi.org/10.1111/cgf.12127":Lin et al. (2013)}. The values
    of the colors have been taken from the source code of the
    {cmd:brewscheme} package by
    {browse "http://ideas.repec.org/c/boc/bocode/s458050.html":Buchanan (2015)} (brewextra.ado,
    version 1.0.0, 21 March 2016).

{pstd}The syntax is

{p 8 15 2}
    {cmd:lin} [{cmd:,} {it:scheme} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    where {it:scheme} is one of the following (abbreviations allowed):

{p2colset 9 31 33 2}{...}
{p2col:{stata colorpalette lin, carcolor:{bf:carcolor}}}6 car colors (selected by Turkers){p_end}
{p2col:{stata colorpalette lin, carcolor algorithm:{bf:carcolor algorithm}}}6 car colors (algorithm selected){p_end}
{p2col:{stata colorpalette lin, food:{bf:food}}}7 food colors (selected by Turkers){p_end}
{p2col:{stata colorpalette lin, food algorithm:{bf:food algorithm}}}7 food colors (algorithm selected){p_end}
{p2col:{stata colorpalette lin, features:{bf:features}}}5 feature colors (selected by Turkers){p_end}
{p2col:{stata colorpalette lin, features algorithm:{bf:features algorithm}}}5 feature colors (algorithm selected){p_end}
{p2col:{stata colorpalette lin, activities:{bf:activities}}}5 activity colors (selected by Turkers){p_end}
{p2col:{stata colorpalette lin, activities algorithm:{bf:activities algorithm}}}5 activity colors (algorithm selected){p_end}
{p2col:{stata colorpalette lin, fruits:{bf:fruits}}}7 fruit colors; the default (selected by expert){p_end}
{p2col:{stata colorpalette lin, fruits algorithm:{bf:fruits algorithm}}}7 fruit colors; the default (algorithm selected){p_end}
{p2col:{stata colorpalette lin, vegetables:{bf:vegetables}}}7 vegetable colors (selected by expert){p_end}
{p2col:{stata colorpalette lin, vegetables algorithm:{bf:vegetables algorithm}}}7 vegetable colors (algorithm selected){p_end}
{p2col:{stata colorpalette lin, drinks:{bf:drinks}}}7 drinks colors (selected by expert){p_end}
{p2col:{stata colorpalette lin, drinks algorithm:{bf:drinks algorithm}}}7 drinks colors (algorithm selected){p_end}
{p2col:{stata colorpalette lin, brands:{bf:brands}}}7 brands colors (selected by expert){p_end}
{p2col:{stata colorpalette lin, brands algorithm:{bf:brands algorithm}}}7 brands colors (algorithm selected){p_end}

{marker spmap}{...}
{dlgtab:spmap}

{pstd}
    The {cmd:spmap} collection provides color schemes from the {cmd:spmap}
    package by {browse "http://ideas.repec.org/c/boc/bocode/s456812.html":Pisati (2007)}. The
    implementation is based on code from spmap_color.ado (version 1.3.0, 13 March 2017).

{pstd}
    The syntax is

{p 8 15 2}
    {cmd:spmap} [{cmd:,} {it:scheme} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    where {it:scheme} is one of the following (abbreviations allowed)
    ({stata "colorpalette, n(16) lc(white): spmap, bl / spmap, green / spmap, grey / spmap, red / spmap, rain / spmap, heat / spmap, ter / spmap, top":{it:view}}):

{p2colset 9 24 26 2}{...}
{p2col:{stata colorpalette spmap, blues:{bf:blues}}}light blue to blue (2-99 colors); the default{p_end}
{p2col:{stata colorpalette spmap, greens:{bf:greens}}}light green to green (2-99 colors){p_end}
{p2col:{stata colorpalette spmap, greys:{bf:greys}}}light gray to black (2-99 colors){p_end}
{p2col:{stata colorpalette spmap, reds:{bf:reds}}}light red to red (2-99 colors){p_end}
{p2col:{stata colorpalette spmap, rainbow:{bf:rainbow}}}2-99 rainbow colors{p_end}
{p2col:{stata colorpalette spmap, heat:{bf:heat}}}2-16 heat colors{p_end}
{p2col:{stata colorpalette spmap, terrain:{bf:terrain}}}2-16 terrain colors{p_end}
{p2col:{stata colorpalette spmap, topological:{bf:topological}}}2-16 topological colors{p_end}

{marker sfso}{...}
{dlgtab:sfso}

{pstd}
    The {cmd:sfso} collection provides color schemes by the Swiss Federal Statistical
    Office (using hex and CMYK codes found in Bundesamt f{c u:}r Statistik 2017). The
    syntax is

{p 8 15 2}
    {cmd:sfso} [{cmd:,} {it:scheme} {cmd:cmyk} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    where {it:scheme} is one of the following

{p2colset 9 24 26 2}{...}
{p2col:Sequential ({stata "colorpalette: sfso, br / sfso, or / sfso, red / sfso, pi / sfso, pu / sfso, vi / sfso, bl / sfso, ltbl / sfso, tu / sfso, green / sfso, ol / sfso, black":{it:view}})}{p_end}
{p2col:{stata colorpalette sfso, brown:{bf:brown}}}dark brown to light brown (6 colors){p_end}
{p2col:{stata colorpalette sfso, orange:{bf:orange}}}dark orange to light orange (6 colors){p_end}
{p2col:{stata colorpalette sfso, red:{bf:red}}}dark red to light red (6 colors){p_end}
{p2col:{stata colorpalette sfso, pink:{bf:pink}}}dark pink to light pink (6 colors){p_end}
{p2col:{stata colorpalette sfso, purple:{bf:purple}}}dark purple to light purple (6 colors){p_end}
{p2col:{stata colorpalette sfso, violet:{bf:violet}}}dark violet to light violet (6 colors){p_end}
{p2col:{stata colorpalette sfso, blue:{bf:blue}}}dark blue to light blue (7 colors); the default{p_end}
{p2col:{stata colorpalette sfso, ltblue:{bf:ltblue}}}lighter version of {cmd:blue} (6 colors){p_end}
{p2col:{stata colorpalette sfso, turquoise:{bf:turquoise}}}dark turquoise to light turquoise (6 colors){p_end}
{p2col:{stata colorpalette sfso, green:{bf:green}}}dark green to light green (6 colors){p_end}
{p2col:{stata colorpalette sfso, olive:{bf:olive}}}dark olive to light olive (6 colors){p_end}
{p2col:{stata colorpalette sfso, black:{bf:black}}}dark gray to light gray (6 colors){p_end}

{p2col:Semantic ({stata "colorpalette: sfso, parties / sfso, languages / sfso, votes":{it:view}})}{p_end}
{p2col:{stata colorpalette sfso, parties:{bf:parties}}}colors used by the SFSO for Swiss parties (11 colors){p_end}
{p2col:{stata colorpalette sfso, languages:{bf:languages}}}colors used by the SFSO for languages (5 colors){p_end}
{p2col:{stata colorpalette sfso, votes:{bf:votes}}}colors used by the SFSO for results from votes (10 colors){p_end}

{phang}
    and option {cmd:cmyk} requests the CMYK variant of the scheme. The default is to use
    the RGB variant.

{marker myname}{...}
{dlgtab:myname}

{pstd}
    A personal named palette can be provided in form of a program called
    {cmd:colorpalette_}{it:myname}, where {it:myname} is the name of the
    palette. Palette {it:myname} will then be available to {cmd:colorpalette}
    like any other palette. Your program should return the color definitions as
    a comma-separated list in local macro {cmd:P}. In addition you may provide
    a comma-separated list of descriptions in local macro {cmd:I}. For example,
    the following program provides a palette called {cmd:bootstrap3} containing
    the semantic colors used for buttons in
    {browse "http://getbootstrap.com/docs/3.3":Bootstrap v3.3}:

        {com}program colorpalette_bootstrap3
            c_local P #ffffff,#337ab7,#5cb85c,#5bc0de,#f0ad4e,#d9534f, ///
                      #e6e6e6,#286090,#449d44,#31b0d5,#ec971f,#c9302c
            c_local I default,primary,success,info,warning,danger, ///
                default.focus, primary.focus,success.focus,info.focus, ///
                warning.focus,danger.focus
            c_local class qualitative
        end{txt}

{pstd}
    After defining the program, you can, for example, type

        {com}. colorpalette bootstrap3, rows(6){txt}

{pstd}
    to view the palette. More complicated definitions of palettes that
    take account of options are also possible. See the palette definitions
    {stata viewsource colorpalette.ado:colorpalette.ado} for examples.

{marker mata}{...}
{dlgtab:Mata ColrSpace object}

{pstd}
    {cmd:colorpalette} can retrieve colors from a Mata
    {helpb colrspace:ColrSpace} object. The syntax is

        {cmdab:m:ata(}{it:name}{cmd:)} [{cmd:,} {help colorpalette##opts:{it:palette_options}} ]

{pstd}
    where {it:name} is the name the object. Example:

        . {stata `"mata: C1 = C2 = ColrSpace()"'}
        . {stata `"mata: C1.palette("s2", 5)"'}
        . {stata `"mata: C1.pname("original colors")"'}
        . {stata `"mata: C2.set(C1.get("Lab") :* (1.2, 1, 1), "Lab")"'}
        . {stata `"mata: C2.pname("luminance * 1.2")"'}
        . {stata "colorpalette: mata(C1) / mata(C2)"}
        . {stata "colorpalette mata(C2), cblind(0.5) title(50% deuteranomaly)"}


{marker examples}{...}
{title:Example}

{pstd}
    Apart from viewing color palettes, {cmd:colorpalette} is useful for
    retrieving colors that can then be passed through to a graph command. Here is
    an example of a contour plot using the {cmd:terrain} scheme from
    the {cmd:hcl} color generator:

        . {stata sysuse sandstone, clear}
        . {stata colorpalette jmh, terrain n(10) nograph}
{p 8 12 2}
        . {stata twoway contour depth northing easting, levels(`r(n)') ccolors(`r(p)')}


{marker returns}{...}
{title:Saved results}

{pstd}
    {cmd:colorpalette} stores the following in {cmd:r()} (Syntax 1 only):

{synoptset 16 tabbed}{...}
{p2col 5 16 20 2: Scalars}{p_end}
{synopt:{cmd:r(n)}}number of returned colors{p_end}

{synoptset 16 tabbed}{...}
{p2col 5 16 20 2: Macros}{p_end}
{synopt:{cmd:r(ptype)}}{cmd:color}{p_end}
{synopt:{cmd:r(pname)}}name of palette or {cmd:custom}{p_end}
{synopt:{cmd:r(pclass)}}palette class (if provided){p_end}
{synopt:{cmd:r(pnote)}}additional information on palette (if provided){p_end}
{synopt:{cmd:r(p)}}space separated list of colors{p_end}
{synopt:{cmd:r(p#)}}#th color{p_end}
{synopt:{cmd:r(p#info)}}info of #th color (if provided){p_end}


{marker references}{...}
{title:References}

{phang}
    Bischof, D. 2017a. G538SCHEMES: module to provide graphics schemes for
    http://fivethirtyeight.com. Available from
    {browse "http://ideas.repec.org/c/boc/bocode/s458404.html"}.
    {p_end}
{phang}
    Bischof, D. 2017b. {browse "http://www.stata-journal.com/article.html?article=gr0070":New graphic schemes for Stata: plotplain and plottig}.
    The Stata Journal 17(3): 748–759.
    {p_end}
{phang}
    Briatte, F. 2013. SCHEME-BURD: Stata module to provide a
    ColorBrewer-inspired graphics scheme with qualitative and blue-to-red
    diverging colors. Available from
    {browse "http://ideas.repec.org/c/boc/bocode/s457623.html"}.
    {p_end}
{phang}
    Brewer, C. A., G. W. Hatchard, M. A. Harrower. 2003. {browse "http://doi.org/10.1559/152304003100010929":ColorBrewer in Print: A Catalog of Color Schemes for Maps}.
    Cartography and Geographic Information Science 30(1): 5–32.
    {p_end}
{phang}
    Brewer, C. A. 2016. Designing Better Maps. A Guide for GIS Users. 2nd ed. Redlands, CA: Esri Press.
    {p_end}
{phang}
    Buchanan, B. 2015. BREWSCHEME: Stata module for generating customized
    graph scheme files. Available from
    {browse "http://ideas.repec.org/c/boc/bocode/s458050.html"}.
    {p_end}
{phang}
    Bundesamt f{c u:}r Statistik 2017. Layoutrichtlinien. Gestaltungs und
    Redaktionsrichtlinien für Publikationen, Tabellen und grafische
    Assets. Version 1.1.1. Neuchâtel.
    {p_end}
{phang}
    Gomez, M. 2015. Stata command to generate color schemes. Available from
    {browse "http://github.com/matthieugomez/stata-colorscheme"}.
    {p_end}
{phang}
    Hunter, J. D. 2007. {browse "http://dx.doi.org/10.1109/MCSE.2007.55":Matplotlib: A 2D graphics environment}. Computing
    in Science & Engineering 9(3): 90-95.
    {p_end}
{phang}
    Ihaka, R., P. Murrell, K. Hornik, J. C. Fisher, R. Stauffer, A. Zeileis.
    2016. colorspace: Color Space Manipulation. R package version 1.3-2.
    Available from {browse "http://CRAN.R-project.org/package=colorspace"}.
    {p_end}
{phang}
    Juul, S. 2003. {browse "http://www.stata-journal.com/article.html?article=gr0002":Lean mainstream schemes for Stata 8 graphics}. The Stata
    Journal 3(3): 295-301.
    {p_end}
{phang}
    Lin, S., J. Fortuna, C. Kulkarni, M. Stone,
    J. Heer. 2013. {browse "http://dx.doi.org/10.1111/cgf.12127":Selecting Semantically-Resonant Colors for Data Visualization}. Computer
    Graphics Forum 32(3pt4): 401-410.
    {p_end}
{phang}
    Morris, T. 2013. SCHEME-MRC: Stata module to provide graphics scheme for UK
    Medical Research Council. Available from
    {browse "http://ideas.repec.org/c/boc/bocode/s457703.html"}.
    {p_end}
{phang}
    Morris, T. 2015. SCHEME-TFL: Stata module to provide graph scheme, based on
    Transport for London's corporate colour pallette. Available from
    {browse "http://ideas.repec.org/c/boc/bocode/s458103.html"}.
    {p_end}
{phang}
    Okabe, M., K. Ito. 2002. Color Universal Design (CUD). How to make figures and presentations that
    are friendly to Colorblind people. Available from
    {browse "http://jfly.iam.u-tokyo.ac.jp/color/"}.
    {p_end}
{phang}
    Pisati, M. 2007. SPMAP: Stata module to visualize spatial data. Available
    from {browse "http://ideas.repec.org/c/boc/bocode/s456812.html"}.
    {p_end}
{phang}
    Tol, P. 2012. Colour Schemes. SRON Technical Note, Doc. no. SRON/EPS/TN/09-002. Available
    from {browse "https://personal.sron.nl/~pault/colourschemes.pdf"}.
    {p_end}
{phang}
    Zeileis, A., K. Hornik, P. Murrell. 2009.
    {browse "http://dx.doi.org/10.1016/j.csda.2008.11.033":Escaping RGBland: Selecting Colors for Statistical Graphics}.
    Computational Statistics & Data Analysis 53: 3259-3270.
    {p_end}


{marker author}{...}
{title:Author}

{pstd}
    Ben Jann, University of Bern, ben.jann@soz.unibe.ch

{pstd}
    Thanks for citing this software as

{pmore}
    Jann, B. (2018). {browse "https://www.stata-journal.com/article.html?article=gr0075":Color palettes for Stata graphics}. The Stata Journal
    18(4): 765-785.

{pstd}
    or

{pmore}
    Jann, B. (2017). palettes: Stata module providing color palettes, symbol
    palettes, and line pattern palettes. Available from
    {browse "http://ideas.repec.org/c/boc/bocode/s458444.html"}.


{marker alsosee}{...}
{title:Also see}

{psee}
    Online:  help for {helpb colrspace}, {helpb colorpalette9}, {helpb symbolpalette}, {helpb linepalette}, {helpb grstyle set}, {helpb graph}, {help colorstyle}

