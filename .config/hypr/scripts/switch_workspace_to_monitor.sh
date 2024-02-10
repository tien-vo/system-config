#!/bin/bash

active_monitor=$(hyprctl monitors -j | jq '.[] | select(.focused == true).id')
passive_monitor=$(hyprctl monitors -j | jq '.[] | select(.focused == false).id')
active_workspace=$(hyprctl monitors -j | jq '.[] | select(.focused == true).activeWorkspace.id')
passive_workspace=$(hyprctl monitors -j | jq '.[] | select(.focused == false).activeWorkspace.id')

hyprctl dispatch movecurrentworkspacetomonitor "$passive_monitor"
hyprctl dispatch workspace "$active_workspace"
hyprctl dispatch focusmonitor "$passive_monitor"
