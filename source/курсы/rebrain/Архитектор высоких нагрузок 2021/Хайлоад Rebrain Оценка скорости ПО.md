---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-01-25
zero-link:
  - "[[00 HighLoad]]"
parents: 
linked: []
---
## Тюнинг ядра
Команда позволит вывести конфигурацию ядра

```
systemctl net.core
```

Стоит обратить внимание на следующие значения
```
net.core.net.dev_max_backlog = 65535
net.core.somaxconn = 20000
```

- `net.core.somaxconn` максимальное количество соединений с сокетом
- `net.core.net.dev_max_backlog` буфер ожидания

Для редактирования используется команда

```
sudo nano /etc/sysctl.conf
```

Также можно дополнительно защититься от [DDOS](DDOS.md). Данные настройки запретят использовать ICMP
```
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.secure_redtrects = 0
net.ipv4.conf.all.send_redirects = 0
```

Хз что это значит, но можно обратить внимание
```
net.ipv4.tcp_max_orphans = 65536
net.ipv4.tcp_max_sync_backlog = 4096
```

## Тюнинг БД
Для PostgreSQL есть какая-то утилита (PostgreSQL Tunner), которая позволяет провести сканирование СуБД на предмет возможностей для оптимизаций. Перед запуском скрипта желательно погонять БД 24 часа под нагрузкой, чтобы СуБД записала диагностические данные, которые и будут анализироваться.
## Полезные ссылки
- [Настройка Linux для высоконагруженных проектов и защиты от DDoS](https://romantelychko.com/blog/1300/)