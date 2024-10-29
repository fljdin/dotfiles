#!/usr/bin/env bash
# print memory usage in percentage
set -e
source $(dirname $0)/../env

grep -E '^Mem' /proc/meminfo | awk \
    -v WARNING=${MEMORY_WARNING_THRESHOLD:-75} \
    -v CRITICAL=${MEMORY_CRITICAL_THRESHOLD:-95} \
    -v WARNING_COLOR=${WARNING_COLOR:-#ffff00} \
    -v CRITICAL_COLOR=${CRITICAL_COLOR:-#ff0000} \
'{
    if ($1 ~ /MemTotal:/)     { total = $2 }
    if ($1 ~ /MemAvailable:/) { available = $2 }
} END {
    mem = (total - available) / total * 100
    if      (mem >= CRITICAL) { color = CRITICAL_COLOR }
    else if (mem >= WARNING)  { color = WARNING_COLOR }
    printf "%.0f%%\n", mem
    printf "%.0f%%\n", mem
    print color
}'
