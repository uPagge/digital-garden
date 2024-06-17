---
aliases: 
tags:
  - type/zero-link
date:
  - - 2024-02-05
zero-link:
  - "[[00 Базы Данных]]"
parents: 
linked:
---
- Таблица - это гомогенное множество кортежей

- [IN SQL](IN%20SQL.md)
- [JOIN SQL](JOIN%20SQL.md)

## Производительность
- Всегда добавлять индекс для Foreigner key
- Подзапросы лучше, чем JOIN
- IN работает быстрее, чем BETWEEN
- Не стоит сортировать по NULL значениям
- DISTINCT лучше не использовать
- OFFSET это плохо