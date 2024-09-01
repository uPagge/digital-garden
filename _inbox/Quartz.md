---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-09-01
zero-link: 
parents: 
linked: 
link: https://quartz.jzhao.xyz/
---
Утилита, которая позволяет генерировать статические сайты, аналогично Hugo.

Собрать статический сайт с использованием docker image. Файлы статей должны лежать в папке `content`, а результат (сайт) будет лежать в папке `public`.
```shell
docker run -v ./content:/usr/src/app/content -v ./public:/usr/src/app/public --name quartz --rm docker.struchkov.dev/quartz:latest build
```