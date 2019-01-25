About project
=============

``docproc`` is a cmake-package for document processing based on Pandoc.

Installation
============

Ubuntu way (replace ``<version>`` with the latest version)::

    ubuntu@ubuntu:~$ wget -q https://github.com/igsha/docproc/releases/download/v<verson>/docproc-<version>-all.deb -P /tmp/
    ubuntu@ubuntu:~$ sudo apt install /tmp/docproc-<version>-all.deb

There are two approach for NixOS way:

build it from release
    $ nix-build -f https://api.github.com/repos/igsha/docproc/tarball/master -A release

compile from source
    $ nix-build -f https://api.github.com/repos/igsha/docproc/tarball/master -A fromSource

Compiling from source
=====================

On NixOS (you can skip the first step if your OS is different):

#. load ``nix-shell`` from the root of the project::

    igor@nixos-pc docproc (master) $ nix-shell
    Welcome to docproc environment
    igor@nixos-pc docproc (master) [nix-shell] %

#. use standard bunch of commands for ``cmake`` projects::

    igor@nixos-pc docproc (master) [nix-shell] % mkdir build
    igor@nixos-pc docproc (master) [nix-shell] % cd build
    igor@nixos-pc build (master) [nix-shell] % cmake -DCPACK_GENERATOR=DEB ..
    -- Configuring done
    -- Generating done
    -- Build files have been written to: /home/igor/docproc/build
    igor@nixos-pc build (master) [nix-shell] % make
    igor@nixos-pc build (master) [nix-shell] %

#. there is only ``package`` meaningful target (except ``all``)::

    igor@nixos-pc build (master) [nix-shell] % make package
    Scanning dependencies of target mylib
    [ 14%] Building PANDOC object tests/CMakeFiles/mylib.dir/about.md.json
    ...
    [100%] Linking PANDOC executable myhtml.html
    [100%] Built target myhtml
    Run CPack packaging tool...
    CPack: Create package using DEB
    ...
    CPack: Create package
    CPack: - package: /home/igor/docproc/build/docproc-<version>-all.deb generated.
    CPack: Create package using TGZ
    ...
    CPack: Create package
    CPack: - package: /home/igor/docproc/build/docproc-<version>-all.tar.gz generated.
    igor@nixos-pc build (master) [nix-shell] %

``tar.gz`` release package is used by ``default.nix`` with attribute ``release``.
You can build it locally by invoking ``nix-build -A release`` directly.

How to use it
=============

In your ``CMakeLists.txt``::

    find_package(docproc REQUIRED)

    file(GLOB SRCS *.md)
    add_library(mylib ${SRCS})

    add_document(html myhtml ../README.rst)
    target_link_libraries(myhtml mylib "-V pagetitle=myhtml" "-F pandoc-crossref" "-F pantable")

``find_package(docproc)`` calls ``enable_language(PANDOC)`` implicitly.
After that ``add_document`` command is available.
The first argument is the format, the second - target name, the others - markup files.
You can "link" your document with built earlier "library" by ``add_library`` command.
Additional ``pandoc`` flags can be passed to ``target_*`` command.

An example is available in ``tests/`` folder.
