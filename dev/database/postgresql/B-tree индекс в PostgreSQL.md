---
aliases:
  - B-tree индекс
  - B-tree
tags:
  - maturity/🌱
date: 2024-10-23
---
B-tree индекс основан на [[../../fundamental/structure/B-tree|B-tree]] дереве. Только в последних узнал добавляются ссылки на строки в таблицах.

![[../../../meta/files/draw/Структура B-tree индекса в базе данных.excalidraw.png]]
[[../../../meta/files/draw/Структура B-tree индекса.excalidraw|Структура B-tree индекса.excalidraw]]

**Особенности:**
- Подходит для операций сравнения (`<`, `>`, `BETWEEN`), равенства (`=`) и сортировки.
- Хорошо оптимизирован для большинства операций чтения и поиска.
- Покрывает до 90% задач по индексации в типичных приложениях.
- Не рекомендуется для данных с высокой степенью повторения, так как эффективность индекса в таких случаях может снижаться.

Пример создания:
```sql
CREATE INDEX idx_name ON table_name (column_name);
```

Индекс легко создать, ориентируясь на [[Таблица статистик pg_stats|pg_stats]].
***
## Мета информация
**Область**:: [[../../../meta/zero/00 PostgreSQL|00 PostgreSQL]]
**Родитель**:: [[Индекс в PostgreSQL|Индекс в PostgreSQL]]
**Источник**:: 
**Создана**:: [[2024-10-23]]
**Автор**:: 
### Дополнительные материалы
- [Владимир Ситников — B-tree индексы в базах данных на примере PostgreSQL - YouTube](https://www.youtube.com/watch?v=mnEU2_cwE_s)

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

