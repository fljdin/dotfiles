#!/usr/bin/env bash
set -e
POWER=/sys/class/power_supply/BAT*/uevent

cat $POWER | awk -F= --include ../utils.awk \
    -v WARNING=${1:-20} \
    -v CRITICAL=${2:-5} \
    -v COLOR_WARNING=${COLOR_WARNING:-#ffff00} \
    -v COLOR_CRITICAL=${COLOR_CRITICAL:-#ff0000} \
    -v label=${WIDGET_LABEL:-} \
'{
    if      ($1 == "POWER_SUPPLY_CAPACITY") { capacity = $2 }
    else if ($1 == "POWER_SUPPLY_STATUS")   { status = $2 }
} END {
    if      (status == "Charging") { indicator = "⇡" }
    else if (status == "Discharging") {
        if      (capacity <= CRITICAL) { color = COLOR_CRITICAL }
        else if (capacity <= WARNING)  { color = COLOR_WARNING }
        indicator = "⇣"
    }

    if      (capacity == 100) { logo = "" }
    else if (capacity >= 80)  { logo = "" }
    else if (capacity >= 50)  { logo = "" }
    else if (capacity >= 20)  { logo = "" }
    else if (capacity >= 1)   { logo = "" }

    text = sprintf ("%s%s %s%%", logo, indicator, capacity)

    jsonify(label, text, color)
}'
