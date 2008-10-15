SOURCES = dom_helper.ml xspf.ml soap.ml gdome-soap.ml
RESULT = gdome-soap
LIBS = mlogdome

INCDIRS = +gdome2
THREADS = yes

OCAMLBLDFLAGS = mlgdome.cma str.cma
OCAMLNLDFLAGS = mlgdome.cmxa str.cmxa

all: nc

test: all
	./gdome-soap test.xml

include OCamlMakefile
