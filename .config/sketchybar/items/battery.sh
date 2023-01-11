#!/usr/bin/env sh

sketchybar -m --add item battery right \
    --set battery update_freq=3 \
    script="$PLUGIN_DIR/battery.sh" \
    background.color=$BACKGROUND_COLOR \
    icon.drawing=on \
    icon=
