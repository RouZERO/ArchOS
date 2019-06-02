# ArchOS UEFI

#### 1. PERPARANDO O DISCO
```
fdisk -l
```
```
cfdisk /dev/sda
```
Escolher GPT Seguir Tabela Abaixo
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

#### 3. INSTALANDO ARQUIVOS BÁSICOS
```
pacstrap /mnt base base-devel
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
#### 6. CONFIGURANDO ARQUIVO DE SWAP
```
fallocate -l 4G /swapfile
```
```
chmod 600 /swapfile
```
```
mkswap /swapfile
```
```
swapon /swapfile
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
echo NOMEDAMAQUINA > /etc/hostname
```
```
nano /etc/hosts
```
```

echo -e ¨127.0.0.1 localhost.localdomain localhost \n::1 localhost.localdomain localhost \n127.0.1.1 NOMEDAMAQUINA.localdomain NOMEDAMAQUINA¨ > /etc/hosts
```
#### 10. CONFIGURANDO O RAID
Gerar mdadm.conf
```
mdadm --examine --scan > /etc/mdadm.conf
```
```
nano /etc/mkinitcpio.conf
```
```
Colocar em HOOKS o comando mdadm_udev antes do comando filesystems
Colocar em BINARIES o comando mdmon
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
