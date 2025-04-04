#!/usr/bin/env bash
set -e

KEYBOARD="1:1:AT_Translated_Set_2_keyboard"
layout=$(
  swaymsg -r -t get_inputs |
    jq -r ".[] | select(.identifier == \"$KEYBOARD\") | .xkb_active_layout_name"
)

case $layout in
    "French (alt., Latin-9 only)")
        echo "fr" ;;
    "French (BEPO)")
        echo "fr-bépo" ;;
    "French (Ergo-L)" | "French (Ergo‑L, ISO variant)")
        echo "fr-ergol" ;;
esac
