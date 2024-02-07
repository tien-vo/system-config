{ pkgs, settings, ... }:
let
  inherit (settings) src;
  gruvbox-icons = import ("${src}/packages/gruvbox-icons") (pkgs);
in
{
  config.home.file.".local/share/icons/GruvboxIcons".source = "${gruvbox-icons}";
}
