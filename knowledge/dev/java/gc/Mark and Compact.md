---
aliases: 
tags:
  - зрелость/🌱
date: "[[2023-11-07]]"
zero-link:
  - "[[../../../../garden/ru/meta/zero/00 Java разработка]]"
parents:
  - "[[../../../../garden/ru/dev/java/gc/Garbage Collector]]"
linked:
  - "[[Mark and Sweep]]"
---
Это модификация алгоритма "[Mark and Sweep](Mark%20and%20Sweep.md)". После отметки всех доступных объектов, этот алгоритм перемещает эти объекты, чтобы они были сгруппированы вместе, освобождая непрерывные блоки памяти.

![](Pasted%20image%2020231106130507.png)