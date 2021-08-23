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
