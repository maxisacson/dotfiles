for C in {0..255}; do
    tput setab $C
    echo -n "$C "
done
tput sgr0
echo

for c in {0..255}; do
    echo -e "\033[0;${c}m 0;$c \033[0m \033[1;${c}m 1;$c \033[0m"
done
