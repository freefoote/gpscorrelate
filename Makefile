# Makefile for gpscorrelate
# Written by Daniel Foote.

PACKAGE_VERSION = 1.6.2git

CC = gcc
CXX = g++

COBJS    = main-command.o unixtime.o gpx-read.o correlate.o exif-gps.o
GOBJS    = main-gui.o gui.o unixtime.o gpx-read.o correlate.o exif-gps.o
CFLAGS   = -Wall -O2
override CFLAGS += $(shell pkg-config --cflags libxml-2.0 gtk+-2.0) -I/usr/include/exiv2
OFLAGS   = -Wall -O2
override OFLAGS += $(shell pkg-config --libs libxml-2.0 gtk+-2.0) -lm -lexiv2
prefix   = /usr/local
bindir   = $(prefix)/bin
datadir  = $(prefix)/share
mandir   = $(datadir)/man
docdir   = $(datadir)/doc/gpscorrelate
applicationsdir = $(datadir)/applications

DEFS = -DPACKAGE_VERSION=\"$(PACKAGE_VERSION)\"

TARGETS = gpscorrelate gpscorrelate-gui gpscorrelate.1

all:	$(TARGETS)

gpscorrelate: $(COBJS)
	$(CXX) $(OFLAGS) -o $@ $(COBJS)

gpscorrelate-gui: $(GOBJS)
	$(CXX) $(OFLAGS) -o $@ $(GOBJS)

.c.o:
	$(CC) $(CFLAGS) $(DEFS) -c -o $*.o $<

.cpp.o:
	$(CXX) $(CFLAGS) $(DEFS) -c -o $*.o $<

clean:
	rm -f *.o gpscorrelate{,.exe} gpscorrelate-gui{,.exe} doc/gpscorrelate-manpage.xml $(TARGETS)

install: all
	install -d $(DESTDIR)$(bindir)
	install gpscorrelate gpscorrelate-gui $(DESTDIR)$(bindir)
	install -d $(DESTDIR)$(mandir)/man1
	install -m 0644 gpscorrelate.1 $(DESTDIR)$(mandir)/man1
	install -d $(DESTDIR)$(docdir)
	install -m 0644 doc/*.html doc/*.png $(DESTDIR)$(docdir)

install-desktop-file:
	desktop-file-install --vendor="" --dir="$(DESTDIR)$(applicationsdir)" gpscorrelate.desktop
	install -p -m0644 -D gpscorrelate-gui.svg $(DESTDIR)$(datadir)/icons/hicolor/scalable/apps/gpscorrelate-gui.svg

doc/gpscorrelate-manpage.xml: doc/gpscorrelate-manpage.xml.in
	sed -e 's,@DOCDIR@,$(docdir),' -e 's,@PACKAGE_VERSION@,$(PACKAGE_VERSION),' $< > $@

gpscorrelate.1: doc/gpscorrelate-manpage.xml
	xsltproc http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl $<
