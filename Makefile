PRJ:=$(shell cat PACKAGES | grep -v '^\#')
PRJ:=$(shell for p in $(PRJ) ; do ls -d $$p* | head -1 ; done)
LIQ:=$(shell ls -d liquidsoap* | head -1)

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
	  v=`grep AC_INIT $$i/configure.ac | sed -e 's/AC_INIT([^,]\+,\s*\[\?\([0-9.a-z-]\+\).*/\1/'` ; \
	  echo $$i-$$v ; \
	  fi ; \
	done

PKGS:=$(shell grep '^\#\?\s*ocaml-[a-z]\+$$' PACKAGES.default | sed -e 's/\#//')
VERSION:=`grep AC_INIT liquidsoap/configure.ac | sed -e 's/AC_INIT([^,]\+,\s*\[\?\([0-9.a-z-]\+\).*/\1/'`
FULL:=liquidsoap-$(VERSION)-full

# HTTP=http://download.sourceforge.net/projects/savonet/files
# wget $(HTTP)/$$i/$$v/$$i-$$v.tar.gz

full: bootstrap
	rm -rf $(FULL) ; mkdir $(FULL)
	@cp bootstrap configure Makefile PACKAGES.default PACKAGES.minimal \
	  README LICENSE INSTALL $(FULL)
	@for p in $(PKGS) ; do make -C $$p dist ; done
	@make -C liquidsoap tarball
	@for i in $(PKGS) ; do \
	  v=`grep AC_INIT $$i/configure.ac | sed -e 's/AC_INIT([^,]\+,\s*\[\?\([0-9.a-z-]\+\).*/\1/'` ; \
	  if [ -f $$i-$$v.tar.gz ] ; then \
	    mv $$i-$$v.tar.gz $(FULL) ; else \
		mv $$i/$$i-$$v.tar.gz $(FULL) ; fi ; \
	done
	cd liquidsoap && make tarball
	cp liquidsoap/liquidsoap-$(VERSION)+svn.tar.bz2 $(FULL)
	cd $(FULL) ; for a in *tar.gz ; do tar zxf $$a && rm $$a ; done ; \
	  tar jxf liquidsoap*tar.bz2 && rm liquidsoap*tar.bz2
	ls -lR $(FULL)

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
