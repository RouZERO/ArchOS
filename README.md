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
# INSTALANDO ARQUIVOS BASE

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

ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc



# SET HOSTNAME & NETWORK

echo arch > /etc/hostname

nano /etc/hosts
127.0.1.1 arch.localdomain arch

# INTERNET

pacman -S wireless_tools wpa_supplicant wpa_actiond dialog networkmanager

systemctl enable NetworkManager

# SET ROOT PASSWORD

passwd

# ADICIONANDO USUÁRIO

useradd -m -g users -G storage,power,wheel,audio,video -s /bin/bash "username"
passwd "username"

# PACOTES 32 bits pacman

nano /etc/pacman.conf
Descomentar   	 [multilib]
pacman -Sy   		 

# HABILITANDO SUDO

nano /etc/sudoers
seuusuário   ALL=(ALL) ALL

# INSTALL AND CONFIGURE BOOTLOADER

pacman -S grub efibootmgr

mkdir /boot/efi
mount /dev/sda1 /boot/efi

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --recheck
grub-mkconfig -o /boot/grub/grub.cfg

# RAID

nano /etc/mkinitcpio.conf
Edit the HOOKS line to include mdadm_udev right before the filesystems entry
mkinitcpio -p linux


# UNMOUNT THE PARTITIONS AND REBOOT

exit
umount -R /mnt
reboot

# INSTALANDO MODO GRÁFICO DO SISTEMA

pacman -S xorg xorg-xinit xorg-server gnome-shell nautilus gnome-terminal gnome-tweak-tool gnome-control-center gnome-disk-utility gedit evince xdg-user-dirs gdm intel-ucode baobab file-roller gnome-keyring


systemctl enable gdm

Reboot
