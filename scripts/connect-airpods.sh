#!/bin/bash

set -eu

# https://yoshiori.hatenablog.com/entry/2021/04/13/171405

# 3c-4d-be-e2-05-e0 - 薫人のAirPods Pro

AIR_PODS_ADDRESS=3c-4d-be-e2-05-e0 # Your AirPods MAC address
AIR_PODS_NAME="薫人のAirPods Pro" # Your AirPods name

/usr/local/bin/bluetoothconnector -c $AIR_PODS_ADDRESS
for ((i=0 ; i<10 ; i++))
do
    if [ "Connected" == $(/usr/local/bin/bluetoothconnector  -s $AIR_PODS_ADDRESS) ]; then
        sleep 1
        /usr/local/Cellar/switchaudio-osx/1.1.0/SwitchAudioSource -s  $AIR_PODS_NAME
        sleep 1
        say -v samantha Connected
        break
    fi
    sleep 1
done
