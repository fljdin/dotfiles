#!/usr/bin/env bash
set -e

cat /proc/loadavg | awk --include ../utils.awk \
    -v WARNING=${1:-5} \
    -v CRITICAL=${2:-8} \
    -v COLOR_WARNING=${COLOR_WARNING:-#ffff00} \
    -v COLOR_CRITICAL=${COLOR_CRITICAL:-#ff0000} \
    -v label=${WIDGET_LABEL:-} \
'{
    if      ($1 >= CRITICAL) { color = COLOR_CRITICAL }
    else if ($1 > WARNING)   { color = COLOR_WARNING }

    jsonify(label, $1, color)
}'
