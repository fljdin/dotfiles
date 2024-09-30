#! /usr/bin/env bash
# $HOME/.bin/borg-create.sh

# variables
PROG=$(basename "$0")
EXCLUDE=$HOME/.config/borg/exclude.list
UUID="ef6f29f8-e6ff-44cf-ae9a-10ea7b9a9e23"

# helpers
info() { notify-send -a "$PROG" "$*"; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

disk_mount() {
    if [ -n DISPLAY -a $(which zenity) ]; then
        passphrase=$(zenity --password --title="$PROG Unlock device")
    else
        read -s -p "Enter passphrase: " passphrase
    fi

    udisksctl unlock \
        --key-file=<(echo -n "$passphrase") \
        --block-device=/dev/disk/by-uuid/$UUID && \
    udisksctl mount \
        --block-device=/dev/mapper/luks-$UUID
}

disk_unmount() {
    udisksctl unmount \
        --block-device=/dev/mapper/luks-$UUID && \
    udisksctl lock \
        --block-device=/dev/disk/by-uuid/$UUID
}

# main
info "Starting backup"

disk_mount
export BORG_REPO=$(ls -d1 /media/$USER/*/borg-backup 2> /dev/null | head)

if [ ! -d "$BORG_REPO" ] ; then
    info "Borg repository is unavailable"
    exit 2
fi

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

disk_unmount

exit ${global_exit}
