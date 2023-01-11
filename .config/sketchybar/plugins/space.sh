#!/usr/bin/env sh
if [ "$SELECTED" = "true" ]; then
    sketchybar --animate tanh 20 \
        --set apps.$SID \
        background.drawing=on \
        background.border_color=0xFFFFFFFF \
        label.color=0xFF000000
else
    sketchybar --animate tanh 20 \
        --set apps.$SID \
        background.drawing=off \
        background.border_color=0x0000FFFF \
        label.color=0xFFFFFFFF
fi
