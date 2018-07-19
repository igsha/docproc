with import <nixpkgs> { };
mkShell rec {
  name = "docproc";
  buildInputs = [ cmake pandoc dpkg ];
  shellHook = ''
    echo Welcome to ${name} environment
  '';
}
