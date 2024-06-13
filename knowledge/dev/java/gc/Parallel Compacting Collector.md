---
aliases: 
tags:
  - зрелость/🌱
date: "[[2023-11-06]]"
zero-link:
  - "[[00 Java разработка]]"
parents:
  - "[[Garbage Collector]]"
linked:
---
В отличие от [Parallel GC](Parallel%20GC.md) ([Generational Collection](Generational%20Collection.md), [Copy Collector](Copy%20Collector.md), [Mark and Compact](Mark%20and%20Compact.md), [Parallel Collection](Parallel%20Collection.md)) этот сборщик уже умеет работать в параллельном режиме как с областью Young Generation, так и с областью Old Generation.

Память Old Generation разбивается на участки. Сборщик каждый участок в отдельном потоке начинает чистить. Соответственно чистка происходит быстрее, так как это все работает параллельно.

Но даже при таком подходе у нас все равно могут быть большие [StopTheWorld](StopTheWorld.md) паузы между чистками.