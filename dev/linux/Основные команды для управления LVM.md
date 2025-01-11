---
aliases: 
tags:
  - maturity/🌱
date: 2024-11-12
---
Эта заметка содержит основные команды для работы с LVM (Logical Volume Management) в Linux. Команды разделены на несколько категорий: физические тома, группы томов, логические тома, управление файловыми системами, создание снимков, а также конфигурация и обслуживание.
## Physical Volumes
- `pvcreate <device>` — инициализация физического тома для использования в LVM.
- `pvdisplay` — отображение информации о физических томах.
- `pvs` — вывод всех физических томов с краткой информацией. Объем доступного и используемого пространства.
- `pvscan` — сканирование всех дисков на наличие физических томов.
- `pvresize <device>` — изменение размера физического тома.
## Volume Groups
- `vgcreate <volume-group> <physical-volume>` — создание группы томов из одного или нескольких физических томов.
- `vgextend <volume-group> <physical-volume>` — добавление физического тома в существующую группу томов.
- `vgreduce <volume-group> <physical-volume>` — удаление физического тома из группы.
- `vgdisplay` — отображение информации о группах томов.
- `vgs` — вывод всех групп томов с краткой информацией.
- `vgscan` — сканирование всех дисков для обнаружения групп томов.
- `vgremove <volume-group>` — удаление группы томов (должна быть пустой).
- `vgrename <old-name> <new-name>` — переименование группы томов.
## Logical Volumes
- `lvcreate -L <size> -n <name> <volume-group>` — создание логического тома в группе.
- `lvextend -L <size> <logical-volume>` — увеличение размера логического тома.
- `lvreduce -L <size> <logical-volume>` — уменьшение размера логического тома.
- `lvresize -L <size> <logical-volume>` — изменение размера логического тома до заданного значения.
- `lvdisplay` — отображение информации о логических томах.
- `lvs` — вывод всех логических томов с краткой информацией.
- `lvscan` — сканирование всех дисков для обнаружения логических томов.
- `lvrename <volume-group> <old-name> <new-name>` — переименование логического тома.
### Удаление Logical Volume
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
### Управление файловыми системами на логических томах
- `mkfs.ext4 /dev/<volume-group>/<logical-volume>` — создание файловой системы ext4 на логическом томе.
- `mkfs.xfs /dev/<volume-group>/<logical-volume>` — создание файловой системы XFS на логическом томе.
- `mount /dev/<volume-group>/<logical-volume> /mnt` — монтирование логического тома в директорию.
- `umount /mnt` — размонтирование логического тома.
## 5. Снимки (Snapshots)
- `lvcreate -L <size> -s -n <snapshot-name> <lv>` — создание снимка логического тома.
- `lvremove <snapshot-name>` — удаление снимка.
- `lvconvert --merge <snapshot-name>` — объединение снимка с оригинальным логическим томом.
## 6. Конфигурация и обслуживание LVM
- `lvchange -a y <logical-volume>` — активация логического тома.
- `lvchange -a n <logical-volume>` — деактивация логического тома.
- `vgchange -a y <volume-group>` — активация группы томов.
- `vgchange -a n <volume-group>` — деактивация группы томов.
- `vgcfgbackup <volume-group>` — создание резервной копии метаданных группы томов.
- `vgcfgrestore <volume-group>` — восстановление метаданных группы томов из резервной копии.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Linux|00 Linux]]
**Родитель**:: [[Logical Volume Management|Logical Volume Management]]
**Источник**:: 
**Создана**:: [[2024-11-12]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

