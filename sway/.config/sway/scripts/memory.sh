# print memory usage in percentage
grep -E '^Mem' /proc/meminfo | awk \
    -v WARNING=${1:-75} \
    -v CRITICAL=${2:-95} \
    -v WARNING_COLOR=${colour_orange:-orange} \
    -v CRITICAL_COLOR=${colour_red:-red} \
'{
    if ($1 ~ /MemTotal:/)     { total = $2 }
    if ($1 ~ /MemAvailable:/) { available = $2 }
} END {
    mem = (total - available) / total * 100
    if      (mem >= CRITICAL) { option = sprintf(" foreground=\"%s\"", CRITICAL_COLOR) }
    else if (mem >= WARNING)  { option = sprintf(" foreground=\"%s\"", WARNING_COLOR) }
    printf "<span%s>Mem %.0f%%</span>\n", option, mem
}'
