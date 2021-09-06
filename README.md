# Arch Linux - Base

#### 1 - PERPARANDO O DISCO
Para checar o nome dos discos.
```
lsblk
```
Iniciando as configurações do disco.
```
cfdisk /dev/sd[]
```
Escolher GPT Seguir Tabela Abaixo
```
EFI        = sd[]1      = 512M
SISTEMA    = sd[]2      = Restante
```
Configurando o Formato das Partições.

FAT32 Para Partição do BOOT
```
mkfs.fat -F32 /dev/sd[]1
```
EXT4 Para Partição Raiz
```
mkfs.ext4 /dev/sd[]2
```
#### 2 - MONTANDO DIRETORIO RAIZ
```
mount /dev/sd[]2 /mnt
```
#### 3 - CRIANDO PASTAS DE BOOT
```
mkdir /mnt/boot
```
```
mkdir /mnt/boot/efi
```
Montando Diretorio do Boot.
```
mount /dev/sd[]1 /mnt/boot/efi
```
#### 4. INSTALANDO ARQUIVOS BÁSICOS
```
pacstrap /mnt base base-devel git linux-zen linux-firmware nano amd-ucode
```
#### 5. CONFIGURANDO FSTAB  
```
genfstab -U -p /mnt >> /mnt/etc/fstab
```
#### 6. ENTRADO NO SISTEMA COMO ADMINISTRADOR 
```
arch-chroot /mnt
```
#### 7. HABILITANDO PACOTES 32bits
```
nano /etc/pacman.conf
```
Descomentar
```
[multilib]
Include = /etc/pacman.d/mirrorlist
```
#### 8. USANDO ESSE REPOSITÓRIO
Entrando na pasta tmp.
```
cd /tmp
```
Baixando o repertório.
```
git clone https://github.com/RouZERO/ArchOS/
```
Entrando na pasta dos arquivos baixandos.
```
cd /ArchOS
```
Alterando as permissões dos arquivos.
```
chmod +x ./00-base.sh
```
Mudar a senha e nome do root e do Usuário.
```
nano ./00-base.sh
```
Executando o Script
```
 ./00-base.sh
```
