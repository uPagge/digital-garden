---
aliases:
  - Балансировка запросов на Nginx
tags:
  - maturity/🌱
date: 2024-10-30
---
Блок `upstream` используется для указания списка серверов, между которыми nginx будет распределять входящие запросы, тем самым обеспечивая [[../../../../../_inbox/Балансировка нагрузки|балансировку нагрузки]]. В блоке `upstream` перечисляются серверы, между которыми будет распределяться нагрузка.

```nginx
upstream myapp {
	server server1.example.com;
	server server2.example.com;
	server server3.example.com;
}
```

Затем настройте блок `server`, чтобы перенаправлять запросы к вашему блоку `upstream`. В блоке `server` используйте директиву `proxy_pass` внутри `location`, как показано ниже:

```nginx
server {
    listen 80;

    location / {
        proxy_pass http://myapp;
    }
}
```
## Метод балансировки
Nginx поддерживает несколько методов балансировки нагрузки, включая round-robin (по умолчанию), least-connected и ip-hash. Вы можете выбрать нужный метод, добавив соответствующую директиву в блок `upstream`.

```nginx
upstream myapp {
    least_conn;
    server server1.example.com;
    server server2.example.com;
    server server3.example.com;
}
```
## Резервные сервера
Чтобы повысить отказоустойчивость, можно добавить резервные серверы, к которым будут перенаправляться запросы, если основные серверы недоступны:

```nginx
upstream myapp {
    server server1.example.com;
    server server2.example.com;
    server server3.example.com;
    server backup.example.com backup;
}
```
***
## Мета информация
**Область**:: [[../../../meta/zero/00 Nginx|00 Nginx]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-10-30]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

