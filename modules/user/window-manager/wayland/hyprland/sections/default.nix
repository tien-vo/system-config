{ ... }:
{
  # https://wiki.hyprland.org/Configuring/Variables/#sections

  imports = [
    ./general.nix
    ./decoration.nix
    ./animations.nix
    ./input.nix
    ./misc.nix
    ./xwayland.nix
    ./cursor.nix
    ./debug.nix
  ];
}
