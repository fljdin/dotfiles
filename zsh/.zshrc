# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.bin:$HOME/.local/bin:$PATH

# Go bin path
export GOPATH="$HOME/.go"
export PATH=$PATH:$GOPATH/bin

# vagrant
export VAGRANT_HOME="$HOME/.vagrant.d"

# pgenv
export PGENV_ROOT=/var/lib/pgenv
export PATH=$HOME/.pgenv/bin:$PGENV_ROOT/pgsql/bin:$PATH
export LD_LIBRARY_PATH=$PGENV_ROOT/pgsql/lib:$LD_LIBRARY_PATH

# oracle instanclient
export ORACLE_HOME=/opt/oracle/instantclient_21_11
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export PATH=$PATH:$ORACLE_HOME/bin

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
