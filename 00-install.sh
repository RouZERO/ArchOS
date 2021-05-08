#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
echo "pt_BR.UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf
#echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf
echo "ArchLinux" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 ArchLinux.localdomain ArchLinux" >> /etc/hosts

pacman -S --noconfirm grub grub-btrfs efibootmgr networkmanager dialog wpa_supplicant reflector xdg-user-dirs-gtk xdg-utils bluez bluez-utilsbash-completion flatpak os-prober ntfs-3g xf86-video-amdgpu

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable avahi-daemon
systemctl enable tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld

useradd -m rouzero
usermod -aG libvirt rouzero

echo "rouzero ALL=(ALL) ALL" >> /etc/sudoers.d/rouzero


/bin/echo -e "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




