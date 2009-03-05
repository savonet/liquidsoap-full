SOURCES = domHelper.ml xspf.ml rcs.ml soap.ml \
          tools.ml \
          gtkHelper.ml \
          gtkWaveDisplay.mli gtkWaveDisplay.ml ias.ml \
          soundEditor.ml metadataEditor.ml databasePalette.ml \
          soaplab.ml
RESULT = soaplab
LIBS = mlogdome

OCAMLFIND=OCAMLPATH=../../lib ocamlfind
PACKS = lablgtk2.init lablgtk2.glade portaudio xmlplaylist sdl.sdlttf liquidsoap
INCDIRS = ../../lib/liquidsoap/lang ../../lib/liquidsoap/stream \
	  +gdome2
THREADS = yes

OCAMLBLDFLAGS = mlgdome.cma
OCAMLNLDFLAGS = mlgdome.cmxa

all: ias.ml nc

test-editor: all
	./soaplab --editor lin.ogg

test: all
	./soaplab

ias.ml: IAS/ias.glade
	lablgladecc2 $< > $@

include OCamlMakefile
