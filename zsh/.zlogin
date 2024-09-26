if [ "$(tty)" = "/dev/tty1" ]; then
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=sway

    systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
    exec dbus-run-session sway
fi
