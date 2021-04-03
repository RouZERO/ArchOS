# Arch Linux

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
$ umount /mnt
```
#### Montando diretórios

```
$ mount -o noatime,compress=lzo,space_cache,subvol=@ /dev/sda3 /mnt
```
```
$ mkdir -p /mnt/{boot,home,.snapshots}
```
```
$ mount -o noatime,compress=lzo,space_cache=v2,subvol=@home /dev/sda3 $ /mnt/home
```
```
$ mount -o noatime,compress=lzo,space_cache=v2,subvol=@snapshots /dev/sda3 /mnt/.snapshots
```
```
$ moount /dev/sda1 /mnt/boot
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
