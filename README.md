# GPSCorrelate

Daniel Foote, 2005.

## Status

*UPDATE* Dan Fandrich has taken over maintenance of GPSCorrelate.  Visit the
new [home page](https://dfandrich.github.io/gpscorrelate/) and [Github
repo](https://github.com/dfandrich/gpscorrelate/).

## What is it?

Digital cameras are cool. So is GPS. And, EXIF tags are really cool too.

What happens when you merge the three? You end up with a set of photos taken with a digital camera that are "stamped" with the location at which they were taken.

The EXIF standard defines a number of tags that are for use with GPS.

A variety of programs exist around the place to match GPS data with digital camera photos, but most of them are Windows or MacOS only. Which doesn't really suit me that much. Also, each one takes the GPS data in a different format.

So I wrote my own. A little bit of C, a little bit of C++, a shade of GTK+, and you end up with... what I have here. I wrote both a command line and GUI version of the program.

## Things you should know:

* The program takes GPS data in GPX format. This is an XML format. I recommend using GPSBabel - it can convert from lots of formats to GPX, as well as download from several brands of popular GPS receivers.
* The program can "interpolate" between points (linearly) to get better results. (That is, for  GPS logs that are not one sample per second, like those I get off my Garmin eTrex GPS)
* The resolution is down to one second. But that should be good enough for most things. (This is a limit of the EXIF tags format, as well as GPX)
* For best results, you should synchronise your camera to the GPS time before you start taking photos. Note: digital cameras clocks drift quickly - even over a short period of time (say, a week).

## Installation

To build, you will need:

* The Exiv2 library (C++ EXIF tag handling): http://www.exiv2.org/
* libxml2 (XML parsing): http://www.xmlsoft.org/
* GTK+ (if compiling the GUI): http://www.gtk.org

You can build the command line version and the GUI together simply with
"make" and install it with "sudo make install"

## Release History

* v1.6.1: 13 February 2010: Added a desktop icon submitted by Till Maas, and also a patch to fix build issues on Fedora. Thanks again Till!
* v1.6.0: 5 April 2009: Added another patch that I forgot to include in 1.5.9. Thanks again Eugeniy.
* v1.5.9: 4 April 2009: Incorporated patches from the new Debian maintainer: Fixes crash on empty tags, Fixes writing of negative altitudes, Fixes display of negative altitudes, Fixes invalid use of Exiv2 toRational(). Thanks Eugeniy for organising all these fixes; you did all the work - I just applied the patches you supplied.
* 1 November 2008: The 'Till Maas' release. Added gpscorrelate.desktop contributed by Till. Added patches for the Makefile by Till, to improve the installation. Added manpage, originally from Debian, but converted to XML by Till. Added patches for the Makefile by Till, to configure and install the manpages. Added patches by Till to remove compilation warnings. Thanks for your work!
* 21 September 2008: Fixed a reading of negative elevation bug (they were always written correctly), Added an install target to the makefile as supplied in a patch by Till Maas, updated the GUI to remember the last open photo and GPX directories. Also added patches to allow compilation for Win32 and makefiles to match, contributed by Julo Castillo.
* 21 November 2007: Re-release of 1.5.6, including patch from Marc Horowitz to fix negative timezone adjustments.
* 19 November 2007: Re-release of 1.5.6, updating the version number to be correct.
* 1 October 2007: Version 1.5.6: Incorporated patch from Marc Horowitz that allows gpscorrelate to correctly calculate negative timezone adjustments. Previously, the minutes were not subtracted from the timezone adjustment.
* 20 August 2007: Version 1.5.5: Made altitude data in GPX files optional. This should have been the case since the beginning, but it seems it was not.
* 22 June 2007: Version 1.5.4: Added Photo Offset time, as a fine adjustment between photo time and GPS time. Read the docs to understand it. GUI now has extra settings, and a "Strip GPS tags" button. GUI Now remembers settings on exit, into ~/.gpscorrelaterc. These are reloaded next time the GUI is started.
* 20 June 2007: Version 1.5.3: GPS coordinates, including altitude, are not written as Rational values instead of Signed Rational values, this now meets the EXIF specifications. Default format for writing coordinates is now DD MM SS.SS. The old behaviour can be forced with the --degmins parameter. If altitude is negative, the correct sea level reference value is now written.
* 6th June 2007: Version 1.5.2: Fixed bug where program would die with uncaught exception if input files were not JPEGs at all. Now the exception is caught. Fixed very silly bug where timestamps were incorrectly calculated: in struct tm, I didn't realise that tm_mon was 0-based, and didn't decrement it. This caused failures on dates spanning months with different numbers of days. Because the timestamps inside EXIF data and the timestamps from GPX data were converted the same way, the matching still worked. The date part is written as GPSDateStamp, which is wrong, and thus a --fix-datestamp option is provided. Turns out GPS Timestamp wasn't correct either. This time was out by the local timezone. This did not affect matches. --fix-timestamps will fix this as well. Added a --version option.
* 3rd April 2007: Version 1.5.1: Included patch from Marc Horowitz (an MIT one) to correctly remove all GPS tags when using the "remove GPS tags" feature. It seems my original code missed two. The patch instead iterates over the tags and removes anything starting with "Exif.GPSInfo". Thanks!
* 24 Feb 2007: Version 1.5: Fixed very silly bug where it would segfault on certain GPX files. Turns out those GPX files don't have time data on the trackpoints, and this is due to that track coming from certain parts of the GPS memory (where the timestamps get stripped to save space on the GPS device itself). This is something gpscorrelate should have handled.
* 28 May 2006: Version 1.4: Added option to preserve mtime on input photos. Patch submitted by Russell Steicke. (http://adelie.cx/). Also added patch to make GPX read correctly in non-C locales - would interpret "." as thousands seperator in some locales.
* 25 April 2006: Version 1.3: It would appear that the Exiv2 API changed somewhat. And gpscorrelate didn't work. Reported to me by a friendly chap. Now fixed to work correctly with the latest Exiv2 v0.9.1.
* Not Released: Version 1.2: Added --machine/-o option. This outputs the tags from the passed files in a machine-readable CSV output.
* 1 March 2005: Version 1.1: by default it now does not interpolate between GPX track segments (it ignored them before). You can still interpolate between track segments if you want. GPX track segments generally indicate where data was lost, or the unit was turned off - you don't really want matches when this is the case.
* 24 Feburary 2005: Version 1.0: Initial working release.
