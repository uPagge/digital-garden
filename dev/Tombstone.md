---
aliases:
  - софт-удаление
  - мягкое удаление
  - soft-удаление
tags:
  - maturity/🌱
date: 2024-10-31
---
**Tombstone** — это маркер, указывающий, что запись удалена логически, но физически все еще находится в базе данных. Такой подход позволяет системе лучше справляться с репликацией и конфликтами данных, а также обеспечивает корректное выполнение запросов к данным, которые могли быть удалены.

**Плюсы:**
- **Репликация данных**: Tombstones упрощают [[architecture/highload/Репликация БД|репликацию]]. Поскольку данные могут реплицироваться между множеством узлов, простое удаление записи на одном узле не гарантирует, что она будет удалена на всех узлах. Tombstone помогает согласовать состояние данных между узлами.
- **История данных**: В системах, где данные удаляются, но запросы могут возвращаться к старым версиям данных, tombstones позволяют системе правильно обрабатывать такие запросы, показывая, что данные были удалены, а не просто отсутствуют.

**Особенности:**
- **Процесс Compaction**: Со временем, когда гарантируется, что все узлы системы обновили свое состояние и больше не требуется хранение информации об удалении, tombstones могут быть удалены, чтобы освободить место и улучшить производительность системы. Этот процесс называется compaction.
- **Проблема накопления tombstones**: Накопление большого количества tombstones может замедлить производительность базы данных, так как системе приходится пропускать эти маркеры при выполнении запросов. Это особенно актуально для систем с высокой частотой удаления записей.
	- [[database/Частичный индекс|Частичный индекс]]

***
## Мета информация
**Область**:: [[../meta/zero/00 Реляционная база данных|00 Реляционная база данных]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-10-31]]
**Автор**:: [[2024-10-31]]
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

