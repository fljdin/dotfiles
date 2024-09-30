# Personal bin path
export PATH=$HOME/.bin:$HOME/.local/bin:$PATH

# Go bin path
export GOPATH="$HOME/.go"
export PATH=$PATH:$GOPATH/bin

# pgenv
export PGENV_ROOT=/var/lib/pgenv
export PATH=$HOME/.pgenv/bin:$PGENV_ROOT/pgsql/bin:$PATH
export LD_LIBRARY_PATH=$PGENV_ROOT/pgsql/lib:$LD_LIBRARY_PATH

# oracle instanclient
export ORACLE_HOME=/opt/oracle/instantclient_21_11
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export PATH=$PATH:$ORACLE_HOME/bin
