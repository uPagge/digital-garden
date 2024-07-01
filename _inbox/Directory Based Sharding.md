---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-06-30
zero-link:
  - "[[00 Алгоритмы]]"
parents:
  - "[[Шардирование в БД]]"
linked:
  - "[[Key Based Sharding]]"
---
![](Pasted%20image%2020240630110840.png)

Похож на [Key Based Sharding](Key%20Based%20Sharding.md). Можно использовать когда Shard Key имеет мало значений.

**Плюсы:**
- Более контролируемый способ распределения по шардам.

**Минусы:**
- Обновление
- SPOF