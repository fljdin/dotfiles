#! /usr/bin/env bash
#
# Apply colors theme from Gogh theme collection
# See https://gogh-co.github.io/Gogh/
#
# Usage:
#   theme.sh <theme-name>
set -euo pipefail
URL="https://raw.githubusercontent.com/Gogh-Co/Gogh/refs/heads/master/themes"

# use a default theme if none has already been set
theme="Catppuccin Macchiato"
test -f theme && theme=$(cat theme)

# exit on non 200 status code
url="$URL/$(echo ${1:-$theme} | sed 's/ /%20/g').yml"
code=$(curl -s -o /dev/null -I -w "%{http_code}" $url)
if [ $code -ne 200 ]; then
    echo "Theme not found: $1"
    exit 1
fi

# save the theme name for later use
echo ${1:-$theme} > theme

# load the colors from the theme file and export them as environment variables
eval $(curl -s $url | awk \
'{
    if ($1 ~ /color_[0-9]+|background|foreground|cursor/) {
        gsub(/:/, "", $1)
        gsub(/#/, "", $2)
        gsub(/\047/, "", $2)
        print "export " toupper($1) "=" $2
    }
}')

#          black  red    green  yellow blue   magenta cyan   white
# normal   01     02     03     04     05     06     07     08
# bright   09     10     11     12     13     14     15     16
export ALPHA=80
export PRIMARY=${COLOR_03}
export SECONDARY=${COLOR_08}
export TERTIARY=${COLOR_01}
export ACCENT=${COLOR_02}${ALPHA}

cat <<EOF > sway/.config/sway/vars.d/colors.conf
set \$primary              #${PRIMARY}
set \$secondary            #${SECONDARY}
set \$tertiary             #${TERTIARY}
set \$accent               #${ACCENT}
set \$background           #${BACKGROUND}
set \$background_alpha     #${BACKGROUND}${ALPHA}
set \$foreground           #${FOREGROUND}
set \$foreground_alpha     #${FOREGROUND}${ALPHA}

set \$cursor               #${CURSOR}
set \$cursor_alpha         #${CURSOR}${ALPHA}
set \$normal_black         #${COLOR_01}
set \$normal_black_alpha   #${COLOR_01}${ALPHA}
set \$normal_red           #${COLOR_02}
set \$normal_red_alpha     #${COLOR_02}${ALPHA}
set \$normal_green         #${COLOR_03}
set \$normal_green_alpha   #${COLOR_03}${ALPHA}
set \$normal_yellow        #${COLOR_04}
set \$normal_yellow_alpha  #${COLOR_04}${ALPHA}
set \$normal_blue          #${COLOR_05}
set \$normal_blue_alpha    #${COLOR_05}${ALPHA}
set \$normal_magenta       #${COLOR_06}
set \$normal_magenta_alpha #${COLOR_06}${ALPHA}
set \$normal_cyan          #${COLOR_07}
set \$normal_cyan_alpha    #${COLOR_07}${ALPHA}
set \$normal_white         #${COLOR_08}
set \$normal_white_alpha   #${COLOR_08}${ALPHA}
set \$bright_black         #${COLOR_09}
set \$bright_black_alpha   #${COLOR_09}${ALPHA}
set \$bright_red           #${COLOR_10}
set \$bright_red_alpha     #${COLOR_10}${ALPHA}
set \$bright_green         #${COLOR_11}
set \$bright_green_alpha   #${COLOR_11}${ALPHA}
set \$bright_yellow        #${COLOR_12}
set \$bright_yellow_alpha  #${COLOR_12}${ALPHA}
set \$bright_blue          #${COLOR_13}
set \$bright_blue_alpha    #${COLOR_13}${ALPHA}
set \$bright_magenta       #${COLOR_14}
set \$bright_magenta_alpha #${COLOR_14}${ALPHA}
set \$bright_cyan          #${COLOR_15}
set \$bright_cyan_alpha    #${COLOR_15}${ALPHA}
set \$bright_white         #${COLOR_16}
set \$bright_white_alpha   #${COLOR_16}${ALPHA}
EOF

sed -e "s/background=\w\+/background=${BACKGROUND}/" \
    -e "s/foreground=\w\+/foreground=${FOREGROUND}/" \
    -e "s/regular0=\w\+/regular0=${COLOR_01}/" \
    -e "s/regular1=\w\+/regular1=${COLOR_02}/" \
    -e "s/regular2=\w\+/regular2=${COLOR_03}/" \
    -e "s/regular3=\w\+/regular3=${COLOR_04}/" \
    -e "s/regular4=\w\+/regular4=${COLOR_05}/" \
    -e "s/regular5=\w\+/regular5=${COLOR_06}/" \
    -e "s/regular6=\w\+/regular6=${COLOR_07}/" \
    -e "s/regular7=\w\+/regular7=${COLOR_08}/" \
    -e "s/bright0=\w\+/bright0=${COLOR_09}/" \
    -e "s/bright1=\w\+/bright1=${COLOR_10}/" \
    -e "s/bright2=\w\+/bright2=${COLOR_11}/" \
    -e "s/bright3=\w\+/bright3=${COLOR_12}/" \
    -e "s/bright4=\w\+/bright4=${COLOR_13}/" \
    -e "s/bright5=\w\+/bright5=${COLOR_14}/" \
    -e "s/bright6=\w\+/bright6=${COLOR_15}/" \
    -e "s/bright7=\w\+/bright7=${COLOR_16}/" \
    -i foot/.config/foot/foot.ini

# mako
sed -e "s/background-color=#\w\+/background-color=#${BACKGROUND}/" \
    -e "s/text-color=#\w\+/text-color=#${FOREGROUND}/" \
    -e "s/border-color=#\w\+/border-color=#${PRIMARY}/" \
    -i sway/.config/mako/config
makoctl reload

# swaylock
sed -e "s/\(color\)=.*/\1=${BACKGROUND}/" \
    -e "s/\(bs-hl-color\)=.*/\1=${TERTIARY}/" \
    -e "s/\(caps-lock-bs-hl-color\)=.*/\1=${TERTIARY}/" \
    -e "s/\(caps-lock-key-hl-color\)=.*/\1=${SECONDARY}/" \
    -e "s/\(inside-caps-lock-color\)=.*/\1=${BACKGROUND}/" \
    -e "s/\(inside-clear-color\)=.*/\1=${BACKGROUND}/" \
    -e "s/\(inside-color\)=.*/\1=${BACKGROUND}/" \
    -e "s/\(inside-ver-color\)=.*/\1=${BACKGROUND}/" \
    -e "s/\(inside-wrong-color\)=.*/\1=${ACCENT}/" \
    -e "s/\(key-hl-color\)=.*/\1=${PRIMARY}/" \
    -e "s/\(layout-bg-color\)=.*/\1=${COLOR_09}/" \
    -e "s/\(layout-border-color\)=.*/\1=${COLOR_01}/" \
    -e "s/\(layout-text-color\)=.*/\1=${FOREGROUND}/" \
    -e "s/\(line-caps-lock-color\)=.*/\1=${COLOR_01}/" \
    -e "s/\(line-clear-color\)=.*/\1=${COLOR_01}/" \
    -e "s/\(line-color\)=.*/\1=${COLOR_01}/" \
    -e "s/\(line-ver-color\)=.*/\1=${COLOR_01}/" \
    -e "s/\(line-wrong-color\)=.*/\1=${COLOR_01}/" \
    -e "s/\(ring-caps-lock-color\)=.*/\1=${SECONDARY}/" \
    -e "s/\(ring-clear-color\)=.*/\1=${SECONDARY}/" \
    -e "s/\(ring-color\)=.*/\1=${SECONDARY}/" \
    -e "s/\(ring-ver-color\)=.*/\1=${SECONDARY}/" \
    -e "s/\(ring-wrong-color\)=.*/\1=${ACCENT}/" \
    -e "s/\(separator-color\)=.*/\1=${COLOR_01}/" \
    -e "s/\(text-caps-lock-color\)=.*/\1=${FOREGROUND}/" \
    -e "s/\(text-clear-color\)=.*/\1=${FOREGROUND}/" \
    -e "s/\(text-color\)=.*/\1=${FOREGROUND}/" \
    -e "s/\(text-ver-color\)=.*/\1=${FOREGROUND}/" \
    -e "s/\(text-wrong-color\)=.*/\1=${FOREGROUND}/" \
    -i sway/.config/swaylock/config

# wob (wayland overlay bar)
sed -e "s/\(background_color\)=.*/\1=${BACKGROUND}/" \
    -e "s/\(bar_color\)=.*/\1=${PRIMARY}/" \
    -e "s/\(border_color\)=.*/\1=${PRIMARY}/" \
    -e "s/\(overflow_background_color\)=.*/\1=${BACKGROUND}/" \
    -e "s/\(overflow_bar_color\)=.*/\1=${ACCENT}/" \
    -e "s/\(overflow_border_color\)=.*/\1=${FOREGROUND}/" \
    -i sway/.config/wob/wob.ini

# i3blocks
sed -e "s/\(WARNING_COLOR\).*/\1=#${COLOR_04}/" \
    -e "s/\(CRITICAL_COLOR\).*/\1=#${COLOR_02}/" \
    -e "s/\(PRIMARY_COLOR\).*/\1=#${PRIMARY}/" \
    -i sway/.config/i3blocks/env
