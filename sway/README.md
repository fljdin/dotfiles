# Starting Sway with systemd, the right way

## Use agetty --autologin

```console
# systemctl edit getty@tty1
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --skip-login --nonewline --noissue --autologin --noclear username %I $TERM
Environment=XDG_SESSION_TYPE=wayland
```

Source: https://wiki.archlinux.org/title/Getty

## Deploy and enable sway services

```console
$ stow -t $HOME sway
$ systemctl --user enable kanshi.service
$ systemctl --user enable swayidle.service
$ systemctl --user enable xdg-desktop-portal.service
```
