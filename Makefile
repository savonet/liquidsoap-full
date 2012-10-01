PRJ:=$(shell (cat PACKAGES 2>/dev/null || echo "") | grep -v '^\#')
PRJ:=$(shell for p in $(PRJ) ; do ls -d $$p* | head -1 ; done)
LIQ:=$(shell ls -d liquidsoap* | head -1)

SED:=$(shell which gsed || which sed)

default: all

all:
	for i in $(PRJ); do $(MAKE) -C $$i || exit 1; done

clean:
	for i in $(PRJ); do $(MAKE) -C $$i $@; done

doc:
	$(MAKE) -C $(LIQ) doc

install:
	$(MAKE) -C $(LIQ) install

# Display current version numbers of all components
versions:
	@for i in ocaml-* liquidsoap ; do \
	  if [ -f $$i/configure.ac ] ; then \
	  v=`grep AC_INIT $$i/configure.ac | $(SED) -e 's/AC_INIT([^,]\+,\s*\[\?\([0-9.a-z-]\+\).*/\1/'` ; \
	  echo $$i-$$v ; \
	  fi ; \
	done

PKGS:=$(shell grep '^\#\?\s*ocaml-[a-z]\+$$' PACKAGES.default | $(SED) -e 's/\#//')
VERSION:=`grep AC_INIT liquidsoap/configure.ac | $(SED) -e 's/AC_INIT([^,]\+,\s*\[\?\([0-9.a-z-]\+\).*/\1/'`
FULL:=liquidsoap-$(VERSION)-full

# $i = package name
# $v = version
# wget $(HTTP)/$$i/$$v/$$i-$$v.tar.gz
HTTP=http://downloads.sourceforge.net/project/savonet

download_latest:
	mkdir -p latest
	@cd latest ; \
	for i in $(PKGS) ; do \
	  v=`grep AC_INIT ../$$i/configure.ac | $(SED) -e 's/AC_INIT([^,]\+,\s*\[\?\([0-9.a-z-]\+\).*/\1/'` ; \
	  if test ! -s $$i-$$v.tar.gz; then \
	    echo wget $(HTTP)/$$i/$$v/$$i-$$v.tar.gz/download -O $$i-$$v.tar.gz --tries=2; \
	    wget $(HTTP)/$$i/$$v/$$i-$$v.tar.gz -O $$i-$$v.tar.gz --tries=2 || rm -f $$i-$$v.tar.gz; \
	  fi \
	done

full: bootstrap makefiles
	@rm -rf $(FULL) ; mkdir $(FULL)
	@cp bootstrap configure Makefile PACKAGES.default PACKAGES.minimal \
	  README LICENSE INSTALL $(FULL)
	@echo Did you run \"make download_latest\" to get official tarballs?
	@for i in $(PKGS) ; do \
	  v=`grep AC_INIT $$i/configure.ac | $(SED) -e 's/AC_INIT([^,]\+,\s*\[\?\([0-9.a-z-]\+\).*/\1/'` ; \
	  if [ -f latest/$$i-$$v.tar.gz ] ; then \
	  	cp latest/$$i-$$v.tar.gz $(FULL) ; else \
	  echo " *** Latest tarball not found for $$i-$$v: building it..." ; \
	  make -C $$i dist > /dev/null ; \
	  if [ -f $$i-$$v.tar.gz ] ; then \
	    mv $$i-$$v.tar.gz $(FULL) ; else \
		mv $$i/$$i-$$v.tar.gz $(FULL) ; \
      fi ; \
      fi ; \
	done
	@if [ -f latest/liquidsoap-$(VERSION).tar.bz2 ] ; then \
	  cp latest/liquidsoap-$(VERSION).tar.bz2 $(FULL) ; else \
	  echo " *** Latest tarball not found for liquidsoap-$(VERSION): building..." ; \
	  make -C liquidsoap tarball > /dev/null && \
	    mv liquidsoap/liquidsoap-$(VERSION).tar.bz2 $(FULL) ; \
	fi
	@cd $(FULL) ; for a in *tar.gz ; do tar zxf $$a && rm $$a ; done ; \
	  tar jxf liquidsoap*tar.bz2 && rm liquidsoap*tar.bz2
	@tar cjf $(FULL).tar.bz2 $(FULL)
	@echo Full release ready in subdirectory $(FULL)

# The bootstrap target creates/updates */configure as needed
# It is more efficient than ./bootstrap, avoiding to regenerate
# everything when only one configure.ac was changed. However,
# it also bootstraps libraries which are commented out in PACKAGES.
# We use PKGDIRS and LIQDIRS which have -$(version) prefixes,
# so that the target will work in -full archives.
.PHONY: bootstrap
PKGDIRS:=$(shell for p in $(PKGS) ; do ls -d $$p* | head -1 ; done)
LIQDIR:=$(shell ls -d liquidsoap* | head -1)
bootstrap: $(PKGDIRS:=/configure) $(LIQDIR)/configure
%/configure: %/configure.ac
	@echo "*** bootstrapping `dirname $@`"
	@cd `dirname $@` ; ./bootstrap
# Generate each PKG/Makefile by running configure script
# This may fail for some packages because specific configure options are
# needed, in which case they should simply be ran manually
makefiles: $(PKGDIRS:=/Makefile) $(LIQDIR)/Makefile.defs
%/Makefile:
	@echo "*** configuring `dirname $@`"
	@cd `dirname $@` ; ./configure --with-ogg-dir=../ocaml-ogg/src --with-ladspa-dir=../ocaml-ladspa/src > /dev/null || \
	  echo "Skipping failed configure..."
liquidsoap/Makefile.defs: liquidsoap/configure
	@echo "*** configuring `dirname $@`"
	@cd `dirname $@` ; `cat configure-with-options` > /dev/null || \
	  echo "Skipping failed configure..."

.PHONY: install

include Makefile.git
