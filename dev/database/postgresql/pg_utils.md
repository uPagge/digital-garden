---
aliases: 
tags:
  - maturity/🌱
date: 2024-07-24
zero-link: []
parents: 
linked:
---
- [GitHub - dataegret/pg-utils: Useful PostgreSQL utilities](https://github.com/dataegret/pg-utils)

- global_reports
- `top_tables.sql` - покажет размер таблиц и размер индексов на них. Нужно обратить внимания на таблицы, размер индексов которых приближается к размеру таблицы или больше его.
- `indexes_with_nulls.sql` - позволяет найти индексы, которые содержат множество null значений. Их можно пересоздать в виде [[Частичный индекс|частичных индексов]].
- `low_used_indexes.sql` - показывает индексы по которым мало чтения.