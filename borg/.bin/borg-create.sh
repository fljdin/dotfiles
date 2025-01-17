#! /usr/bin/env bash
# $HOME/.bin/borg-create.sh

# variables
PROG=$(basename "$0")
EXCLUDE=$HOME/.config/borg/exclude.list

# helpers
info() { notify-send -a "$PROG" "$*"; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

# main
info "Starting backup"

export BORG_REPO=$(ls -d1 /media/$USER/*/borg-backup 2> /dev/null | head)

if [ ! -d "$BORG_REPO" ] ; then
    info "Borg repository is unavailable"
    exit 2
fi

if [ -n DISPLAY -a $(which zenity) ]; then
    BORG_PASSPHRASE=$(zenity --password --title="$PROG Unlock device")
else
    read -s -p "Enter passphrase: " BORG_PASSPHRASE
fi

export BORG_PASSPHRASE

borg create \
    --stats --show-rc \
    --exclude-from $EXCLUDE \
    ::'{hostname}-{now}' $HOME

backup_exit=$?

borg prune \
    --stats --show-rc \
    --glob-archives '{hostname}-*' \
    --save-space --keep-daily 7

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup and Prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup and/or Prune finished with warnings"
else
    info "Backup and/or Prune finished with errors"
fi

exit ${global_exit}
