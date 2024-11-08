#!/usr/bin/env bash
set -e

# Number of docker containers running
count=$(docker ps -q | wc -l)
test $count -lt 1 && exit 0

docker stats --no-stream --format "{{.MemPerc}};{{.CPUPerc}}" | \
awk -F';' --include ../utils.awk \
    -v label=${WIDGET_LABEL:-} \
'{
    gsub("%", "", $1) ; mem += $1
    gsub("%", "", $2) ; cpu += $2
} END {
    text = sprintf("%d (Mem:%.1f%% CPU:%d%%)", NR, mem, cpu)

    jsonify(label, text, "")
}'
echo
exit 0
