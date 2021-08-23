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
SISTEMA    = sd[]2      = Restante
```
#### 2. CONFIGURANDO O FORMATO DAS PARTIÇÕES

Transformando as Partições
```
mkfs.fat -F32 /dev/sd[]1
```
```
mkfs.btrfs /dev/sd[]3
```
```
mount /dev/sd[]3 /mnt
```
```
#### 3. INSTALANDO ARQUIVOS BÁSICOS
```
pacstrap /mnt base linux-firmware nano amd-ucode
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
