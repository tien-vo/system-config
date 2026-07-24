{ pkgs, ... }:
{
  config.home.packages = [
    pkgs.logseq
  ];
}
