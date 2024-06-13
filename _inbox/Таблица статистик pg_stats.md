---
aliases:
  - pg_stats
tags:
  - зрелость/🌱
date:
  - - 2024-03-31
zero-link:
  - "[[00 PostgreSQL]]"
parents: 
linked:
---
Посмотреть статистику по колонке:
```sql
select * from pg_stats where tablename = 'your_table_name' and attname = 'column_name';
```

Пример вывода:
![400](Pasted%20image%2020240331093839.png)

Самые полезные значения:
- **correlation**. Упорядоченность значений. 1 показывает, что все значения упорядочены.
- **n_distinct**. Уникальность значений. Показывает как много уникальных значений в колонке.
- **most_common_vals** и **most_common_freqs**. Показывает самые частые значения колонки и частоту их встречаемости. 
- **null_frac**. Объемы null. 0.92 означает, что количество null значений в колонке примерно 92%.