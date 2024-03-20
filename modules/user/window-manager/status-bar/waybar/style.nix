{ settings, ... }:
let
  inherit (builtins) ceil toString;
  inherit (settings.window) gap border;
  inherit (settings.theme.font) size;

  innerGap = toString (gap.inner);
  outerGap = toString (gap.outer);
  twoOuterGap = toString (2 * gap.outer);
  borderSize = toString (border.size);
  borderRadius = toString (border.radius);

  iconSize = toString (ceil (1.3 * size));
in
{
  config.programs.waybar.style = ''
    * {
        min-height: 0;
        border: none;
        margin: 0;
        padding: 0;
    }

    #waybar {
        background: @insensitive_base_color;
        border: ${borderSize}px solid #${border.active_color.top};
        border-radius: ${borderRadius}px;
    }

    #clock,
    #workspaces,
    #cpu,
    #memory,
    #temperature,
    #window,
    #wireplumber,
    #battery,
    #upower,
    #tray,
    #custom-powermenu {
        background-color: rgba(0, 0, 0, 0);
        padding: 0px ${outerGap}px;
    }

    #workspaces {
        font-size: ${iconSize}pt;
    }
    #workspaces button {
        color: @accent_bg_color;
        margin: ${innerGap}px 0px;
    }
    #workspaces button.active {
        color: @success_color;
    }
    #workspaces button.focused {
        color: @access_bg_color;
    }

    #clock {
        padding-left: ${outerGap}px;
    }
    #custom-powermenu {
        padding-right: ${twoOuterGap}px;
    }
  '';
}
