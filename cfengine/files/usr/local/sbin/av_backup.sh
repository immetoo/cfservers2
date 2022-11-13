#!/bin/bash
mount.cifs //172.16.24.217/m4n /mnt/mohwts0_m4n -o username=backup_av,password=Achterop_av uid=root gid=users fmask=664 dmask=775
mount.cifs //172.16.24.217/AccountView8 /mnt/mohwts0_accountview  -o username=backup_av,password=Achterop_av uid=root gid=users fmask=664 dmask=775


rsync -ra /mnt/mohwts0_accountview/ /data/administration/mohwts0_accountview
rsync -ra /mnt/mohwts0_m4n/ /data/administration/mohwts0_m4n

umount /mnt/mohwts0_m4n
umount /mnt/mohwts0_accountview
