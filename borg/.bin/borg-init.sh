#! /usr/bin/env bash
# $HOME/.bin/borg-init.sh

# variables
PROG=$(basename "$0")
BORG_REPO=$1

# usage
if [ -z "$BORG_REPO" ]; then
    echo "Missing argument: BORG_REPO" >&2
    exit 2
fi

# main
export BORG_REPO
borg init \
    --encryption=keyfile \
    --storage-quota 8G \
