#### 2. CONFIGURANDO O FORMATO DAS PARTIÇÕES

Transformando as Partições
```
mkfs.fat -F32 /dev/sd[]1
```
```
mkfs.btrfs /dev/sd[]2
```
```
mount /dev/sd[]2 /mnt
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
$ mount -o noatime,compress=lzo,space_cache,subvol=@ /dev/sd[]2 /mnt
```
```
$ mkdir -p /mnt/{boot,home,.snapshots}
```
```
$ mount -o noatime,compress=lzo,space_cache=v2,subvol=@home /dev/sd[]2 /mnt/home
```
```
$ mount -o noatime,compress=lzo,space_cache=v2,subvol=@snapshots /dev/sd[]2 /mnt/.snapshots
```
```
$ mount -o noatime,compress=lzo,space_cache=v2,subvol=@var_log /dev/sd[]2 /mnt/var/log
```
```
$ moount /dev/sd[]1 /mnt/boot
```
#### 3. INSTALANDO ARQUIVOS BÁSICOS
```
pacstrap /mnt base linux-lts linux-lts-headers linux-firmware snapper nano amd-ucode
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
