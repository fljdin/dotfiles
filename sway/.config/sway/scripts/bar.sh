# bar.sh - a custom i3blocks script
#
# blocks are shell scripts returning a new-lined output
# a non-zero return code will stop the execution of the entire script

interval=${1:-5} # seconds
SWAY=$HOME/.config/sway
path=$SWAY/scripts/bar
colors=$SWAY/vars.d/colors.conf
blocks="memory load layout network battery time"

status() {
    output=""
    for block in $blocks; do
        o=$(sh -c $path/$block.sh)
        if [ $? -ne 0 ]; then
            return 1
        fi

        if [ -n "$output" ]; then
            output="$output | $o"
        else
            output="$o"
        fi
    done
    echo "$output"
}

# load colors for any scripts that need them
eval $(awk \
    'NF>0 {printf "export %s=\"%s\"\n", substr($2, 2), $3}' \
    $colors
)

while status; do sleep $interval ; done
