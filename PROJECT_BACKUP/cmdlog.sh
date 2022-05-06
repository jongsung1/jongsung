#!/bin/bash

source /idea_backup/script/default/default_conf

echo "[BEGIN] 2021-08-18 오후 5:38:04"
echo -e "${GREEN}[root@d10587 ~]# fdisk -l /dev/sdb${RESET}"

echo "
Disk /dev/sdb: 48009.1 GB, 48009077325824 bytes, 93767729152 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
"
echo -e "${GREEN}[root@d10587 ~]# parted /dev/sdb${RESET}"
echo "GNU Parted 3.1
Using /dev/sdb
Welcome to GNU Parted! Type 'help' to view a list of commands."
echo -e "${GREEN}(parted) print${RESET}"
echo -e "Error: /dev/sdb: unrecognised disk label
Model: H/W RAID 50 (scsi)                                                 
Disk /dev/sdb: 48.0TB
Sector size (logical/physical): 512B/4096B
Partition Table: unknown
Disk Flags: 
${GREEN}(parted) mklabel gpt
(parted) print${RESET}
Model: H/W RAID 50 (scsi)
Disk /dev/sdb: 48.0TB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: 

Number  Start  End  Size  File system  Name  Flags

${GREEN}(parted) unit TB                                                          
(parted) mkpart idea_backup 0% 100%
(parted) print ${RESET}
Model: H/W RAID 50 (scsi)
Disk /dev/sdb: 48.0TB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name         Flags
 1      0.00TB  48.0TB  48.0TB               idea_backup

${GREEN}(parted) quit ${RESET}
Information: You may need to update /etc/fstab.

${GREEN}[root@d10587 ~]# fdisk -l /dev/sdb  ${RESET}

Disk /dev/sdb: 48009.1 GB, 48009077325824 bytes, 93767729152 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk label type: dos
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1  4294967295  2147483647+  ee  GPT
Partition 1 does not start on physical sector boundary.
${GREEN}[root@d10587 ~]# mkfs.xfs /dev/sdb1${RESET}
meta-data=/dev/sdb1              isize=256    agcount=44, agsize=268435455 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=0        finobt=0
data     =                       bsize=4096   blocks=11720965632, imaxpct=5
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=0
log      =internal log           bsize=4096   blocks=521728, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
${GREEN}[root@d10587 ~]# cd /
[root@d10587 /]# mkdir /icebackup2
[root@d10587 /]# mount /dev/sdb1 /icebackup2/
[root@d10587 /]# df -Th /icebackup2/${RESET}
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/sdb1      xfs    44T   34M   44T   1% /icebackup2

[END] 2021-08-18 오후 5:41:28
"
