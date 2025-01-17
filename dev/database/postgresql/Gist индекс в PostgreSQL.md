---
aliases:
  - Gist индекс
tags:
  - maturity/🌱
date: 2024-10-23
---
**Особенности GiST индекса в PostgreSQL:**
- Используется для индексации сложных данных, таких как геометрия и гео-данные.
- Подходит для задач, связанных с пространственными запросами, например, для поиска ближайшей гео-точки.
- Гибкий механизм, позволяющий расширять функциональность индексации за счет различных расширений, таких как `pg_trgm` и `btree_gist`.

**Пример создания**
```sql
CREATE INDEX idx_name ON table_name USING gist (column_name);
```

**Поддерживаемые расширения для GiST индекса:**
- `pg_trgm`: Поддерживает операции `LIKE`, `ILIKE`, `~`, `~*` (регулярные выражения), что делает его полезным для быстрого полнотекстового поиска.
- `btree_gist`: Добавляет поддержку B-tree в GiST и позволяет делать сложные ограничения (constraints) с интервалами, например, контроль пересечения времени для создания расписания.
***
## Мета информация
**Область**:: [[../../../meta/zero/00 PostgreSQL|00 PostgreSQL]]
**Родитель**:: [[Индекс в PostgreSQL]]
**Источник**:: 
**Создана**:: [[2024-10-23]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

