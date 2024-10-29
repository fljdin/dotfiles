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

```console
$ cd dotfiles
$ stow -t $HOME */
```

Change the user shell and restart

```console
$ chsh
/usr/bin/fish
```

## Send signal to i3blocks on apt update

```sh
# /etc/apt/apt.conf.d/80i3blocks
APT::Update::Post-Invoke { "pkill -RTMIN+9 i3blocks || true"; };
DPkg::Post-Invoke        { "pkill -RTMIN+9 i3blocks || true"; };
```

_Source:_ <https://github.com/vivien/i3blocks-contrib/tree/master/apt-upgrades>

## License

AGPL-3.0
