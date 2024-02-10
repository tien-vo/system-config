{ pkgs, ... }:
let
  inherit (pkgs) writeShellScriptBin bash;
  script = writeShellScriptBin ("move-workspace-to-monitor") (
    ''
    active_monitor=$(hyprctl monitors -j | jq '.[] | select(.focused == true).id')
    passive_monitor=$(hyprctl monitors -j | jq '.[] | select(.focused == false).id')
    active_workspace=$(hyprctl monitors -j | jq '.[] | select(.focused == true).activeWorkspace.id')
    passive_workspace=$(hyprctl monitors -j | jq '.[] | select(.focused == false).activeWorkspace.id')
    
    hyprctl dispatch movecurrentworkspacetomonitor "$passive_monitor"
    hyprctl dispatch workspace "$active_workspace"
    hyprctl dispatch focusmonitor "$passive_monitor"
    ''
  );
in
{
  config.wayland.windowManager.hyprland.settings = {
    bind = [
      # Controls
      "SUPER, Q, exit"
      "SUPER, C, killactive"
      "SUPER, F, togglefloating"
      "SUPER_SHIFT, F, fullscreen"
      "SUPER, Print, exec, grim"
      "SUPER_SHIFT, Print, exec, grim -g '$(slurp)'"

      # Launchers
      "SUPER, RETURN, exec, alacritty"
      "SUPER, R, exec, fuzzel"

      # Movements
      "SUPER, H, movefocus, l"
      "SUPER, L, movefocus, r"
      "SUPER, J, movefocus, d"
      "SUPER, K, movefocus, u"
      "SUPER_SHIFT, H, movewindow, l"
      "SUPER_SHIFT, L, movewindow, r"
      "SUPER_SHIFT, J, movewindow, d"
      "SUPER_SHIFT, K, movewindow, u"

      # Workspaces
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"
      "SUPER_SHIFT, 1, movetoworkspace, 1"
      "SUPER_SHIFT, 2, movetoworkspace, 2"
      "SUPER_SHIFT, 3, movetoworkspace, 3"
      "SUPER_SHIFT, 4, movetoworkspace, 4"
      "SUPER_SHIFT, 5, movetoworkspace, 5"
      "SUPER_SHIFT, 6, movetoworkspace, 6"
      "SUPER_SHIFT, 7, movetoworkspace, 7"
      "SUPER_SHIFT, 8, movetoworkspace, 8"
      "SUPER_SHIFT, 9, movetoworkspace, 9"
      "SUPER_SHIFT, 0, movetoworkspace, 10"
      "SUPER, X, exec, ${bash}/bin/bash ${script}/bin/move-workspace-to-monitor"
    ];
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
    binde = [
      "ALT, H, resizeactive, -10 0"
      "ALT, L, resizeactive, 10 0"
      "ALT, J, resizeactive, 0 -10"
      "ALT, K, resizeactive, 0 10"

      # Multimedia
      ", XF86monbrightnessup, exec, brightnessctl set 5%+"
      ", XF86monbrightnessdown, exec, brightnessctl set 5%-"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ];
  };
}
