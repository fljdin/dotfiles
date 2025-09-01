# vagrant
set -x VAGRANT_HOME "$HOME/.vagrant.d"

function vagrant_list
  if test -d "$VAGRANT_HOME/vagrantfiles"
    ls -1 $VAGRANT_HOME/vagrantfiles/
  end
end

function vagrant_load
  set VAGRANTFILE $VAGRANT_HOME/vagrantfiles/$argv[1]
  set -gx VAGRANT_CWD "$VAGRANT_HOME/currents/$argv[1]"
  mkdir -p $VAGRANT_CWD

  if test ! -f "$VAGRANTFILE"
    echo "Config \"$argv[1]\" does not exist."
    echo "Use vagrant init then:"
    echo "cp $VAGRANT_CWD/Vagrantfile $VAGRANTFILE"
    return 1
  else
    cp "$VAGRANTFILE" "$VAGRANT_CWD/Vagrantfile"
  end
end
