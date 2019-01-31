#!/bin/bash

# brightness=$1
# amount=$2

display=$(xrandr --verbose | grep " connected" | cut -f1 -d " ")
currBright=$(xrandr --verbose | grep -i brightness | cut -f2 -d " ")

while getopts b:a: option
do
    case "${option}"
        in
        b) BRIGHTNESS=${OPTARG};;
        a) AMOUNT=${OPTARG};;
    esac
done

if [ ! -z "${BRIGHTNESS}" ]; then
    xrandr --output $display --brightness $BRIGHTNESS

elif [ ! -z "${AMOUNT}" ]; then
    if [ ! $currBright = 0 ]; then
        newBright=$(python3 -c "
x = $currBright
y = "${AMOUNT}"
print(x + y)
        ")
        if [ $(python3 -c "x = 0
if $newBright < 0.2:
    x = 1
else:
    x = 0
print(x)") = 1 ]; then
            newBright=0.1
        elif [ $newBright > 1 ]; then
            newBright=1
        fi
        xrandr --output $display --brightness $newBright

    else
        echo "Error"
    fi
elif [ -z "${BRIGHTNESS}" && -z "${AMOUNT}" ]; then
    echo "Only one argument at time"
else
    echo "Need to specifie one argument"
fi


