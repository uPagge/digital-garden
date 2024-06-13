---
aliases: 
tags:
  - зрелость/🌱
date: [[2024-01-09]]
zero-link: 
parents: 
linked:
---
```
pvs
```

```
vgs
```

```
lvs
```

## Logical Volume
### Удаление LV
Размонтировать папку от LV.

```shell
umount /folder/path
```

Откройте `/etc/fstab` и убедитесь, что нет записи для автоматического монтирования файловой системы. Если есть, удалите запись, сохраните изменения и закройте файл.

```
nano /etc/fstab
```

Также нужно убедиться, что к данной папке не присоединен docker volume.

После чего можно удалить LV
```shell
lvchange -an /dev/vgname/lvmname
lvremove /dev/vgname/lvmname
```
## Полезные материалы
- [Работа с LVM. Управление дисковыми носителями с помощью Logical Volume Manager](https://www.dmosk.ru/instruktions.php?object=lvm&ysclid=lr6peozovr651519872#delete)