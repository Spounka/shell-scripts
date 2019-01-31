#!/bin/bash

content=$1

cat $content | xclip -selection clipboard
