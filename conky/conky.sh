#!/bin/bash

n_monitors=$(xrandr -q | grep " connected" | wc -l)

# if [[ $n_monitors -eq 2 ]]; then
#     conky --config=$HOME/.conky/conkyrc-dualdisplay
# elif [[ $n_monitors -eq 1 ]]; then
#     conky --config=$HOME/.conky/conkyrc-singledisplay
# fi
conky --config=$HOME/.conky/conky.lua
conky --config=$HOME/.conky/conky2.lua
