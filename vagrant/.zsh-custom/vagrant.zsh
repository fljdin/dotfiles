# vagrant
export VAGRANT_HOME="$HOME/.vagrant.d"

vagrant_list() {
  if [[ -d "$VAGRANT_HOME/vagrantfiles" ]] ; then
    ls -1 $VAGRANT_HOME/vagrantfiles
  fi
}

vagrant_load() {
  if [[ ! -f "$VAGRANT_HOME/vagrantfiles/$1" ]] ; then
    echo "Config \"$1\" does not exists."
  else
    export VAGRANT_CWD=$VAGRANT_HOME/currents/$1
    mkdir -p $VAGRANT_CWD

    cp $VAGRANT_HOME/vagrantfiles/$1 $VAGRANT_CWD/Vagrantfile
  fi
}
