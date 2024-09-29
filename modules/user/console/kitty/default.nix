{ pkgs, settings, ... }:
let
  inherit (settings.theme) font;
in
{
  config.programs.kitty = {
    enable = true;
    font = {
      name = font.name;
      size = font.size;
    };
    shellIntegration = {
        mode = "no-cursor";
    };
    themeFile = "GruvBoxMaterialDarkMedium";
    settings = {
      cursor_shape = "block";
      cursor_shape_unfocused = "hollow";
      cursor_blink_interval = 0;
      
      background_opacity = 0.8;
      
      scrollback_lines = 10000;
    };
    extraConfig = ''
      #  scrollback_pager nvim +"source $HOME/.config/kitty/vi-mode.lua"  -c "map q :qa!<CR>"  -c "set clipboard+=unnamedplus"
      map ctrl+shift+space launch --stdin-source=@screen_scrollback --stdin-add-formatting --type=overlay bash -c 'nvim </dev/null -c "map q :qa!<CR>" -c "autocmd TermOpen * normal G" -c "terminal cat /proc/$$$$/fd/0 -" -c "set clipboard+=unnamedplus"'
    '';
  };
}
