---
aliases:
  - BRIN индекс
tags:
  - maturity/🌱
date: 2024-10-24
---
BRIN индекс предназначен для больших таблиц с упорядоченными данными, таких как временные ряды. Это компактный и эффективный индекс для работы с диапазонными запросами.

Пример создания:
```sql
CREATE INDEX idx_name ON table_name USING brin (column_name);
```
***
## Мета информация
**Область**:: [[../../../meta/zero/00 PostgreSQL|00 PostgreSQL]]
**Родитель**:: [[Индекс в PostgreSQL|Индекс в PostgreSQL]]
**Источник**:: 
**Создана**:: [[2024-10-24]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

