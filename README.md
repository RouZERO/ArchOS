# ArchOS UEFI

# PERPARANDO O DISCO

```
fdisk -l
cfdisk /dev/sda
Escolher GPT
```
```
SDA1  	 		 =    512MB   		 = EFI
SDA2   			 =    4GB   		 = SWAP
SDA3    		 =    RESTANTE   	 = Sistema
```
# CONFIGURANDO O FORMATO DAS PARTIÇÕES

Transformar Partição em FAT32
```
mkfs.fat -F32 /dev/sda1
```
Transformar Partição em EXT4
```
mkfs.ext4 /dev/sda3
```
Criar Partição de SWAP
```
mkswap /dev/sda2
```
Ligar Partição de SWAP
```
swapon /dev/sda2
```
# INSTALANDO BASE DO S.O

```
mount /dev/sda3 /mnt
```
```
pacstrap /mnt base base-devel
```

# CONFIGURANDO FSTAB  
```
genfstab -U -p /mnt >> /mnt/etc/fstab
```
```
arch-chroot /mnt /bin/bash
```
# CONFIGURANDO LINGUAGEM
Configurando o Arquvo Locale.gen
```
nano /etc/locale.gen
```
Procurar e Descomentar
```
pt_BR UTF-8 UTF-8
```
Configurando o Arquivo Locale.conf
```
echo LANG=pt_BR.UTF-8 > /etc/locale.conf
```
Finalizando a Configuração da Linguagem
```
locale-gen
```
Exportando a Configuração
```
export LANG=pt_BR.UTF-8
```

-	SET YOUR TIME ZONE

# ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
# hwclock --systohc



-	SET HOSTNAME & NETWORK

# echo arch > /etc/hostname

# nano /etc/hosts
127.0.1.1 arch.localdomain arch

-	INTERNET

# pacman -S wireless_tools wpa_supplicant wpa_actiond dialog networkmanager

# systemctl enable NetworkManager

-	SET ROOT PASSWORD

# passwd

-	ADICIONANDO USUÁRIO

# useradd -m -g users -G storage,power,wheel,audio,video -s /bin/bash "username"
# passwd "username"

-	PACOTES 32 bits pacman

# nano /etc/pacman.conf
Descomentar   	 [multilib]
# pacman -Sy   		 

lib32-fontconfig 2.13.0+10+g58f5285-1.1

-	HABILITANDO SUDO

#nano /etc/sudoers
seuusuário   ALL=(ALL) ALL

-	INSTALL AND CONFIGURE BOOTLOADER

# pacman -S grub efibootmgr

# mkdir /boot/efi
# mount /dev/sda1 /boot/efi

# grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --recheck
# grub-mkconfig -o /boot/grub/grub.cfg

# mkdir /boot/efi/EFI/BOOT
# cp /boot/efi/EFI/GRUB/grubx64.efi  /boot/efi/EFI/BOOT/BOOTX64.EFI
# nano /boot/efi/startup.nshz
  	bcfg boot add 1 fs0:\EFI\GRUB\grubx64.efi "My GRUB bootloader"

-	RAID

# nano /etc/mkinitcpio.conf
Edit the HOOKS line to include mdadm_udev right before the filesystems entry
# mkinitcpio -p linux


-	UNMOUNT THE PARTITIONS AND REBOOT

# exit
# umount -R /mnt
# reboot

-	INSTALANDO MODO GRÁFICO DO SISTEMA

# pacman -S xorg xorg-xinit xorg-server gnome-shell nautilus gnome-terminal gnome-tweak-tool gnome-control-center gnome-disk-utility gedit evince xdg-user-dirs gdm intel-ucode baobab file-roller gnome-keyring


# systemctl enable gdm

# Reboot

-    ALTERANDO O KERNEL E HEADER

# uname -r
# pacman -S linux-zen
# grub-mkconfig -o /boot/grub/grub.cfg
# pacman -R linux


-	INSTALANDO GPU

# pacman -S nvidia-dkms nvidia-utils lib32-nvidia-utils opencl-nvidia lib32-opencl-nvidia nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader

-	FSTAB NOVO DISCO NTFS

# pacman -S ntfs-3g

/dev/md124p1 /home/rouzero/Games ntfs-3g uid=1000,gid=1000,rw,user,exec,umask=000 0 0

-	INSTALANDO FONTES ADICIONAIS

# pacman -S font-bh-ttf ttf-roboto ttf-droid ttf-liberation ttf-croscore noto-fonts

 -	INSTALAR PROGRAMAS & EXTRAS



# pacman -Sy git
# git clone https://aur.archlinux.org/yay.git
# cd yay
# makepkg -si

#  pacman -S neofetch

#  pacman -S transmission-gtk

$  yay -S htop
$  yay -S gamemode lib32-gamemode
       
-	REMOVENDO PACOTES ORFÃS

# pacman -Rs $(pacman -Qqdt)


-	USANDO WINETRICKS PARA INSTALAR COMPONENTES

Instalado
WINEPREFIX=/home/rouzero/Games/Aplicativos/WinePrefix/TowerFall winetricks

Steam
WINEPREFIX=/home/rouzero/Arquivos/Aplicativos/STEAMApps/compatdata/570940/pfx/ winetricks 

-	TEMA, ICONES E CURSOR

Tema	=	Qogir
Icone	=	Papirus

-	CONFIGURANDO

SOM




# sudo cp -vR /usr/share/pulseaudio/alsa-mixer/paths /usr/share/pulseaudio/alsa-mixer/paths_backup


# sudo perl -pi -0 -e 's/(\[[A-Za-z ]*Mic Boost\][A-Za-z._=\s-]+volume *= *)merge/\1zero/g;' /usr/share/pulseaudio/alsa-mixer/paths/*


# sudo diff -r -C 5 /usr/share/pulseaudio/alsa-mixer/paths_backup /usr/share/pulseaudio/alsa-mixer/paths


# gedit /etc/pulse/default.pa

ADCIONAR

### Enable Echo/Noise-Cancelation
load-module module-echo-cancel aec_method=webrtc aec_args="analog_gain_control=0 digital_gain_control=1" source_name=echoCancel_source sink_name=echoCancel_sink
set-default-source echoCancel_source
set-default-sink echoCancel_sink

MUDAR TERMINAL 

sudo cp /usr/bin/gnome-terminal /usr/bin/gnome-terminal.bck
sudo ln -s /usr/bin/tilix /usr/bin/gnome-terminal

