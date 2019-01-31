#!/bin/bash

steps=$1
i=0

while (( i < steps));
do
    cd ../
    (( i++ ))
done

