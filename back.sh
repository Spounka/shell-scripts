#/bin/bash

steps=$1
i=0

if [ -z $steps ]; then
    cd ../
else

    while (( i < steps));
    do
        cd ../
        (( i++ ))
    done
fi

