#!/bin/bash

function confirm() {
    echo -e "Yes\nNo" | rofi -theme ~/git/dotfiles/polybar/confirm.rasi -dmenu -p "$1" -selected-row 1
}

theme="~/git/dotfiles/polybar/powermenu.rasi"
# lock=" Lock"
# suspend=" Sleep"
# logout=" Logout"
# reboot=" Restart"
# shutdown=" Shutdown"
lock="󰌾 Lock"
suspend="󰤄 Sleep"
logout="󰍃 Logout"
reboot="󰑐 Restart"
shutdown="󰐥 Shutdown"
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"
choice="$(echo -e "$options" | rofi -theme $theme -p "$(whoami)@$(cat /etc/hostname)" -dmenu -selected-row 0)"

case $choice in
    $lock)
        ans=$(confirm "$choice ?" &)
        if [[ $ans == "Yes" ]]; then
            . ~/git/dotfiles/polybar/lock.sh
        else
            exit 0
        fi
        ;;
    $suspend)
        ans=$(confirm "$choice ?" &)
        if [[ $ans == "Yes" ]]; then
            systemctl suspend
        else
            exit 0
        fi
        ;;
    $logout)
        ans=$(confirm "$choice ?" &)
        if [[ $ans == "Yes" ]]; then
            i3-msg exit
        else
            exit 0
        fi
        ;;
    $reboot)
        ans=$(confirm "$choice ?" &)
        if [[ $ans == "Yes" ]]; then
            systemctl reboot
        else
            exit 0
        fi
        ;;
    $shutdown)
        ans=$(confirm "$choice ?" &)
        if [[ $ans == "Yes" ]]; then
            systemctl poweroff
        else
            exit 0
        fi
        ;;
esac




# uptime=$(uptime -p | sed -e 's/up //g')
#
# rofi_command="rofi -theme ~/.config/polybar/powermenu.rasi"
#
# # Options
# shutdown=" Shutdown"
# reboot=" Restart"
# lock=" Lock"
# suspend=" Sleep"
# logout=" Logout"
#
# # Confirmation
# confirm_exit() {
#     rofi -dmenu\
#         -i\
#         -no-fixed-num-lines\
#         -p "Are You Sure? : "\
#         -theme ~/.config/polybar/confirm.rasi
# }
#
# # Message
# msg() {
#     rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
# }
#
# # Variable passed to rofi
# options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"
#
# chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
# case $chosen in
#     $shutdown)
#         ans=$(confirm_exit &)
#         if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
#             systemctl poweroff
#         elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
#             exit 0
#         else
#             msg
#         fi
#         ;;
#     $reboot)
#         ans=$(confirm_exit &)
#         if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
#             systemctl reboot
#         elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
#             exit 0
#         else
#             msg
#         fi
#         ;;
#     $lock)
#         if [[ -f /usr/bin/i3lock ]]; then
#             i3lock
#         elif [[ -f /usr/bin/betterlockscreen ]]; then
#             betterlockscreen -l
#         fi
#         ;;
#     $suspend)
#         ans=$(confirm_exit &)
#         if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
#             mpc -q pause
#             amixer set Master mute
#             systemctl suspend
#         elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
#             exit 0
#         else
#             msg
#         fi
#         ;;
#     $logout)
#         ans=$(confirm_exit &)
#         if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
#             if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
#                 openbox --exit
#             elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
#                 bspc quit
#             elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
#                 i3-msg exit
#             fi
#         elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
#             exit 0
#         else
#             msg
#         fi
#         ;;
# esac
