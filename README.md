# palettes

Stata module providing color palettes, symbol palettes, and line pattern
palettes

The `palettes` module contains four commands: `colorpalette`, `colorpalette9`,
`symbolpalette`, and `linepalette`. The commands provide color, symbol, and
line pattern palettes for use in Stata graphs.

To install the `palettes` package from the SSC Archive, type

    . ssc install palettes, replace

in Stata. In Stata 14.2 or newer, the `colrspace` package is required. To install this package, type

    . ssc install colrspace, replace

Command `colorpalette9` is a variant of `colorpalette` that has
limited functionality but runs under Stata 9.2 or newer and does not require 
`colrspace`.

---

Installation from GitHub:

    . net install palettes, replace from(https://raw.githubusercontent.com/benjann/palettes/master/)

---

Main changes:

    23may2024
    colorpalette (v 1.2.7)
    - error was returned if a single opacity or intensity operator without
      color or palette was specified; this is fixed

    20may2024
    colorpalette (v 1.2.6)
    - no longer checking for "=" in colorlist when applying n()

    20may2024
    colorpalette (v 1.2.5)
    - option n() now recycles colorlist (rather than interpolating) if there are
      elements that are supported by Stata's colorstyle but cannot be interpolated
      (like, e.g., "none" or "."); furthermore, the last color will be repeated if
      colorlist ends with .. or ...
    - the behavior of option -noexpand- slightly changed; if the
      number of requested colors by n() is smaller then the minimum number of
      colors defined in a palette, -noexpand- now always causes the first few
      colors to be selected; the old behavior was to apply such selection only
      in case of qualitative palettes

    19may2024
    colorpalette (v 1.2.4)
    - default palette in Stata 18 now -st-
    - opacity and intensity operators can now be applied to palette names; the
      specified operators will take precedence over opacity() and intensity()
    - new option -iconvert()- to resolve intensity multipliers
    - new option -torder()- to determine order in which transformation options are
      applied
    - options gscale() and cblind() now resolve intensity multipliers; specify
      suboption noiconvert for old behavior
    - specifying a colorlist enclosed in parentheses failed if the list contained
      more than three tokens; this is fixed
    colorcheck (v 1.0.1)
    - intensity multipliers were handled inconsistently; this is fixed; intensity
      multipliers are now resolved before converting colors and computing distances
    - (resolved) normal sight colors are stored in r(p_norm)
    - normal sight colors are now displayed without applying opacity settings (i.e.,
      opacity settings are now completely ignored)

    02jun2022
    - updated colorpalette.sthlp to reflect renaming of -pals- palettes
    
    18apr2022
    - colorpalette (v 1.2.3)
      o options chroma() and luminance() of the HCL/LCH/JMh color generator only
        allowed one argument instead of two; this is fixed
      o option -noinfo- added to syntax 1 graph options;
      o some corrections to helpfile

    03apr2022
    - command -colorcheck- added
    - colorpalette (v 1.2.2)
      o new barwidth() graph option in syntax 2
      o shift() now allows non-integer argument

    01apr2022 (colorpalette v 1.2.1)
    - help updated to cover new palettes supported by ColrSpace
    - new options drop() and shift()
    - support for cyclic (circular) palettes added
    - discontinued backward compatibility to -colorpalette9- syntax

    23mar2022 (colorpalette v 1.2.0)
    - option class() had no effect if used with a colorlist or with a custom palette
      provided by a program; this is fixed

    27may2020
    - updated to new version of ColrSpace
    - option pname() is now called name()
    - options luminate() and saturate() can no longer be abbreviated (to avoid 
      confliction with options of color generators)
    - interpolation was applied to palettes read from ado-files even if this was
      not necessary; this is fixed
    - palette class was not returned if reading palette from ado-file; this is fixed
    
    19may2020
    - some adaptions due to changes in ColrSpace()
    - some syntax parsting now done in Mata so that ColrSpace object only
      has to be generated once
    
    15may2020
    - gscale() and cvd() now allow numlists
    
    14may2020
    - colorpalete has new syntax
      o palettes are now specified as "palettename scheme ..."; old syntax 
        (schemes as options) still works, but is undocumented
      o colorlist can be included in parentheses to avoid name conflict with
        palettes; automatic detection of color list specification vs. palette
        specification has been improved
    - further changes to colorpalette:
      o option pname() added (set palette name)
      o option stylefiles() added (write color style files)
      o option locals() added (save colors as locals)
    
    10may2020 (colorpalette.ado)
    - globals() has been applied to each palette individually when multiple palettes
      were appended in a single call to -colorpalette-; this is changed; globals() 
      is now applied at the end, after collecting the colors from all palettes
    - globals() now also has a suffix() option
    - color names have been updated for some palettes so that they comply with
      Stata's naming conventions
    
    09may2020 (colorpalette.ado)
    - option -globals- added to store colors as globals
    - -webcolors- added as a palette
    - some fixes to help file
    
    17apr2020
    - installation files added to GitHub distribution
    
    31jan2019
    - major update to colorpalette
      o color management ported to Mata: ColrSpace() class
      o colorpalette9 provided for backward compatibility
      o improved ipolate(); new gscale(), cblind(), intensify(), saturate(), luminate() 
      o additional input formats such as "xyz # # #" etc. as well as 140 web colors
      o new viridis and other matplotlib palettes
      o new lch and jmh color generators
      o tableau is now a separate palette
      o mata(name) to obtain colors from Mata ColrSpace object
      o new order() option
      o now automatically recycles/interpolates colors depending on n(); can be 
        turned off by -noexpand-; class() option to determine palette class 
        (relevant for deciding whether to recycle or interpolate)
      o forcergb to always use rgb, for example also for named Stata colors
      o now displays error if options are specified that are not allowed with palette
      o now displays error if a color is not found
      o graph options:
        . new nonumbers option
        . new names option in syntax 1
        . new span option in syntax 2
        . option plabels() is now labels() (plabels() still supported)

    10sep2018
    - option -ipolate()- added to -colorpalette-

    12apr2018
    - command -colorpalette- now supports combining colors from different palettes
    - the list of palettes provided to -colorpalette:- can now contain . to insert 
      gaps
    - command -symbolpalette- displayed an error message if a custom palette with 
      just one element was specified; this is fixed
  
    22dec2017
    - released on SSC

