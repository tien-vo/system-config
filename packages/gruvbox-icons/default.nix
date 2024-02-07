pkgs:
let
  inherit (pkgs) fetchurl;
  inherit (pkgs.stdenv) mkDerivation;
  url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v3.1/gruvbox-plus-icon-pack-3.1.zip";
  sha256 = "sha256-i/AzhYz/ACeXsG5j0kDVfvfA4TwxA3KZJTPwCO4BKmc=";
in
mkDerivation ({
  name = "gruvbox-icons";
  src = fetchurl ({ inherit url sha256; });
  dontUnpack = true;
  installPhase = "
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
  ";
})
