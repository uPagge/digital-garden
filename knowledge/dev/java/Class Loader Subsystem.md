---
aliases: 
tags:
  - зрелость/🌱
date: "[[2023-11-06]]"
zero-link:
  - "[[00 Java разработка]]"
parents:
  - "[[Архитектура JVM]]"
linked:
---
В JVM есть Class Loader Subsystem, здесь хранится информация о классах. Есть различные Class Loaders.

Сборка мусора здесь не производится. Если вы создаете "на лету" много классов, то можете упасть с OutOfMemoryException.

Берет скомпилированные Class Files.
