#!/usr/bin/env sh

sketchybar --add item     calendar right                    \
    --set calendar icon=cal                          \
    icon.padding_right=0              \
    label.width=50                    \
    label.align=right                 \
    background.padding_left=15        \
    update_freq=30                    \
    script="$PLUGIN_DIR/calendar.sh"
