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

