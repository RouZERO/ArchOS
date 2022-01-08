#!/bin/bash
set -e
##################################################################################################################
# Author	:	 Rodrigo Alan M. Carvalho
##################################################################################################################

# Configuração de Horário.
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

# Configuração de Idioma.
echo "pt_BR.UTF-8 UTF-8"  >> /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf

# Para alterar o nome do computador altere onde esta ArchLinux.
echo "ArchLinux" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 ArchLinux.localdomain ArchLinux" >> /etc/hosts

# Para alterar a senha do administrador altere onde esta passsword.
echo root:password | chpasswd

# Arquivos Básicos.
pacman -S --noconfirm grub efibootmgr networkmanager wpa_supplicant xdg-user-dirs xdg-utils bluez flatpak os-prober ntfs-3g 

# Para usar o Servidor de som Pipeware.
pacman -S --noconfirm pipewire pipewire-{alsa,jack,media-session,pulse}

# Para usar o Servidor de som Pulseaudio.
# pacman -S --noconfirm pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack

useradd -m rouzero

# Para alterar o nome de usuário altere onde esta rouzero e a senha altere passsword.
echo rouzero:password | chpasswd
echo "rouzero ALL=(ALL) ALL" >> /etc/sudoers.d/rouzero

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable fstrim.timer

/bin/echo -e "\e[1;32mEtapa Finalizada! Agora Instale um Desktop Environment \e[0m"
