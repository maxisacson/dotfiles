for C in {0..255}; do
    tput setab $C
    echo -n "    "
    tput sgr0
    echo " $C"
done
tput sgr0
echo
