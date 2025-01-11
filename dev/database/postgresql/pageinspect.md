---
aliases:
  - pageinspect
tags:
  - maturity/🌱
date: 2024-10-21
---
Установка расширения
```sql
create extension pageinspect
```
## Анализ индексов
Расширение pageinspect позволяет изучить структуру индекса (размер страницы, количество страниц и так далее). 

![](../../../meta/files/images/Pasted%20image%2020240610084449.png)

Проверить какие индексы существуют для таблицы:
```sql
select * from pg_indexes where tablename='table_name';
```

Посмотреть сколько раз индекс использовался и когда был последний вызов.
```sql
select * from pg_stat_user_indexes
```

Посмотреть размер индекса
```sql
select pg_size_pretty(pg_indexes_size('orders'))
```

Можно получить мета информацию о дереве индекса:
```sql
select * from bt_metap('users_pkey');
```

Можно получить мета информацию о конкретном узле:
```sql
select * from bt_page_stats('users_pkey', 3);
```

***
## Мета информация
**Область**:: [[../../../meta/zero/00 PostgreSQL|00 PostgreSQL]]
**Родитель**:: [[Оптимизация SQL запросов в PostgreSQL]]
**Источник**:: 
**Создана**:: [[2024-10-21]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

