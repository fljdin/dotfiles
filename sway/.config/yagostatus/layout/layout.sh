#!/usr/bin/env bash
set -e

KEYBOARD="Intel HID 5 button array"
layout=$(
  swaymsg -r -t get_inputs |
    jq -r ".[] | select(.name == \"$KEYBOARD\") | .xkb_active_layout_name"
)

case $layout in
    "French (alt., Latin-9 only)")
        echo "fr" ;;
    "French (BEPO)")
        echo "fr-bépo" ;;
    "French (Ergo-L)") 
        echo "fr-ergol" ;;
esac
