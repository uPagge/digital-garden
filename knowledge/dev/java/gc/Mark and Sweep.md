---
aliases:
  - Mark And Sweep
tags:
  - зрелость/🌱
date: "[[2023-11-06]]"
zero-link:
  - "[[../../../../garden/ru/meta/zero/00 Java разработка]]"
parents:
  - "[[../../../../garden/ru/dev/java/gc/Garbage Collector]]"
linked:
  - "[[Mark and Compact]]"
---
В случае Mark and Sweep, в отличии от [Copy Collector](Copy%20Collector.md), мы не перемещаем живые объекты. Просто отмечаем мертвые объекты доступными для аллокации новых объектов.

![](Pasted%20image%2020231106130507.png)
