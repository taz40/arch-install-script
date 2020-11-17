#!/bin/bash
#second part of install script, will run after entering chroot
#Author: Samuel Walker
#Date: 11/16/20

ln -sf /usr/share/America/Denver /etc/localtime

hwclock --systohc

sed -i '177 s/#//' /etc/locale.gen

locale-gen

echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "HOSTNAME" >> /etc/hostname
echo "127.0.0.1    localhost" >> /etc/hosts
echo "::1          localhost" >> /etc/hosts
echo "127.0.1.1    HOSTNAME.domain    HOSTNAME" >> /etc/hosts

echo "root:ROOTPASSWORD" | chpasswd

useradd -m -G wheel,users,storage,audio,video -s /bin/fish USERNAME

echo "USERNAME:USERPASSWORD" | chpasswd

sed -i '82 s/#//' /etc/sudoers

git clone --bare https://github.com/taz40/dotfiles.git /home/USERNAME/.dotfiles

/usr/bin/git --git-dir=/home/USERNAME/.dotfiles/ --work-tree=/home/USERNAME/ checkout

chown -R USERNAME:USERNAME /home/USERNAME

chsh -s /bin/fish

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch

grub-mkconfig -o /boot/grub/grub.cfg
