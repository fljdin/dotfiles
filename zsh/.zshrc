# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
ZSH_CUSTOM=$HOME/.zsh-custom
plugins=(git tmux ssh-agent)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='vim'
fi

eval "$(direnv hook zsh)"

if [ -e /home/florent/.nix-profile/etc/profile.d/nix.sh ]; then . /home/florent/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
