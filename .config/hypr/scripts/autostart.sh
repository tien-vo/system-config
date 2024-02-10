#!/bin/bash

function run() {
    [[ -z $(pgrep -f $1) ]] && \
        eval $* & disown || true
}

run "/usr/lib/xdg-desktop-portal-hyprland"
run "/usr/lib/xdg-desktop-portal"
run "/usr/lib/polkit-kde-authentication-agent-1"
run $(which pypr)
run $(which mako)
run $(which waybar)
run $(which nm-applet)
run $(which blueman-applet)
run $(which megasync)
run $(which filen-desktop)
run $(which udiskie) --smart-tray
run $(which tvo-wallpaper)
 
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
dbus-update-activation-environment --all
systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
