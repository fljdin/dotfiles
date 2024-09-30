# Personal dotfiles

This repository contains my personal dotfiles. It is managed using
[GNU Stow](https://www.gnu.org/software/stow/).

## Requirements

Works on Debian-based systems:

```console
$ sudo apt install $(cat requirements.txt)
```

## Installation

Clone the repository and install the dotfiles using GNU Stow:

```bash
cd dotfiles

stow -t $HOME zsh
stow -t $HOME vagrant
stow -t $HOME alacritty
stow -t $HOME borg
```

## Starting Sway with systemd, the right way

### Use agetty --autologin

```console
# systemctl edit getty@tty1
[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --skip-login --nonewline --noissue --autologin --noclear username %I $TERM
Environment=XDG_SESSION_TYPE=wayland
```

Source: https://wiki.archlinux.org/title/Getty

### Deploy and enable sway services

```console
$ stow -t $HOME sway
$ systemctl --user enable kanshi.service
$ systemctl --user enable xdg-desktop-portal.service
```

## License

AGPL-3.0
