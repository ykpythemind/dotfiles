#!/bin/bash

set -eu

ARCH=$(uname -m)
if [[ $ARCH == arm64 ]]; then
    echo "Current Architecture: $ARCH"
	eval $(/opt/homebrew/bin/brew shellenv)
elif [[ $ARCH == x86_64 ]]; then
    echo "Current Architecture: $ARCH"
	eval $(/usr/local/bin/brew shellenv)
fi

# original: https://yoshiori.hatenablog.com/entry/2021/04/13/171405

# 3c-4d-be-e2-05-e0 - 薫人のAirPods Pro
AIR_PODS_ADDRESS=3c-4d-be-e2-05-e0 # Your AirPods MAC address

bluetoothconnector -c $AIR_PODS_ADDRESS
for ((i=0 ; i<10 ; i++))
do
    if [ "Connected" == $(bluetoothconnector -s $AIR_PODS_ADDRESS) ]; then
        sleep 1
        SwitchAudioSource -u "${AIR_PODS_ADDRESS}"
        sleep 1
        say -v samantha Connected
        break
    fi
    sleep 1
done
