if status is-login
    # Commands to run in interactive sessions can go here
    if test (tty) = "/dev/tty1"
        set -x XDG_SESSION_TYPE wayland
        set -x XDG_CURRENT_DESKTOP sway

        systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
        exec dbus-run-session sway
    end
end
