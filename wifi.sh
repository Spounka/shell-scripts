#!/bin/sh

input=$1

# interface_name=$(ip link | awk '{print $2}' | grep wlp)
# nmcli 

if [[ -z input ]]; then
    input="Spounka"
fi

nmcli radio all on;

wifirow=$(nmcli device wifi list | grep -i $input);
while [[ -z $wifirow ]]; do
    nmcli device wifi rescan;
    wifirow=$(nmcli device wifi list | grep -i $input);
    sleep 1
done

nmcli device wifi connect $input
