# Notes

This will hold all the changes done to the server directly.

## 2024-10-23

Increased the size available on the partition of the ubuntu server to use the 100% of the disk.

```bash
crgomo@x77 ~> sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv

  Size of logical volume ubuntu-vg/ubuntu-lv changed from 100.00 GiB (25600 extents) to <928.46 GiB (237685 extents).
  Logical volume ubuntu-vg/ubuntu-lv successfully resized.
crgomo@x77 ~> sudo vgdisplay ubuntu-vg

  --- Volume group ---
  VG Name               ubuntu-vg
  System ID
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  5
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                1
  Open LV               1
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               <928.46 GiB
  PE Size               4.00 MiB
  Total PE              237685
  Alloc PE / Size       237685 / <928.46 GiB
  Free  PE / Size       0 / 0
  VG UUID               CXkZIq-SUzh-0VRL-pnfR-9Z5l-PY8a-tr237V

crgomo@x77 ~> lsblk
NAME                      MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
sda                         8:0    0  16.4T  0 disk
└─md0                       9:0    0  49.1T  0 raid5 /mnt/raid
sdb                         8:16   0  16.4T  0 disk
└─md0                       9:0    0  49.1T  0 raid5 /mnt/raid
sdc                         8:32   0 931.5G  0 disk
└─sdc1                      8:33   0 931.5G  0 part  /mnt/1tb_drive
sdd                         8:48   0  16.4T  0 disk
└─md0                       9:0    0  49.1T  0 raid5 /mnt/raid
sde                         8:64   0  16.4T  0 disk
└─md0                       9:0    0  49.1T  0 raid5 /mnt/raid
nvme0n1                   259:0    0 931.5G  0 disk
├─nvme0n1p1               259:1    0     1G  0 part  /boot/efi
├─nvme0n1p2               259:2    0     2G  0 part  /boot
└─nvme0n1p3               259:3    0 928.5G  0 part
  └─ubuntu--vg-ubuntu--lv 252:0    0 928.5G  0 lvm   /
crgomo@x77 ~> df -h /
Filesystem                         Size  Used Avail Use% Mounted on
/dev/mapper/ubuntu--vg-ubuntu--lv   98G   90G  3.1G  97% /
crgomo@x77 ~> sudo resize2fs /dev/ubuntu-vg/ubuntu-lv
resize2fs 1.47.0 (5-Feb-2023)
Filesystem at /dev/ubuntu-vg/ubuntu-lv is mounted on /; on-line resizing required
old_desc_blocks = 13, new_desc_blocks = 117
The filesystem on /dev/ubuntu-vg/ubuntu-lv is now 243389440 (4k) blocks long.

crgomo@x77 ~> df -h /
Filesystem                         Size  Used Avail Use% Mounted on
/dev/mapper/ubuntu--vg-ubuntu--lv  914G   90G  786G  11% /
```

Chat: https://claude.ai/chat/532c8f6b-7126-419f-8857-f83fed9e91f3


