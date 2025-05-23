#!/bin/sh

folderpath=$1
backupdir="$HOME/Backups"

if [[ -z $folderpath ]]; then
    >&2 echo "Input folder name";
    exit 1
fi
folderpath="$(readlink -f $folderpath)"

filename="$(basename $folderpath)"

if [[ -z $filename ]]; then
    >&2 echo "Failed to get filename";
fi

mkdir -p $backupdir

tar --exclude='venv/' --exclude='.venv/' --exclude='__pycache__' --exclude='node_modules/' -c $folderpath -f "$backupdir/$filename.tar.gz"
