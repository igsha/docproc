About project
=============

``docproc`` is a cmake-package for document processing based on Pandoc.

Installation
============

Ubuntu way::

    ubuntu@ubuntu:~$ wget -q https://github.com/igsha/docproc/releases/download/v0.2.1/docproc-0.2.1-all.deb -P /tmp/
    ubuntu@ubuntu:~$ sudo apt install /tmp/docproc-0.2.1-all.deb
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    Note, selecting 'docproc' instead of '/tmp/docproc-0.2.1-all.deb'
    The following NEW packages will be installed:
      docproc
    0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
    Need to get 0 B/1,554 B of archives.
    After this operation, 18.4 kB of additional disk space will be used.
    Get:1 /tmp/docproc-0.1.1-all.deb docproc amd64 0.2.1 [1,540 B]
    Selecting previously unselected package docproc.
    (Reading database ... 108862 files and directories currently installed.)
    Preparing to unpack .../docproc-0.1.1-all.deb ...
    Unpacking docproc (0.2.1) ...
    Setting up docproc (0.2.1) ...
    ubuntu@ubuntu:~$

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
    [ 28%] Building PANDOC object tests/CMakeFiles/mylib.dir/commands.md.json
    [ 42%] Linking PANDOC static library libmylib.json
    [ 42%] Built target mylib
    Scanning dependencies of target mydocx
    [ 57%] Building PANDOC object tests/CMakeFiles/mydocx.dir/__/README.rst.json
    [ 71%] Linking PANDOC executable mydocx.docx
    [ 71%] Built target mydocx
    Scanning dependencies of target myhtml
    [ 85%] Building PANDOC object tests/CMakeFiles/myhtml.dir/__/README.rst.json
    [100%] Linking PANDOC executable myhtml.html
    [100%] Built target myhtml
    Run CPack packaging tool...
    CPack: Create package using DEB
    CPack: Install projects
    CPack: - Run preinstall target for: docproc
    CPack: - Install project: docproc
    CPack: Create package
    CPack: - package: /home/igor/docproc/build/docproc-0.2.1-all.deb generated.
    CPack: Create package using TGZ
    CPack: Install projects
    CPack: - Run preinstall target for: docproc
    CPack: - Install project: docproc
    CPack: Create package
    CPack: - package: /home/igor/docproc/build/docproc-0.2.1-all.tar.gz generated.
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
