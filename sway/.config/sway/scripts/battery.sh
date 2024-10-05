#!/usr/bin/env bash
POWER=/sys/class/power_supply/BAT*/uevent

cat $POWER | awk -F= \
    -v WARNING=${1:-20} \
    -v CRITICAL=${2:-5} \
    -v WARNING_COLOR=${normal_yellow:-orange} \
    -v CRITICAL_COLOR=${normal_red:-red} \
'{
    if      ($1 == "POWER_SUPPLY_CAPACITY") { capacity = $2 }
    else if ($1 == "POWER_SUPPLY_STATUS")   { status = $2 }
} END {
    if      (status == "Charging") { indicator = " ⇡" }
    else if (status == "Discharging") {
        if      (capacity <= CRITICAL) { option = sprintf(" foreground=\"%s\"", CRITICAL_COLOR) }
        else if (capacity <= WARNING)  { option = sprintf(" foreground=\"%s\"", WARNING_COLOR) }
        indicator = " ⇣"
    }
    printf "<span%s>Power %s%%%s</span>\n", option, capacity, indicator
}'
