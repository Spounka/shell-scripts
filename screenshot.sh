#!/bin/sh

date=$(date +%Y-%m-%d_%H:%M:%S)
path=$HOME/Pictures/Screenshots
name=$1

mkdir -p $path


if [[ -z $name ]]; then
    import -window root $path/$date".jpg"
else
    import -window root $path/$name".jpg"
fi

