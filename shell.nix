with import <nixpkgs> { };
let
  docproc = callPackage ./. { };

in mkShell rec {
  name = "docproc";
  buildInputs = docproc.nativeBuildInputs;
  shellHook = ''
    echo Welcome to ${name} environment
  '';
}
