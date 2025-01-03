---
aliases: 
tags:
  - maturity/🌱
date:
  - - 2024-03-10
zero-link:
  - "[[../../../meta/zero/00 HighLoad|00 HighLoad]]"
parents:
  - "[[Репликация БД]]"
linked:
  - "[[Репликация master-slave]]"
---
Все реплики являются ведущими (master). Во все реплики можно писать изменения, а они каким-то образом синхронизируются между собой. Ведущие реплики могут также иметь дополнительные реплики в режиме [[Репликация master-slave|репликации master-slave]].

![](Pasted%20image%2020240206194251.png)

**Плюсы**:
- Нет единой точки отказа
- Дает максимальный [Availability](../../../../../_inbox/Availability.md).
- Легкий failover

**Минусы:**
- Нет консистентности. Могут возникать конфликты при одновременной работе с одним и тем же набором данных на разных репликах.
- Усложнение логики. Встречается редко.
- Все равно не масштабирует запись. Для масштабирования нужно использовать [шардирование](Шардирование%20БД.md).

**Варианты применения:**
- Географическая распределенность. Репликация между ЦОД-ами в разных странах. Улучшается производительность, так как пользователь из страны работает с ближайшим ЦОД. Вы устойчивы к потере ЦОД и к сетевым проблемам, так как данные есть в других ЦОД-ах.
- Hot-standby реплика (VIP). Второй мастер всегда на готове, на случай если упадет основной. Во время штатной работы второй мастер не используется.
- Offline клиенты. При плохом или вовсе временно отсутвующем интерент соединении для ассинхронного объединения данных. CouchDB является примером такой БД.

Варианты реализаций:
- Amazon Aurora
- Google Spanner
## Решение конфликтов
- Избегайте конфликтов. Организуйте взаимодействие так, чтобы конфликты не возникали.
- Last write wins.  Выигрывает последняя запись. Но обычно сложно определить кто был первым.
- Ранг реплик. Выигрывает запись от старейшей реплки.
- Слияние. Автоматическое объединение конфликтных данных.
- Решение конфликтов на клиенте.
- Conflict-free replicated data types (CRDT). 
- Mergeable persistent data structures.
	- В этом режиме работает [00 Git](../../../meta/zero/00%20Git.md)
***
## Мета информация
**Область**:: [[../../../meta/zero/00 HighLoad|00 HighLoad]]
**Родитель**:: [[Репликация БД]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-03-10]]
### Дополнительные материалы
- [[Репликация master-slave]]
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
