#!/bin/zsh

pip3 list --outdated | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U
