SOURCES = liq.mli liq.ml mpc2liq.ml
RESULT = mpc2liq
LIBS = str unix

test: all
	./mpc2liq

ncmpc:
	ncmpc --port=6601

all: dc

include OCamlMakefile
