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
stow -t $HOME */
```

## License

AGPL-3.0
