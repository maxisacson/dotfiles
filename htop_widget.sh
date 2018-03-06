#!/bin/bash

nscreens="$(xrandr | grep " connected" | wc -l)"

size="960x540"
if [[ $nscreens == 2 ]]; then
    geo="${size}-1680-0"
elif [[ $nscreens == 1 ]]; then
    geo="${size}-0-0"
fi

terminator -p Transparent -b --geometry=${geo} -x htop
