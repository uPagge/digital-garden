---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-01-28
zero-link:
  - "[[../garden/ru/meta/zero/00 Разработка]]"
parents: 
linked: 
---
Позволяет подать простую нагрузку на сервер и получить статистику.

Установить
```shell
sudo apt install apache2-utils
```

30 запросов в 10 потоков с KeepAlive GET-метод
```
ab -n 30 -c 10 -k -m GET https://ya.ru
```