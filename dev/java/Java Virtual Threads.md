---
aliases:
  - виртуальные потоки
  - виртуальный поток
  - виртуальных потоков
tags:
  - maturity/🌱
date: 2024-10-03
zero-link: 
parents: 
linked:
---
Виртуальный поток не привязан к конкретному [[../fundamental/Поток процесса ОС|потоку ОС]]. При вызове [[../architecture/Блокирующий вызов|блокирующей операции]] Java останавливает этот поток, до момента пока его можно будет вызвать. То есть мы освобождаем настоящий поток ОС, чтобы он не простаивал.

![[../../../../garden/ru/meta/files/images/Pasted image 20241003081726.png]]

В виртуальных потоках не рекомендуется использовать ThreadLocal.

Виртуальный поток не поможет вам, если ваши операции требуют активной работы CPU.
***
## Мета информация
**Область**:: [[../../../../garden/ru/meta/zero/00 Java разработка|00 Java разработка]]
**Родитель**:: [[../../../../garden/ru/dev/java/Java 21 LTS|Java 21 LTS]]
**Источник**:: 
**Создана**:: [[2024-10-03]]
**Автор**:: 
### Дополнительные материалы
- [Примеры · GitHub](https://github.com/petrelevich/jvm-digging/tree/master/virtual-thread)

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

