#!/bin/sh

# Launch polybar
sh $HOME/.config/polybar/launch.sh & disown

# Network manager
nm-applet & disown

# Automount drives
[[ -z $(pgrep udiskie) ]] && udiskie --smart-tray & disown

# Caffeine
caffeine start & disown

# Set wallpaper
variety & disown
#feh --bg-scale --no-fehbg $HOME/.config/i3/resources/solar-system.jpg & disown

# Compositor
picom & disown

# Dunst
dunst -conf $HOME/.config/dunst/dunstrc & disown

# Megasync
[[ -z $(pgrep megasync) ]] && megasync & disown

# Automatically set timezone
timedatectl set-timezone "$(curl --fail https://ipapi.co/timezone)"

# Password manager
bitwarden-desktop & disown
