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

