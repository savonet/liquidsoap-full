⚠️ Deprecated ⚠️
===============

This repository was really needed before all the tooling around OCaml that exist nowadays, to make it easier to install
all the dependencies required for liquidsoap.

Since then, `opam` has filled most of these needs and is now our favorite ways of compiling liquidsoap from source. Checkout our [installation instructions](https://www.liquidsoap.info/doc-dev/install.html) on how to do so!

Now, for the history nerds:

Savonet - Audio Streaming Tools
===============================

Savonet is a set of open-source tools for multimedia streaming, particularly
adapted for netradios. It is mainly written in OCaml (but the Liquidsoap
language has nothing to do with OCaml).

This repository contains (as submodules) all the dependencies required by
Liquidsoap.

Using this repository
---------------------

If you are checking out this repository for the first time you should do

```
make init
make update
```

to initialize and update all submodules. The generate and run the configures:

```
./bootstrap
./configure
```

and finally build:

```
make
```
