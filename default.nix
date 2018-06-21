{ pkgs ? (import <nixpkgs> {}),
  stdenv ? pkgs.stdenv,
  cmake ? pkgs.cmake,
  pandoc ? pkgs.pandoc,
  writeText ? pkgs.writeText,
  fetchurl ? pkgs.fetchurl
}:

let
  cmakeVersionRegex = ".*project\\(.*VERSION[[:space:]]+([[:digit:]\.]+).*";
  version = builtins.head (builtins.match cmakeVersionRegex (builtins.readFile ./CMakeLists.txt));

  fromSourceDerivation = stdenv.mkDerivation rec {
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

    cmakeFlags = [ "-DCMAKE_EXPORT_NO_PACKAGE_REGISTRY=ON" "-DBUILD_TESTING=OFF" ];

    nativeBuildInputs = [ cmake setupHook pandoc ];

    meta = with stdenv.lib; {
      description = "A cmake-package for document processing based on pandoc";
      homepage = https://github.com/igsha/docproc;
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = with maintainers; [ igsha ];
    };
  };

in {
  release = fromSourceDerivation.overrideAttrs (oldAttrs: rec {
    src = fetchurl {
      url = "https://github.com/igsha/${oldAttrs.pname}/releases/download/v${oldAttrs.version}/${oldAttrs.name}-Linux-x86_64.tar.gz";
      sha256 = "0cp3pzg5js8b1dgkh3s2y6nml7v4xnn09jz432jm5b46iyyhg52v";
    };

    phases = [ "unpackPhase" "installPhase" "fixupPhase" ];

    installPhase = ''
      mkdir -p $out
      cp -a . $out/
    '';
  });

  fromSource = fromSourceDerivation;
}
