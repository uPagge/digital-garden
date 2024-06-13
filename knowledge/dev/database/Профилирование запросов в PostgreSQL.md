---
aliases: []
tags:
  - зрелость/🌱
date:
  - - 2024-01-29
zero-link:
  - "[[00 PostgreSQL]]"
parents: 
linked:
---
- [Explain](Explain.md)
***
PostgreSQL хранит статистику по выполнениям запросов в таблице `pg_stat_user_tables`. С её помощью можно оценить какие операции PostgreSQL выполняет чаще всего.

```sql
select relname, seq_scan, idx_scan, vacuum_count from pg_stat_user_tables
```

***
Расширение pageinspect позволяет изучить структуру индекса (размер страницы, количество страниц и так далее).  

```sql
create extension pageinspect
```

![](Pasted%20image%2020240610084449.png)

***


