---
aliases:
  - PostgreSQL
tags:
  - type/zero-link
zero-link:
  - "[[00 Реляционная база данных]]"
title: PostgreSQL
---
- Устройство PostgreSQL
	- Журнал: [Write-Ahead Log](../../dev/database/postgresql/Write-Ahead%20Log.md)
- [Индекс в PostgreSQL](../../dev/database/postgresql/Индекс%20в%20PostgreSQL.md)
- [Репликация в PostgreSQL](../../dev/database/postgresql/Репликация%20в%20PostgreSQL.md)
- [Бэкап в PostgreSQL](Бэкап%20в%20PostgreSQL.md)
- [Профилирование запросов в PostgreSQL](../../dev/database/postgresql/Профилирование%20запросов%20в%20PostgreSQL.md)
- [[../../dev/database/postgresql/Таблица в PostgreSQL|Таблица в PostgreSQL]]
	- [[../../dev/database/postgresql/Раздутие таблиц|Раздутие таблиц]]
		- [[../../dev/database/postgresql/Autovacuum|Autovacuum]]

## Заметки
- PostgreSQL пишет на диск в два места – в хранилище данных и в журнал.
- Изменение данных не заменяет строчку физически в памяти, а добавляет новую версию строки. Устаревшие строки через какое-то время помечаются и в них пишутся новые данные.
- Если транзакции нужно выполнить операцию с данными, с которыми работает другая транзакция, то она может встать в очередь.
- В логи попадают не все запросы. Это настраивается конфигурационными параметрами. Если логировать все запросы, то просядет производительность.
- Типичный размер [[../../dev/database/DB page|страницы]] 8 килобайт. На страницу помещается ~ 100 записей.

## Дополнительные материалы
- [pg_utils](../../dev/database/postgresql/pg_utils.md)