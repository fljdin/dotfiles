#! /usr/bin/env bash
#
# Apply colors theme from Gogh theme collection
# See https://gogh-co.github.io/Gogh/
#
# Usage:
#   theme.sh <theme-name>

theme=$(echo ${1:-"One Dark"} | sed 's/ /%20/g')
url="https://raw.githubusercontent.com/Gogh-Co/Gogh/refs/heads/master/themes/$theme.yml"

# export color as environment variables
export ALPHA=80
eval $(curl -s $url | awk \
'{
    if ($1 ~ /color_[0-9]+|background|foreground|cursor/) {
        gsub(/:/, "", $1)
        gsub(/#/, "", $2)
        gsub(/\047/, "", $2)
        print "export " toupper($1) "=" $2
    }
}')

cat <<EOF > sway/.config/sway/vars.d/colors.conf
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
