# #!/usr/bin/env sh
#
# SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")
#
# # Destroy space on right click, focus space on left click.
# # New space by left clicking separator (>)
# SPACE_CLICK_SCRIPT='[ "$BUTTON" = "right" ] && (yabai -m space --destroy $SID; sketchybar --trigger space_change) || yabai -m space --focus $SID 2>/dev/null'
#
# sid=0
# for i in "${!SPACE_ICONS[@]}"
# do
#     sid=$(($i+1))
#     sketchybar --add space space.$sid center \
    #         --set space.$sid associated_space=$sid                         \
    #         icon=${SPACE_ICONS[i]}                        \
    #         icon.padding_left=15                          \
    #         icon.padding_right=15                         \
    #         icon.highlight_color=$BLACK \
    #         icon.font="$LABEL_FONT"            \
    #         label.font="$FONT:Bold:12.0" \
    #         script="$PLUGIN_DIR/space.sh"                 \
    #         click_script="$SPACE_CLICK_SCRIPT" \
    #         icon.background.height=24 \
    #         icon.background.corner_radius=20
# done
#
# sketchybar --set spaces background.color=$BACKGROUND_COLOR \
    #     background.height=24 \
    #     background.border_color=0xFFFFFFFF \
    #     background.border_width=2 \
