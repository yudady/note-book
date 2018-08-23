# myPayCenter server mnt



```
/etc/rc.d/rc.local

mount -t nfs 192.168.0.1:/logs /mnt/nfs/var/rd2
mount -t nfs 127.0.0.1:/logs /mnt/nfs/var/rd3
/mnt/nfs/var/mypaycenter

移出
umount /mnt/nfs/var/rd2



mkdir -p /mnt/nfs/var/rd2
mkdir -p /mnt/nfs/var/rd3
mkdir -p /mnt/nfs/var/rd3-1
mkdir -p /mnt/nfs/var/rd3-2
mkdir -p /mnt/nfs/var/mypaycenter
mkdir -p /mnt/nfs/var/notify


mount -t nfs 104.199.252.56:/logs /mnt/nfs/var/rd2
mount -t nfs 104.199.181.204:/logs /mnt/nfs/var/rd3
mount -t nfs 35.201.187.129:/logs /mnt/nfs/var/rd3-1
mount -t nfs 35.229.168.10:/logs /mnt/nfs/var/rd3-2
mount -t nfs 35.189.177.41:/logs /mnt/nfs/var/mypaycenter
mount -t nfs 35.185.137.164:/logs /mnt/nfs/var/notify



```