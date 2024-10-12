cat /proc/loadavg | awk \
    -v WARNING=${1:-5} \
    -v CRITICAL=${2:-8} \
    -v WARNING_COLOR=${normal_yellow:-orange} \
    -v CRITICAL_COLOR=${normal_red:-red} \
'{
    if      ($1 >= CRITICAL) { option = sprintf(" foreground=\"%s\"", CRITICAL_COLOR) }
    else if ($1 > WARNING)   { option = sprintf(" foreground=\"%s\"", WARNING_COLOR) }
    printf "<span%s>Load %s</span>\n", option, $1
}'
