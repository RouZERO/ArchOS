# Arch Linux UEFI + RAID

#### 1. PERPARANDO O DISCO
```
lsblk
```
```
cfdisk /dev/sda
```
Escolher GPT Seguir Tabela Abaixo
```
EFI        = sda1      = 512M
SWAP       = sda2      = 2G
SISTEMA    = sda3      = Restante
```
#### 2. CONFIGURANDO O FORMATO DAS PARTIÇÕES

Transformando as Partições
```
mkfs.fat -F32 /dev/sda1
```
```
mkswap  /dev/sda2
```
```
swapon /dev/sda2
```
```
mkfs.btrfs /dev/sda3
```
```
mount /dev/sda3 /mnt
```
```
$ btrfs su cr /mnt/@
```
```
$ btrfs su cr /mnt/@home
```
```
$ btrfs su cr /mnt/@var
```
```
$ btrfs su cr /mnt/@snapshots
```
```
$ umount /mnt
```
```
$ mount -o noatime,compress=lzo,space_cache,subvol=@ /dev/sda3 /mnt
```
```
$ mkdir -p /mnt/{boot/efi,home,var,.snapshots}
```
```
$ mount -o noatime,compress=lzo,space_cache=v2,subvol=@home /dev/sda3 $ /mnt/home
```
```
$ mount -o noatime,compress=lzo,space_cache=v2,subvol=@var /dev/sda3 /mnt/var
```
```
$ mount -o noatime,compress=lzo,space_cache=v2,subvol=@snapshots /dev/sda3 /mnt/.snapshots
```
```
$ moount /dev/sda1 /mnt/boot
```
#### 3. INSTALANDO ARQUIVOS BÁSICOS
```
pacstrap /mnt base linux linux-headers linux-firmware snapper nano
```
# CONFIGURANDO O SISTEMA

#### 4. CONFIGURANDO FSTAB  
```
genfstab -U -p /mnt >> /mnt/etc/fstab
```
#### 5. ENTRADO NO SISTEMA COMO ADMINISTRADOR 
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
#### 8. CONFIGURANDO O FUSO HORÁRIO
```
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
```
```
hwclock --systohc
```

#### 9. CONFIGURANDO A REDE
```
echo ArchLinux > /etc/hostname
```
```
nano /etc/hosts
```
```
127.0.0.1	localhost
::1		localhost
127.0.1.1	ArchLinux.localdomain	ArchLinux
```
```
#### 10. CONFIGURANDO O MKINITCPIO

```
```
nano /etc/mkinitcpio.conf
```

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
#### 13. ADICIONANDO NOVO USUÁRIO
```
useradd -m -g users -G storage,power,wheel,audio,video -s /bin/bash NOVOUSUARIO
passwd NOVOUSUARIO
```
#### 14. PACOTES 32bits
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

#### 15. HABILITANDO SUDO
```
nano /etc/sudoers
```
```
seuusuário   ALL=(ALL) ALL
```
#### 16. CONFIGURANDO OS ARQUIVOS DE BOOT
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
