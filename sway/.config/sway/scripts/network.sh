# use nmcli to get network status
nmcli --get-values name,type connection show --active | \
awk -F: \
    -v WARNING_COLOR=${normal_yellow:-orange} \
    -v CRITICAL_COLOR=${normal_red:-red} \
'{
    if ($2 == "vpn")              { vpn  = "" }
    if (!mode) {
        if      ($2 ~ /ethernet/) { mode = "⇅" }
        else if ($2 ~ /wireless/) { mode = "" }
    }
} END {
    if (!mode) {
        printf("<span foreground=\"%s\"> disconnected</span>", CRITICAL_COLOR)
    } else {
        print vpn mode
    }
}'
