# Copyright 2003-2007 The Savonet team

PROGNAME = liqgest
DISTFILES = bootstrap CHANGES configure configure.ac COPYING Makefile README \
            src/OCamlMakefile src/Makefile.in \
            src/META.in src/*.ml src/*.mli src/*.c \
            examples/configure* examples/*Makefile* examples/*.ml \
            doc/html

.PHONY: all install uninstall update opt byte doc clean distclean dist

all:
	$(MAKE) -C src

opt byte update install uninstall:
	$(MAKE) -C src $@

doc:
	$(MAKE) -C src htdoc
	mkdir -p doc
	rm -rf doc/html
	mv src/doc/portaudio/html doc
	rm -rf src/doc

clean:
	-$(MAKE) -C src clean
	-$(MAKE) -C examples clean

distclean: clean
	rm -rf autom4te.cache config.log config.status src/META src/Makefile
	rm -rf doc
	-$(MAKE) -C examples distclean

dist: doc
	VERSION="$(shell grep 'AC_INIT' configure.ac)"; \
		VERSION=`echo "$$VERSION" | sed -e 's/AC_INIT([^,]*, \([^,]*\), .*)/\1/'`; \
		mkdir $(PROGNAME)-$$VERSION; \
		cp -r --parents $(DISTFILES) $(PROGNAME)-$$VERSION; \
		tar zcvf $(PROGNAME)-$$VERSION.tar.gz $(PROGNAME)-$$VERSION; \
		rm -rf $(PROGNAME)-$$VERSION
