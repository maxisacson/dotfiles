#!/bin/bash

cols=$(tput cols)
half_cols=$((cols/2))
for i in {0..7}; do
    printf "\033[0;3${i}m%2d\033[0m" $i
    tput setab $i
    for ((j=2;j<${half_cols};j++)); do
        echo -n " "
        # echo -ne "\033[3${i}mX"
    done
    tput sgr0
    printf "\033[0;9${i}m%2d\033[0m" $((i+8))
    tput setab $((i+8))
    for ((j=2;j<${half_cols};j++)); do
        echo -n " "
        # echo -ne "\033[9${i}mX"
    done
    tput sgr0
    echo
done
tput sgr0
echo

for C in {0..7}; do
    tput setab $C
    echo -n "   "
done
tput sgr0
echo

for C in {8..15}; do
    tput setab $C
    echo -n "   "
done
tput sgr0
echo

echo

for c in {30..37}; do
    echo -en "\033[0;${c}m 0;$c \033[0m"
done
echo

for c in {90..97}; do
    echo -en "\033[0;${c}m 0;$c \033[0m"
done
echo

for c in {30..37}; do
    echo -en "\033[1;${c}m 1;$c \033[0m"
done
echo

for c in {90..97}; do
    echo -en "\033[1;${c}m 1;$c \033[0m"
done
echo

for c in {40..47}; do
    echo -en "\033[0;${c}m 0;$c  \033[0m"
done
echo

for c in {100..107}; do
    echo -en "\033[0;${c}m 0;$c \033[0m"
done
echo
