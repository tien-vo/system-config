#!/bin/bash

swayidle -w timeout 300 'swaylock -f --indicator-idle-visible -c 000000' \
            timeout 600 'hyprctl dispatch dpms off' \
            timeout 900 'systemctl suspend' \
            resume 'hyprctl dispatch dpms on' \
            before-sleep 'swaylock -f --indicator-idle-visible -c 000000' & disown
