{ pkgs ? import <nixpkgs> {} }:

let
  cmakeVersionRegex = ".*project\\(.*VERSION[[:space:]]+([[:digit:]\.]+).*";
  version = builtins.head (builtins.match cmakeVersionRegex (builtins.readFile ./CMakeLists.txt));

in pkgs.stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  pname = "docproc";
  inherit version;

  src = ./.;

  setupHook = pkgs.writeText "setupHook.sh" ''
    setDocprocDir() {
      if [[ -r "$1/share/cmake/${pname}/${pname}-config.cmake" ]]; then
        export docproc_DIR="$1"
      fi
    }

    addEnvHooks "$targetOffset" setDocprocDir
  '';

  nativeBuildInputs = with pkgs; [ cmake setupHook pandoc plantuml graphviz imagemagick7 ];

  meta = with pkgs.stdenv.lib; {
    description = "A cmake-package for document processing based on pandoc";
    homepage = https://github.com/igsha/docproc;
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = with maintainers; [ igsha ];
  };
}
