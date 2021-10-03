Installing Savonet/Liquidsoap
=============================

*Note* These instructions are from the documentation from liquidsoap `1.3.6`.
Make sure to consult the instructions from the version you wish to install,
most likely the latest stable release.

You can install liquidsoap with OPAM (recommended) or from source, or using a
package available for your distribution (not covered by this documentation).

* [Using OPAM](#opam)
* [Windows](#windows)
* [From source](#source)
* [Latest development version](#latest)

Install using OPAM
------------------
The recommended method to install liquidsoap is by using the [OCaml Package
Manager](http://opam.ocaml.org/). OPAM is available in all major distributions
and on windows. We actively support the liquidsoap packages there and its
dependencies.

- [you should have at least OPAM version 2.0](https://opam.ocaml.org/doc/Install.html),
- you should have OCaml version 4.07, which can be achieved by typing
  ```
  opam switch create 4.07.1
  ```

A typical installation with MP3 and Vorbis encoding/decoding and icecast support is done by executing:

```
opam depext taglib mad lame vorbis cry samplerate liquidsoap.1.3.6
opam install taglib mad lame vorbis cry samplerate liquidsoap.1.3.6
```

* `opam depext ...` takes care of installing the required external dependencies. In some cases external dependencies might be missing for your system. If that is the case, please report it to us!
* Finally `opam install ...` installs the packages themselves.

Most of liquidsoap's dependencies are only optionally installed by OPAM. For instance,
if you want to enable opus encoding and decoding after you've already installed liquidsoap, you should execute the following:

```
opam depext opus
opam install opus
```

`opam info liquidsoap` should give you the list of all optional dependencies that you may
enable in liquidsoap.

If you need to run liquidsoap as daemon, we provide a package named `liquidsoap-daemon`.
See [savonet/liquidsoap-daemon](https://github.com/savonet/liquidsoap-daemon) for more information.

You can also install liquidsoap or any of its dependencies from source using OPAM. For instance:

```
git clone --recursive https://github.com/savonet/liquidsoap.git
cd liquidsoap
opam pin add liquidsoap .
```

Most dependencies should be compatible with OPAM pinning. Let us know if you find one that isn't!

Windows build
-------------
You can download a liquidsoap for windows from our [release page](https://github.com/savonet/liquidsoap/releases), starting with version `1.3.4`.

The build process is described [here](windows.html).

Installing from source
----------------------
You can download source code published by Savonet from the [github releases
page](https://github.com/savonet/liquidsoap/releases).

The recommended way for newcomers is to use the liquidsoap-full-xxx.tar.gz
tarball. This tarball includes all required OCaml bindings and allows you to
compile and install liquidsoap in a single `configure`, `make` and ```
make
install```
 procedure. You will still need the corresponding C libraries and their
development files, though.

You will then have to [build the source](doc-dev/build.html).

Latest development version
--------------------------
If you want a cutting-edge version, you can use the git repository.
To get a copy of it, you have to run:

```

git clone https://github.com/savonet/liquidsoap-full.git liquidsoap
cd liquidsoap
make init
```

After, that you have to create a list of modules that you want to compile. A
good starting point is to do

```

cp PACKAGES.minimal PACKAGES
```

and edit the `PACKAGES` file to uncomment the libraries you are interested in.
You should then run the configuration scripts by

```

./bootstrap
./configure
```

and finally build Liquidsoap:

```

make
```

After that, you should synchronize the repository from time to time using

```

make update
```

Some more explanations can be found in the [build instructions](doc-dev/build.html).


