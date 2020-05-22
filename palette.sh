width=$(tput cols)
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
