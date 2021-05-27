# Arch Linux

#### 1. PERPARANDO O DISCO
```
lsblk
```
```
cfdisk /dev/sd[]
```
Escolher GPT Seguir Tabela Abaixo
```
EFI        = sd[]1      = 512M
SWAP       = sd[]2      = 2G
SISTEMA    = sd[]3      = Restante
```
#### 2. CONFIGURANDO O FORMATO DAS PARTIÇÕES

Transformando as Partições
```
mkfs.fat -F32 /dev/sd[]1
```
```
mkswap  /dev/sd[]2
```
```
swapon /dev/sd[]2
```
```
mkfs.btrfs /dev/sd[]3
```
```
mount /dev/sd[]3 /mnt
```
#### Criando os subvolumes BTRFS

```
$ btrfs su cr /mnt/@
```
```
$ btrfs su cr /mnt/@home
```
```
$ btrfs su cr /mnt/@snapshots
```
```
$ btrfs su cr /mnt/@var_log
```
```
$ umount /mnt
```
#### Montando diretórios

```
$ mount -o noatime,compress=lzo,space_cache,subvol=@ /dev/sd[]3 /mnt
```
```
$ mkdir -p /mnt/{boot,home,.snapshots}
```
```
$ mount -o noatime,compress=lzo,space_cache=v2,subvol=@home /dev/sd[]3 /mnt/home
```
```
$ mount -o noatime,compress=lzo,space_cache=v2,subvol=@snapshots /dev/sd[]3 /mnt/.snapshots
```
```
$ mount -o noatime,compress=lzo,space_cache=v2,subvol=@var_log /dev/sd[]3 /mnt/var/log
```
```
$ moount /dev/sd[]1 /mnt/boot
```
#### 3. INSTALANDO ARQUIVOS BÁSICOS
```
pacstrap /mnt base linux linux-headers linux-firmware snapper nano amd-ucode
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
#### 7. GIT nesse Repo
```
cd tmp
```
```
git clone https://github.com/RouZERO/ArchOS/
```
```
cd ArchOS
```
```
chmod +x ./install_uefi.sh
```
```
 ./install_uefi.sh
```
#### 10. CONFIGURANDO O MKINITCPIO

```
nano /etc/mkinitcpio.conf
```
```
Adicionar btrfs no modulos
```
```
mkinitcpio -p linux
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
#### Criando senhas

Criar senha root
```
passwd
```
Criar senha Usuário

```
passws [Usuário]
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
```
#### USANDO DO AUR

Ananicy - is Another auto nice daemon, with community rules support
https://aur.archlinux.org/packages/ananicy-git

Automatically setup swap on zram
https://aur.archlinux.org/packages/zramd/
```
