# bar.sh - a custom i3blocks script
#
# blocks are shell scripts returning a new-lined output
# a non-zero return code will stop the execution of the entire script

interval=${1:-5} # seconds
path=$HOME/.config/sway/scripts
blocks="memory load battery time"

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

while status; do sleep $interval ; done
