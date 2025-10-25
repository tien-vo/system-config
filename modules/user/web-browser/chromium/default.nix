{ config, pkgs, ... }:
{
    config.programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;
    };
}
