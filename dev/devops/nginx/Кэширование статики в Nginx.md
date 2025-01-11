---
aliases: 
tags:
  - maturity/🌱
date: 2024-04-07
---
Чтобы настроить кэширование статического контента, можно добавить следующие директивы в основной конфигурационный файл Nginx:

```nginx
server {
  ...

    # Media
    location ~* \.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|mp4|ogg|ogv|webm|htc)$ {
        expires 30d;
    }

    # CSS and Js
    location ~* \.(css|js|woff2)$ {
        expires 365d;
    }

  ...
}
```

В этом примере медиа-файлы, такие как изображения и видео, будут кэшироваться на 30 дней, а файлы CSS, JS и шрифты — на 365 дней.
***
## Мета информация
**Область**:: [[../../../meta/zero/00 Nginx|00 Nginx]]
**Родитель**:: [[../../architecture/highload/Кэширование на стороне браузера|Кэширование на стороне браузера]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-04-07]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
