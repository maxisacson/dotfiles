#!/bin/bash

if [[ $(bluetoothctl show | awk '/Powered:/{print $2}') == yes ]]; then
    bluetoothctl power off
else
    bluetoothctl power on
fi
