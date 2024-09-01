---
aliases: 
tags:
  - зрелость/🌱
date: "[[2023-11-06]]"
zero-link:
  - "[[../../../../garden/ru/meta/zero/00 Java разработка]]"
parents:
  - "[[../../../../garden/ru/dev/java/gc/Garbage Collector]]"
linked:
  - "[[Serial GC]]"
  - "[[Concurrent Mark Sweep|Concurrent Mark Sweep]]"
---
Работает по тем же принципам, что и сборщик мусора [Scavenge](Serial%20GC.md), используя [Generational Collection](Generational%20Collection.md). Для молодого поколения используется [Copy Collector](Copy%20Collector.md), а для старого [Mark and Compact](Mark%20and%20Compact.md).

Отличие Parallel коллектора от [Serial](Serial%20GC.md) заключается в том, что он использует подход [Parallel Collection](Parallel%20Collection.md), то есть работает в несколько потоков во время [StopTheWorld](StopTheWorld.md).

Зеленые линии это потоки приложения, красные это потоки GC.

![](Pasted%20image%2020231107215457.png)

Также у этого коллектора есть возможность автоматической подстройки под требуемые параметры производительности и меньшие паузы на время сборок.

**Минусы:**
- Активное использование [StopTheWorld](StopTheWorld.md). Однако паузы уменьшаются за счет [Parallel Collection](Parallel%20Collection.md).

**Плюсы:**
- Малое потребление CPU на фоновую сборку мусора: 1%.
- Параллельная сборка молодого и старого поколения.
- Линейная [аллокация](Аллокация.md) объектов. Благодаря использованию [Mark and Compact](Mark%20and%20Compact.md).

**Где использовать:**
- Приложения для которых важна производительность.
- Железо с несколькими ядрами.

**Как включить:**
- `-XX:+UseParallelGC`
- `-XX:+UseParallelOldGC`
