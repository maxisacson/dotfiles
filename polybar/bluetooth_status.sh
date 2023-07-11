#!/bin/bash

if [[ $(bluetoothctl show | awk '/Powered:/{print $2}') == yes ]]; then
    if [[ $(bluetoothctl devices Connected | wc -l) -eq 0 ]]; then
        echo "%{F#ebdbb2}󰂯"
    else
        echo "%{F#83a598}󰂱"
    fi
else
    echo "%{F#a89984}󰂲"
fi
