#!/bin/bash

primary="$(xrandr | sed -n 's/^.* connected primary \([0-9]\+x[0-9]\+\)[+-][0-9]\+[+-][0-9].*$/\1/p')"
xoff=${primary%%x*}

xsize=960
ysize=540
size="${xsize}x${ysize}"
xoff=$((xoff-xsize))
geo="${size}+$xoff-0"

terminator -p Transparent -b --geometry=${geo} -x htop
