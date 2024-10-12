# pactl.sh - a pactl/wob wrapper
#
# Usage: pactl.sh [options] [action] [value]
#
#   options:
#     -h, --help    show this help message
#     -s, --socket  specify the wob socket
#
#   actions:
#     set           set the volume to a specific value
#     mute          toogle the volume
#     mic-mute      toogle the microphone

# default values
WOBSOCK=$XDG_RUNTIME_DIR/wob.sock

# parse options
while [ $# -gt 0 ]; do
    case $1 in
        -h|--help)
            sed -n '3,13p' $0 | sed 's/^#//'
            exit 0
            ;;
        -s|--socket)
            WOBSOCK=$2
            shift
            ;;
        -c|--colors)
            colors=$2
            shift
            ;;
        *)
            break
            ;;
    esac
    shift
done

# send the new volume to wob
pactl_send() {
    if [ "$(pactl get-sink-mute @DEFAULT_SINK@)" = "Mute: yes" ]; then
        echo 0 > $WOBSOCK
    else
        pactl get-sink-volume @DEFAULT_SINK@ | \
        awk 'NR==1{print substr($5,1,length($5)-1)}' > $WOBSOCK
    fi
}

# pactl actions
case $1 in
    set)
        pactl set-sink-volume @DEFAULT_SINK@ $2
        pactl_send
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        pactl_send
        ;;
    mic-mute)
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        ;;
esac
