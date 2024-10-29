#!/usr/bin/env bash
# use nmcli to get network status
set -e
source $(dirname $0)/../env

nmcli --get-values name,type connection show --active | \
awk -F: \
    -v CRITICAL_COLOR=${CRITICAL_COLOR:-#ff0000} \
'{
    if ($2 == "vpn")              { vpn  = " " }
    if (!mode) {
        if      ($2 ~ /ethernet/) { mode = "⇅" }
        else if ($2 ~ /wireless/) { mode = "" }
    }
} END {
    if (!mode) {
        print " disconnected"
        print ""
        print CRITICAL_COLOR
    } else {
        print vpn mode
        print vpn mode
        print
    }
}'
