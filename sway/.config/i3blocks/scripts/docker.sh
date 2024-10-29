#!/usr/bin/env bash
set -e
source $(dirname $0)/../env

# Number of docker containers running
count=$(docker ps -q | wc -l)
test $count -lt 1 && exit 0

docker stats --no-stream --format "{{.MemPerc}};{{.CPUPerc}}" | awk -F';' '{
    gsub("%", "", $1) ; mem += $1
    gsub("%", "", $2) ; cpu += $2
} END {
    printf "%d (Mem:%.1f%% CPU:%d%%)\n", NR, mem, cpu
    print NR
}'
echo $PRIMARY_COLOR
exit 0
