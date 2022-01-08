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
#### Criando senhas

Criar senha root
```
passwd
```
Criar senha Usuário

```
passwsd [Usuário]
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


# Snapper 
I suggest setting snapper up after you have a working system.

Install the required packages for snapper and btrfs:
```
pacman -S snapper grub-btrfs
```
Check your btrfs subvolumes:
```
btrfs sub list /
```
They should look something like this:
```
ID 256 gen 810 top level 5 path @
ID 257 gen 781 top level 5 path @tmp
ID 258 gen 810 top level 5 path @log
ID 259 gen 804 top level 5 path @pkg
ID 260 gen 10 top level 5 path @snapshots
ID 264 gen 34 top level 256 path var/lib/portables
ID 265 gen 35 top level 256 path var/lib/machines
```
Create a snapper config for root:
```
snapper -c root create-config /
```
Check your btrfs subvolumes:
```
btrfs sub list /
```
Now you have a new subvolume for snapshot but there is a problem because the subvolume is below the root subvolume, if you rollback with this configuration /.snapshots will disappear because it depends on the root subvolume.
```
ID 256 gen 810 top level 5 path @
ID 257 gen 781 top level 5 path @tmp
ID 258 gen 810 top level 5 path @log
ID 259 gen 804 top level 5 path @pkg
ID 260 gen 10 top level 5 path @snapshots
ID 264 gen 34 top level 256 path var/lib/portables
ID 265 gen 35 top level 256 path var/lib/machines
ID 267 gen 87 top level 257 path /.snapshots
```
To fix it you have to delete the /.snapshots subvolume and make the /.snapshots directory again
```
btrfs sub del /.snapshots/
mkdir /.snapshots
```
Now you have to mount the /.snapshots directory in /etc/fstab
```
nano -w /etc/fstab
```
Add this line to /etc/fstab(remember to put your drive instead of the example in the beginning)
```
/dev/your_drive2 	/.snapshots  		btrfs     	rw,relatime,compress=lzo,ssd,space_cache=v2,subvol=@snapshots	0 0
```
Mount /.snapshots:
```
mount /.snapshots/
```
Check if you have done it correctly with df -Th, it should look something like this:
```
df -Th 
Filesystem     Type      Size  Used Avail Use% Mounted on
dev            devtmpfs  3.9G     0  3.9G   0% /dev
run            tmpfs     3.9G  1.5M  3.9G   1% /run
/dev/nvme0n1p2 btrfs      32G  7.4G   25G  24% /
tmpfs          tmpfs     3.9G   70M  3.8G   2% /dev/shm
tmpfs          tmpfs     4.0M     0  4.0M   0% /sys/fs/cgroup
/dev/nvme0n1p2 btrfs      32G  7.4G   25G  24% /btrfs
/dev/nvme0n1p2 btrfs      32G  7.4G   25G  24% /tmp
/dev/nvme0n1p2 btrfs      32G  7.4G   25G  24% /var/cache/pacman/pkg
/dev/nvme0n1p2 btrfs      32G  7.4G   25G  24% /var/log
/dev/nvme0n1p1 vfat      511M  564K  511M   1% /boot/efi
/dev/nvme0n1p3 xfs       921G  144G  778G  16% /home
tmpfs          tmpfs     784M   72K  784M   1% /run/user/1000
/dev/nvme0n1p2 btrfs      32G  7.4G   25G  24% /.snapshots
```
To enable that snapshots show up in GRUB
Enable grub-btrfs.path to refresh the shapshot list
```
systemctl enable grub-btrfs.path
```
And enable the snapshot list in the GRUB config

```
nano /etc/default/grub
```
Set this option:
```
GRUB_DISABLE_RECOVERY=false
```
You can exit, now you only have to regenerate the config
```
grub-mkconfig -o /boot/grub/grub.cfg
```
# Snapper config
To enable pre-post pacman snapshots install snap-pac
```
pacman -S snap-pac
```
To enable boot snapshots enable snapper-boot.timer
```
systemctl enable snapper-boot.timer
```
You can also enable hourly snapshots and a limit to the number of shanpshots you want or other options in the snapper config
```
nano /etc/snapper/configs/root
```
To enable hourly snapshots and snapshot cleanup, you have to enable cronie
```
pacman -S --needed cronie
systemctl enable cron.service
