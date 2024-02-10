#!/bin/bash

passive_monitor=$(hyprctl monitors -j | jq '.[] | select(.focused == false).id')

hyprctl dispatch focusmonitor "$passive_monitor"
