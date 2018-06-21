with import <nixpkgs> { };
stdenv.mkDerivation rec {
  name = "docproc";
  buildInputs = [ cmake pandoc dpkg ];
  shellHook = ''
    echo Welcome to ${name} environment
  '';
}
