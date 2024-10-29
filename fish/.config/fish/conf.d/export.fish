# Personal bin path
fish_add_path $HOME/.bin
fish_add_path $HOME/.local/bin

# Go bin path
set -x GOPATH "$HOME/.go"
fish_add_path $GOPATH/bin

# pgenv
set -x PGENV_ROOT "/var/lib/pgenv"
set -x LD_LIBRARY_PATH "$PGENV_ROOT/pgsql/lib"
fish_add_path $HOME/.pgenv/bin
fish_add_path $PGENV_ROOT/pgsql/bin

# oracle instanclient
set -x ORACLE_HOME "/opt/oracle/instantclient_21_11"
set -x LD_LIBRARY_PATH "$ORACLE_HOME/lib" $LD_LIBRARY_PATH
fish_add_path $ORACLE_HOME/bin
