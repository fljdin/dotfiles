#!/usr/bin/env bash
# use nmcli to get network status
set -e

nmcli --get-values name,type connection show --active | \
awk -F: --include ../utils.awk \
    -v COLOR_CRITICAL=${COLOR_CRITICAL:-#ff0000} \
    -v label=${WIDGET_LABEL:-} \
'{
    if ($2 == "vpn")              { vpn  = " " }
    if (!mode) {
        if      ($2 ~ /ethernet/) { mode = "⇅" }
        else if ($2 ~ /wireless/) { mode = "" }
    }
} END {
    if (!mode) {
        text = " disconnected"
        color = CRITICAL_COLOR
    } else {
        text = sprintf ("%s%s", vpn, mode)
    }

    jsonify(label, text, color)
}'
