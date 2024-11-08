#!/usr/bin/env bash
# print memory usage in percentage
set -e

grep -E '^Mem' /proc/meminfo | awk --include ../utils.awk \
    -v WARNING=${1:-75} \
    -v CRITICAL=${2:-95} \
    -v COLOR_WARNING=${COLOR_WARNING:-#ffff00} \
    -v COLOR_CRITICAL=${COLOR_CRITICAL:-#ff0000} \
    -v label=${WIDGET_LABEL:-} \
'{
    if ($1 ~ /MemTotal:/)     { total = $2 }
    if ($1 ~ /MemAvailable:/) { available = $2 }
} END {
    mem = (total - available) / total * 100
    if      (mem >= CRITICAL) { color = COLOR_CRITICAL }
    else if (mem >= WARNING)  { color = COLOR_WARNING }

    text = sprintf ("%.0f%%", mem)

    jsonify(label, text, color)
}'
