---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-04-03
zero-link:
  - "[[00 Nginx]]"
parents: 
linked:
---
Внутри блока `http` определите блок `upstream`, где вы перечислите серверы, между которыми будет распределяться нагрузка. Например:

```
upstream myapp {
	server server1.example.com;
	server server2.example.com;
	server server3.example.com;
}
```

Внутри блока `server` настройте `location`, чтобы он перенаправлял запросы к вашему блоку `upstream`. Например:

```
server {
    listen 80;

    location / {
        proxy_pass http://myapp;
    }
}
```

**Выбор метода балансировки**: nginx поддерживает несколько методов балансировки, включая round-robin (по умолчанию), least-connected и ip-hash. Вы можете выбрать метод, добавив соответствующую директиву в блок `upstream`. Например, для использования метода least-connected добавьте `least_conn;` в ваш блок `upstream`