#!/usr/bin/env bash
set -e
source $(dirname $0)/../env
POWER=/sys/class/power_supply/BAT*/uevent

cat $POWER | awk -F= \
    -v WARNING=${1:-20} \
    -v CRITICAL=${2:-5} \
    -v WARNING_COLOR=${WARNING_COLOR:-#ffff00} \
    -v CRITICAL_COLOR=${CRITICAL_COLOR:-#ff0000} \
'{
    if      ($1 == "POWER_SUPPLY_CAPACITY") { capacity = $2 }
    else if ($1 == "POWER_SUPPLY_STATUS")   { status = $2 }
} END {
    if      (status == "Charging") { indicator = " ⇡" }
    else if (status == "Discharging") {
        if      (capacity <= CRITICAL) { color = CRITICAL_COLOR }
        else if (capacity <= WARNING)  { color = WARNING_COLOR }
        indicator = " ⇣"
    }

    if      (capacity == 100) { logo = "" }
    else if (capacity >= 80)  { logo = "" }
    else if (capacity >= 50)  { logo = "" }
    else if (capacity >= 20)  { logo = "" }
    else if (capacity >= 1)   { logo = "" }

    printf "%s%%%s\n", capacity, indicator
    print logo
    print color
}'
