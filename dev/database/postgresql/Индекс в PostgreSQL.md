---
aliases: []
tags:
  - maturity/🌱
date: 2024-03-31
---
[[../../../meta/zero/00 PostgreSQL|PostgreSQL]] поддерживает несколько типов [[../Индекс базы данных|индексов]], каждый из которых предназначен для определённых задач. Выбор типа индекса зависит от структуры данных и характера запросов. В этом разделе приведены основные типы индексов, их особенности и случаи, когда их использование наиболее эффективно.

**Особенности:**
- Для **первичного ключа** индекс создается автоматически.
- Можно **отключить автоматическое обновление индекса** и настроить обновление вручную.
- **Распухание индексов** (bloat) — это проблема увеличения размера индексов со временем, требующая переиндексации.

- [[Создание индекса в PostgreSQL]]
- [[../Частичный индекс]]
- [[Составной индекс в PostgreSQL]]

**Типы индексов:**
- [[B-tree индекс в PostgreSQL|B-tree индекс]]
- [[Hash индекс в PostgreSQL|Hash индекс]]
- [[Gist индекс в PostgreSQL|Gist индекс]]
- [[SP-GiST индекс в PostgreSQL|SP-GiST индекс]]
- [[GIN индекс в PostgreSQL|GIN индекс]]
- [[BRIN индекс в PostgreSQL|BRIN индекс]]
***
## Мета информация
**Область**:: [[../../../meta/zero/00 PostgreSQL|00 PostgreSQL]]
**Родитель**:: [[../Индекс базы данных|Индекс базы данных]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-03-31]]
### Дополнительные материалы
- [Доклад. Индексы в PostgreSQL. Как понять, что создавать](../../../source/lecture/Доклад.%20Индексы%20в%20PostgreSQL.%20Как%20понять,%20что%20создавать.md)
- [009. B-деревья. Система непересекающихся множеств - М. А. Бабенко - YouTube](https://www.youtube.com/watch?v=KFcpDTpoixo)
- [Индексы в PostgreSQL — 1 / Хабр](https://habr.com/ru/companies/postgrespro/articles/326096/)
- [Introduction of B+ Tree - GeeksforGeeks](https://www.geeksforgeeks.org/introduction-of-b-tree/)
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
<!-- SerializedQuery: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
- [[B-tree индекс в PostgreSQL]]
- [[BRIN индекс в PostgreSQL]]
- [[GIN индекс в PostgreSQL]]
- [[Gist индекс в PostgreSQL]]
- [[Hash индекс в PostgreSQL]]
- [[SP-GiST индекс в PostgreSQL]]
- [[Создание индекса в PostgreSQL]]
- [[Составной индекс в PostgreSQL]]
- [[Частичный индекс]]
<!-- SerializedQuery END -->
