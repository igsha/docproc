with import <nixpkgs> { };
mkShell rec {
  name = "docproc";
  buildInputs = [ cmake pandoc dpkg plantuml graphviz imagemagick7 ];
  shellHook = ''
    echo Welcome to ${name} environment
  '';
}
