#!/usr/bin/env bash
POWER=/sys/class/power_supply/BAT*/uevent

cat $POWER | awk -F= \
    -v WARNING=${1:-20} \
    -v WARNING_COLOR=${2:-orange} \
    -v CRITICAL=${3:-5} \
    -v CRITICAL_COLOR=${4:-red} \
'{
    if      ($1 == "POWER_SUPPLY_CAPACITY") { capacity = $2 }
    else if ($1 == "POWER_SUPPLY_STATUS")   { status = $2 }
} END {
    if      (status == "Charging") { indicator = "⇡" }
    else if (status == "Discharging") {
        if      (capacity <= CRITICAL) { option = " foreground=\"red\"" }
        else if (capacity <= WARNING)  { option = " foreground=\"orange\"" }
        indicator = "⇣"
    }
    printf "<span%s>Power %s%% %s</span>\n", option, capacity, indicator
}'
