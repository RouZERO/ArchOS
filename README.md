# ArchOS UEFI

#### 1. PERPARANDO O DISCO
```
fdisk -l
```
```
cfdisk /dev/sda
```
```
Escolher GPT
```
```
EFI        = sdX1      = 512MB 
SISTEMA    = sdx2      = Restante
```
#### 2. CONFIGURANDO O FORMATO DAS PARTIÇÕES

Transformar Partição em FAT32
```
mkfs.fat -F32 /dev/sda1
```
Transformar Partição em EXT4
```
mkfs.ext4 /dev/sda2
```
```
mount /dev/sda3 /mnt
```
#### 3. CONFIGURANDO ARQUIVO DE SWAP
```
fallocate -l 4GB /mnt/swapfile
```
```
chmod 600 /mnt/swapfile
```
```
mkswap /mnt/swapfile
```
```
swapon /mnt/swapfile
```
#### 4. INSTALANDO ARQUIVOS BÁSICOS
```
pacstrap /mnt base base-devel
```
# CONFIGURANDO O SISTEMA

#### 5. CONFIGURANDO FSTAB  
```
genfstab -U -p /mnt >> /mnt/etc/fstab
```
#### 6. ENTRADO NO SISTEMA COMO ADMINISTRADOR 
```
arch-chroot /mnt
```
#### 7. CONFIGURANDO LINGUAGEM
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
#### 8. CONFIGURANDO O FUSO HORÁRIO
```
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
```
```
hwclock --systohc
```

#### 9. CONFIGURANDO A REDE
```
echo NOMEDAMAQUINA > /etc/hostname
```
```
nano /etc/hosts
```
```

127.0.1.1 NOMEDAMAQUINA.localdomain NOMEDAMAQUINA
```
#### 10. CONFIGURANDO O RAID
```
nano /etc/mkinitcpio.conf
```
```
Edit the HOOKS line to include mdadm_udev right before the filesystems entry
```
```
mkinitcpio -p linux
```

#### 11. CONFIGURANDO A INTERNET
```
pacman -S wireless_tools networkmanager
```
```
systemctl enable NetworkManager
```
#### 12. COLOCANDO SENHA PARA O ADMINISTRADOR
```
passwd
```
#### ADICIONANDO NOVO USUÁRIO
```
useradd -m -g users -G storage,power,wheel,audio,video -s /bin/bash NOVOUSUARIO
passwd NOVOUSUARIO
```
#### PACOTES 32 bits pacman
```
nano /etc/pacman.conf
```
Descomentar
```
[multilib]
```
```
pacman -Sy
```

#### HABILITANDO SUDO
```
nano /etc/sudoers
```
```
seuusuário   ALL=(ALL) ALL
```
#### INSTALL AND CONFIGURE BOOTLOADER
```
pacman -S grub efibootmgr
```
```
mkdir /boot/efi
```
```
mount /dev/sda1 /boot/efi
```
```
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --recheck
```
```
grub-mkconfig -o /boot/grub/grub.cfg
```

#### DESMONTE AS PARTIÇÕES E REINICIE
```
exit
```
```
umount -R /mnt
```
```
reboot
```
