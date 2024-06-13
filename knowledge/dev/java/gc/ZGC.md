---
aliases: 
tags:
  - зрелость/🌱
date: "[[2023-11-08]]"
zero-link:
  - "[[00 Java разработка]]"
parents:
  - "[[Garbage Collector]]"
linked:
  - "[[Shenandoah GC]]"
---
- Использует концепцию виртуальной памяти
- Поддерживается с [Java 15](Java%2015.md)

Этапы сборки
- Mark
	- Pause Mark Start
	- Concurrent Map
	- Pause Mark End
- Relocate
	- Concurrent prepare for Relocate
	- Pause Relocate Start
	- Concurrent Relocate
	- Concurrent Remap

**Плюсы:**
- Паузы [StopTheWorld](StopTheWorld.md) менее 10 миллисекунд
- Паузы не увеличиваются с ростом кучи/количества объектов
- Поддержка куч до 16 Tb