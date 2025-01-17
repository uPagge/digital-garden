---
aliases:
  - pg_stats
tags:
  - maturity/🌱
date: 2024-03-31
---
Для получения статистики по определенной колонке используйте следующий запрос:
```sql
SELECT * FROM pg_stats WHERE tablename = 'your_table_name' AND attname = 'column_name';
```

Пример вывода:
![400](../../../meta/files/images/Pasted%20image%2020240331093839.png)

Самые полезные значения:
- **n_distinct**: Уникальность значений. Показывает, сколько уникальных значений содержится в колонке. Например, значение `-1` указывает, что количество уникальных значений составляет примерно 1% от общего количества строк.
- **correlation**: Упорядоченность значений. Значение близкое к 1 показывает, что значения упорядочены по возрастанию, а близкое к -1 — что по убыванию. Высокая корреляция помогает планировщику оптимизировать выполнение запросов, используя последовательное сканирование индексов.
- **most_common_vals** и **most_common_freqs**: Самые частые значения колонки и их частота. Эти данные помогают планировщику лучше оценить стоимость выполнения запросов и выбрать наиболее эффективный план.
- **null_frac**: Доля `NULL` значений. Например, значение 0.92 означает, что около 92% значений в колонке — `NULL`. Высокое значение `null_frac` может указывать на возможность создания частичного индекса для улучшения производительности.

> [!WARNING]
> Данные в `pg_stats` основаны на выборке, и поэтому могут не всегда точно отражать реальное состояние таблицы, особенно если данные часто изменяются. Для более точной оценки можно увеличить выборку строк с помощью настройки статистики
## Советы по анализу
- При большом значении `null_frac` остальные параметры могут иметь меньшее значение. На основе этой информации можно уменьшить размер индекса, создав [[../Частичный индекс]].
- Если `n_distinct` показывает низкую уникальность, возможно, индекс на этой колонке не принесет значительного ускорения, так как слишком много строк имеют одинаковые значения (Низкая [[../Селективность колонки|селективность]]). В таком случае стоит рассмотреть пересмотр структуры запроса или таблицы.
- Высокое значение `correlation` (близкое к 1 или -1) означает, что данные отсортированы, что может существенно ускорить диапазонные запросы. В таких случаях планировщик может использовать последовательное сканирование, что может быть быстрее, чем случайное чтение.
***
## Мета информация
**Область**:: [[../../../meta/zero/00 PostgreSQL|00 PostgreSQL]]
**Родитель**:: [[Оптимизация SQL запросов в PostgreSQL]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-03-31]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
