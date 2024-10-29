#!/usr/bin/env bash
set -e
source $(dirname $0)/../env

cat /proc/loadavg | awk \
    -v WARNING=${LOAD_WARNING_THRESHOLD:-1} \
    -v CRITICAL=${LOAD_CRITICAL_THRESHOLD:-8} \
    -v WARNING_COLOR=${WARNING_COLOR:-#ffff00} \
    -v CRITICAL_COLOR=${CRITICAL_COLOR:-#ff0000} \
'{
    if      ($1 >= CRITICAL) { color = CRITICAL_COLOR }
    else if ($1 > WARNING)   { color = WARNING_COLOR }

    print $1
    print $1
    print color
}'
