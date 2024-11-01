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

# Report Apt daily update on i3blocks

## Activate perdiodic apt update

```sh
# /etc/apt/apt.conf.d/10periodic
APT::Periodic::Enable "1";
APT::Periodic::Update-Package-Lists "1";
```

## Configure apt-daily.timer

```console
# sudo systemctl edit apt-daily.timer
[Timer]
OnBootSec=15min
OnUnitActiveSec=1d
AccuracySec=1h
RandomizedDelaySec=30min
```

## Send signal to i3blocks on apt update

```sh
# /etc/apt/apt.conf.d/80i3blocks
APT::Update::Post-Invoke { "pkill -RTMIN+9 i3blocks || true"; };
DPkg::Post-Invoke        { "pkill -RTMIN+9 i3blocks || true"; };
```

_Source:_ <https://github.com/vivien/i3blocks-contrib/tree/master/apt-upgrades>
