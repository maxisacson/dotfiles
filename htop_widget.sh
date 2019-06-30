#!/bin/bash

primary="$(xrandr | sed -n 's/^.* connected primary \([0-9]\+x[0-9]\+\)[+-][0-9]\+[+-][0-9].*$/\1/p')"
xoff=${primary%%x*}

# xsize=960
# ysize=540

xsize=920
ysize=600

size="${xsize}x${ysize}"
xoff=$((xoff-xsize))
geo="${size}+$xoff-0"

# terminator -p Transparent -b --geometry=${geo} -x htop
# terminator -p gruvbox-dark-transparent -b --geometry=${geo} -x htop
terminator -p gruvbox-dark-semitransparent -b --geometry=${geo} -x glances --process-short-name
