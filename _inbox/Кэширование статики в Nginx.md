---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-04-07
zero-link:
  - "[[00 Nginx]]"
parents:
  - "[[Кэширование]]"
linked:
  - "[[Кэширование на стороне Nginx]]"
  - "[[Кэширование на стороне браузера]]"
link: https://struchkov.dev/blog/ru/nginx-optimization/#%D0%BA%D1%8D%D1%88%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D0%BD%D0%B0-%D1%81%D1%82%D0%BE%D1%80%D0%BE%D0%BD%D0%B5-%D0%BA%D0%BB%D0%B8%D0%B5%D0%BD%D1%82%D0%B0
---
В главный конфигурационный файл Nginx можно добавить следующие директивы, чтобы указать серверу кэшировать статические файлы веб-страницы для более быстрого доступа к ним.

```nginx
server {
  ...

    # Media
    location ~* \.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|mp4|ogg|ogv|webm|htc|css|js)$ {
        expires 365d;
        access log off;
        add header Cache-Control public
    }

  ...
}
```

В данном примере мы кэшируем медиа-файлы, такие как jpeg, gif, png на 30 дней. А такие файлы как css, js на 365 дней.

![Fingerprint файлов](Fingerprint%20файлов.md)