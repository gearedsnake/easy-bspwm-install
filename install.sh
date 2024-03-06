#!/bin/bash

script_dir=$(dirname "$0")

function reboottofinish() {
echo -e "to fully finish the installation you need to reboot\ndo you wanna do this now? Y/N"

while true; do

read -r input3

if [[ "$input3" =~ ^[Yy]$ ]]; then

break

elif [[ "$input3" =~ ^[Nn]$ ]]; then

break

else

echo "ERROR: input is not valid, please enter Y or N"

fi

done

if [[ "$input3" =~ ^[Yy]$ ]]; then

reboot

elif [[ "$input3" =~ ^[Nn]$ ]]; then

echo "You need to reboot manually to finish the installation"
exit 0

else

exit 1

fi
}




function gg() {
    echo -e "---------------------------\nInstallation completed with no issues (hopefully)\nNow you have fully configured and working bspwm\nto check changes and apps this script install check readme.md"
    reboottofinish
}


function lysetup() {
    echo -e "do you want to install and enable ly?\nWARNING: DO NOT CHOOSE YES IF YOU ALREADY HAVE LOGIN SCREEN! OR SOMETHING WILL BREAK\n---------------------------\n[Y]es, install ly loginscreen for me\n[N]o, i already have one or i wanna setup one manually"
    while true; do

read -r input2

if [[ "$input2" =~ ^[Yy]$ ]]; then

break

elif [[ "$input2" =~ ^[Nn]$ ]]; then

break

else

echo "ERROR: input is not valid, please enter Y or N"

fi

done

if [[ "$input2" =~ ^[Yy]$ ]]; then

echo "installing ly!"
sudo pacman -S ly --noconfirm
systemctl enable ly.service
gg

elif [[ "$input2" =~ ^[Nn]$ ]]; then

echo "finishing!"
gg

else

exit 1

fi
}




function installmain() {
    echo "installing!"
    sudo pacman -Syu --noconfirm
    sudo pacman -S bspwm sxhkd polybar rofi dunst nitrogen alacritty thunar bluez bluez-utils blueman pipewire-alsa pipewire-pulse pavucontrol --noconfirm
    mkdir -p ~/.config/bspwm && cp -f "$script_dir/dotfiles/.config/bspwm/bspwmrc" ~/.config/bspwm
    mkdir -p ~/.config/dunst && cp -f "$script_dir/dotfiles/.config/dunst/dunstrc" ~/.config/dunst
    mkdir -p ~/.config/polybar && cp -f "$script_dir/dotfiles/.config/polybar/config.ini" ~/.config/polybar
    mkdir -p ~/.config/sxhkd && cp -f "$script_dir/dotfiles/.config/sxhkd/sxhkdrc" ~/.config/sxhkd
    chmod +x ~/.config/bspwm/bspwmrc
    systemctl enable bluetooth.service
    lysetup
}




echo -e "welcome to bspwm install\nthis script will install and configure all of the important software for you\nWARNING: the only two dependencies you need is git and xorg, make sure you have them"
sleep 1
echo -e "---------------------------\nproceed? Y/N"

while true; do

read -r input1

if [[ "$input1" =~ ^[Yy]$ ]]; then

break

elif [[ "$input1" =~ ^[Nn]$ ]]; then

break

else

echo "ERROR: input is not valid, please enter Y or N"

fi

done

if [[ "$input1" =~ ^[Yy]$ ]]; then

installmain

elif [[ "$input1" =~ ^[Nn]$ ]]; then

echo "Ok, exiting"
exit 0

else

exit 1

fi

