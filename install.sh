#!/bin/bash
#My Arch Linux Install Script
#Auther: Samuel Walker
#Date: 11/16/20

read -p "Enter the hostname for the new system:" hostname
read -sp "Enter the root password of the new system:" rootpassword
read -p "Enter the name of the default user on the new system:" username
read -sp "Enter the password of $username:" userpassword

timedatectl set-ntp true
reflector --verbose --latest 10 --sort rate --save /etc/pacman.d/mirrorlist

sed -i '92,93 s/#//' /etc/pacman.conf

pacstrap /mnt base base-devel linux linux-firmware emacs sudo nano btrfs-progs dosfstools networkmanager htop xorg-server xf86-video-intel mesa lib32-mesa nvidia nvidia-utils lib32-nvidia-utils lightdm lightdm-gtk-greeter xmonad xmonad-contrib xmobar dmenu alacritty picom nitrogen light-locker steam discord nautilus ntfs-3g pulseaudio vlc gnome-themes-extra arc-icon-theme intel-ucode amd-ucode grub efibootmgr os-prober git fish ttf-dejavu

genfstab -U /mnt >> /mnt/etc/fstab

cp ./install-2.sh /mnt/

sed -i "s/HOSTNAME/$hostname" /mnt/install-2.sh
sed -i "s/ROOTPASSWORD/$rootpassword" /mnt/install-2.sh
sed -i "s/USERNAME/$username" /mnt/install-2.sh
sed -i "s/USERPASSWORD/$userpassword" /mnt/install-2.sh

arch-chroot /mnt ./install-2.sh

