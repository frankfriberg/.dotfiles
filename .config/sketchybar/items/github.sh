#!/usr/bin/env sh

POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add       item            github.bell right                  \
    --set       github.bell     update_freq=180                    \
    icon=$BELL                         \
    icon.padding_left=10 \
    background.color=$BLUE\
    label.padding_right=10 \
    label=$LOADING                     \
    popup.align=right                  \
    script="$PLUGIN_DIR/github.sh"     \
    click_script="$POPUP_CLICK_SCRIPT" \
    --subscribe github.bell     mouse.entered                      \
    mouse.exited                       \
    mouse.exited.global

sketchybar --add       item            github.template popup.github.bell  \
    --set       github.template drawing=off                        \
    background.corner_radius=12        \
    background.padding_left=7          \
    background.padding_right=7         \
    background.color=$BACKGROUND_COLOR \
    background.drawing=off             \
    icon.background.height=2           \
    icon.background.y_offset=-12
