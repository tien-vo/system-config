{ settings, ... }:
let
in
{
  config.services.mako = {
    enable = true;
    height = 300;
    width = 400;
    margin = "20,20";
    defaultTimeout = 5000;
  };
}
