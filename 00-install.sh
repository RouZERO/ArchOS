#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo "pt_BR.UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
# echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf
echo "ArchLinux" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 ArchLinux.localdomain ArchLinux" >> /etc/hosts
echo root:password | chpasswd

pacman -S --noconfirm grub efibootmgr networkmanager wpa_supplicant reflector xdg-user-dirs-qt xdg-utils bluez flatpak os-prober ntfs-3g

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
# systemctl enable avahi-daemon
# systemctl enable tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer

useradd -m rouzero
echo rouzero:password | chpasswd

echo "rouzero ALL=(ALL) ALL" >> /etc/sudoers.d/rouzero


/bin/echo -e "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




