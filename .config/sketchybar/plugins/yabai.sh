#!/bin/sh
source "$HOME/.config/sketchybar/theme.sh"

windows_on_spaces () {
    CURRENT_SPACES="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"
    for space in $CURRENT_SPACES; do
        sketchybar --add space spaces.$space left \
            --set spaces.$space label=$space \
            associated_space=$space \
            label.drawing=on \
            script="$HOME/.config/sketchybar/plugins/space.sh"

        spaceapps=($(yabai -m query --windows --space $space | jq -r '.[] | .app, .id'))

        if [ "$spaceapps" != "" ]; then
            for ((i=0; i<${#spaceapps[@]}; i+=2)); do
                app=${spaceapps[$i]}
                id=${spaceapps[$i+1]}
                icon=$($HOME/.config/sketchybar/plugins/icon_map.sh $app)
                sketchybar --add item icon.$space.$app.$id left \
                    --set icon.$space.$app.$id label=$icon \
                    label.font="sketchybar-app-font:Regular:12" \
                    label.y_offset=0
            done
            sketchybar --add bracket apps.$space "/spaces\.$space/" "/icon\.$space.*/"
        else
            sketchybar --add bracket apps.$space "/spaces\.$space/"
        fi
    done
    sketchybar --add bracket spaces "/apps\..*/" \
        --set spaces background.color=$BAR_COLOR
}

windows_on_spaces

case "$SENDER" in
    "forced") exit 0
        ;;
    "front_app_switched") windows_on_spaces
        ;;
    "windows_on_spaces") windows_on_spaces
        ;;
esac
