inputs:
let
  src = ../.;
  arch = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${arch};
in
{
  inherit src arch pkgs;

  # Compatibility baseline. Do not update with nixpkgs.
  stateVersion = "25.11";
}
  // import ./desktop.nix {
  inherit inputs pkgs src;
}
