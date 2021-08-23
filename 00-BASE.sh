#!/bin/bash
set -e
# Author	:	 Rodrigo Alan M. Carvalho

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo "pt_BR.UTF-8 UTF-8"  >> /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
echo "ArchLinux" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 ArchLinux.localdomain ArchLinux" >> /etc/hosts
# echo root:password | chpasswd

pacman -S --noconfirm grub efibootmgr networkmanager wpa_supplicant xdg-user-dirs xdg-utils bluez flatpak os-prober ntfs-3g

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable fstrim.timer

useradd -m rouzero
echo rouzero:password | chpasswd

echo "rouzero ALL=(ALL) ALL" >> /etc/sudoers.d/rouzero


/bin/echo -e "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




