---
aliases:
  - dive
tags:
  - зрелость/🌱
date:
  - - 2024-03-20
zero-link:
  - "[[00 Docker]]"
parents: 
linked:
---
Dive позволяет показать отличияслоёв друг от друга: какиефайлы добавлены, какие изменены, какие удалены.

Полезным параметром является `Potential wasted space`, который показывает на какое количество мегабайт можно сжать образ, если поправить [Dockerfile](Dockerfile.md).
![](Dockerfile.md#^a070de)


Пример работы:
```bash
dive upagge/spring-boot-docker:dockerfile
```

![](Pasted%20image%2020240320134340.png)