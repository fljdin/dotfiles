# index 1: French (alt., Latin-9 only)
# index 2: French (BEPO)

KEYBOARD="Intel HID 5 button array"
index=$(
  swaymsg -r -t get_inputs |
    jq -r ".[] | select(.name == \"$KEYBOARD\") | .xkb_active_layout_index"
)

case $index in
    0) echo "fr" ;;
    1) echo "fr-bépo" ;;
esac
