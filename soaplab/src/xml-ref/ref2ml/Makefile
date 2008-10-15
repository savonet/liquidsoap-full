SOURCES = ref_types.ml ref_parser.ml ref_lexer.ml \
          ref2ml.ml
RESULT = ref2ml
LIBS =

OCAMLBLDFLAGS = str.cma
OCAMLNLDFLAGS = str.cmxa

all: ref_lexer.ml ref_parser.ml nc

test: all
	./ref2ml test.ref

ref_lexer.ml: ref_lexer.mll
	ocamllex $<

ref_parser.ml: ref_parser.mly
	ocamlyacc $<

include OCamlMakefile
