# Arch Linux - Base

#### 1 - PERPARANDO O DISCO
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
#### 2 - CONFIGURANDO O FORMATO DAS PARTIÇÕES

Transformando as Partições
```
mkfs.fat -F32 /dev/sd[]1
```
```
mkfs.ext4 /dev/sd[]2
```
#### 3 - MONTANDO DIRETORIO RAIZ
```
mount /dev/sd[]2 /mnt
```
#### 4 - CRIANDO PASTAS DE BOOT
```
mkdir /mnt/boot
```
```
mkdir /mnt/boot/efi
```
#### 5 - MONTANDO DIRETORIO DO BOOT
```
mount /dev/sd[]1 /mnt/boot/efi
```
#### 6. INSTALANDO ARQUIVOS BÁSICOS
```
pacstrap /mnt base base-devel git linux-zen linux-firmware nano amd-ucode
```
#### 7. CONFIGURANDO FSTAB  
```
genfstab -U -p /mnt >> /mnt/etc/fstab
```
#### 8. ENTRADO NO SISTEMA COMO ADMINISTRADOR 
```
arch-chroot /mnt
```
#### 9. HABILITANDO PACOTES 32bits
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
#### 10. USANDO ESSE REPOSITÓRIO
```
cd /tmp
```
```
git clone https://github.com/RouZERO/ArchOS/
```
```
cd ArchOS
```
```
chmod +x ./00-base.sh
```
```
 ./00-base.sh
```
