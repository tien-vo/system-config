#!/usr/bin/sh


export CONFIG=$HOME/.config/polybar/config.ini

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
#polybar main -c $CONFIG & disown
if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar main -c $CONFIG & disown
    done
else
    polybar main -c $CONFIG & disown
fi
