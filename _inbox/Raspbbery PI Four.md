---
aliases: 
tags:
  - зрелость/🌱
date: [[2024-08-22]]
zero-link: 
parents: 
linked:
---
```bash
root@home:~/storage# lsblk
NAME                        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda                           8:0    0 232.9G  0 disk 
├─sda1                        8:1    0   256M  0 part /boot
└─sda2                        8:2    0 232.6G  0 part /
sdb                           8:16   0   1.8T  0 disk 
└─sdb1                        8:17   0   1.8T  0 part 
  ├─vgdata-root_rmeta_1     254:5    0     4M  0 lvm  
  │ └─vgdata-root           254:8    0   100G  0 lvm  /root/storage
  └─vgdata-root_rimage_1    254:7    0   100G  0 lvm  
    └─vgdata-root           254:8    0   100G  0 lvm  /root/storage
sdc                           8:32   0   1.8T  0 disk 
└─sdc1                        8:33   0   1.8T  0 part 
  ├─vgdata-root_rmeta_0     254:0    0     4M  0 lvm  
  │ └─vgdata-root           254:8    0   100G  0 lvm  /root/storage
  └─vgdata-root_rimage_0    254:2    0   100G  0 lvm  
    └─vgdata-root           254:8    0   100G  0 lvm  /root/storage
sdd                           8:48   0   3.6T  0 disk 
└─sdd1                        8:49   0   3.6T  0 part 
  ├─vgmedia-backup_rmeta_0  254:1    0     4M  0 lvm  
  │ └─vgmedia-backup        254:9    0   450G  0 lvm  /root/storage/samba/upagge/backup
  ├─vgmedia-backup_rimage_0 254:3    0   450G  0 lvm  
  │ └─vgmedia-backup        254:9    0   450G  0 lvm  /root/storage/samba/upagge/backup
  ├─vgmedia-video_rmeta_0   254:10   0     4M  0 lvm  
  │ └─vgmedia-video         254:14   0   400G  0 lvm  /root/storage/samba/share/video
  ├─vgmedia-video_rimage_0  254:11   0   400G  0 lvm  
  │ └─vgmedia-video         254:14   0   400G  0 lvm  /root/storage/samba/share/video
  ├─vgmedia-library         254:15   0   523G  0 lvm  /root/storage/samba/share/library
  ├─vgmedia-media_rmeta_0   254:16   0     4M  0 lvm  
  │ └─vgmedia-media         254:20   0   400G  0 lvm  /root/storage/samba/upagge/media
  ├─vgmedia-media_rimage_0  254:17   0   400G  0 lvm  
  │ └─vgmedia-media         254:20   0   400G  0 lvm  /root/storage/samba/upagge/media
  └─vgmedia-torrent--fast   254:22   0   310G  0 lvm  /root/storage/samba/share/torrent
sde                           8:64   0   4.5T  0 disk 
└─sde1                        8:65   0   4.5T  0 part 
  ├─vgmedia-backup_rmeta_1  254:4    0     4M  0 lvm  
  │ └─vgmedia-backup        254:9    0   450G  0 lvm  /root/storage/samba/upagge/backup
  ├─vgmedia-backup_rimage_1 254:6    0   450G  0 lvm  
  │ └─vgmedia-backup        254:9    0   450G  0 lvm  /root/storage/samba/upagge/backup
  ├─vgmedia-video_rmeta_1   254:12   0     4M  0 lvm  
  │ └─vgmedia-video         254:14   0   400G  0 lvm  /root/storage/samba/share/video
  ├─vgmedia-video_rimage_1  254:13   0   400G  0 lvm  
  │ └─vgmedia-video         254:14   0   400G  0 lvm  /root/storage/samba/share/video
  ├─vgmedia-media_rmeta_1   254:18   0     4M  0 lvm  
  │ └─vgmedia-media         254:20   0   400G  0 lvm  /root/storage/samba/upagge/media
  ├─vgmedia-media_rimage_1  254:19   0   400G  0 lvm  
  │ └─vgmedia-media         254:20   0   400G  0 lvm  /root/storage/samba/upagge/media
  ├─vgmedia-video--archive  254:21   0   500G  0 lvm  /root/storage/samba/share/video/archive
  └─vgmedia-torrent--fast   254:22   0   310G  0 lvm  /root/storage/samba/share/torrent
```