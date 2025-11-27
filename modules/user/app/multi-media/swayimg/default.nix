{ config, ... }:
{
    config.programs.swayimg = {
        enable = true;
        settings = {
            info = {
                show = "no";
            };
        };
    };
}
