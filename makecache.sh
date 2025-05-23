#!/bin/bash

filename="/home/spounka/.makecache.log"
if [[ ! -f $filename ]]; then
    touch $filename
    chmod 644 $filename
fi
echo "$(date): Ran makecache" >> $filename

dnf makecache
