{ stdenv, lib, writeText, cmake, pandoc, plantuml, graphviz, imagemagick7, makeWrapper, bash }:

let
  cmakeVersionRegex = ".*project\\(.*VERSION[[:space:]]+([[:digit:]\\.]+).*";
  version = builtins.head (builtins.match cmakeVersionRegex (builtins.readFile ./CMakeLists.txt));

in stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "docproc";
  inherit version;

  src = ./.;

  setupHook = writeText "setupHook.sh" ''
    setDocprocDir() {
      if [[ -r "$1/share/cmake/${pname}/${pname}-config.cmake" ]]; then
        export docproc_DIR="$1"
      fi
    }

    addEnvHooks "$targetOffset" setDocprocDir
  '';

  nativeBuildInputs = [ cmake setupHook pandoc plantuml graphviz imagemagick7 ];
  buildInputs = [ makeWrapper bash ];
  doCheck = true;
  postPatch = ''
    substituteInPlace tests/pandoc-version --replace "/usr/bin/env bash" ${bash}/bin/bash
  '';

  meta = with lib; {
    description = "A cmake-package for document processing based on pandoc";
    homepage = https://github.com/igsha/docproc;
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ igsha ];
  };
}
