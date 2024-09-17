---
aliases:
  - PostgreSQL
tags:
  - type/zero-link
zero-link:
  - "[[00 Базы Данных]]"
title: PostgreSQL
---
- Устройство PostgreSQL
	- Журнал: [Write-Ahead Log](../../dev/database/postgresql/Write-Ahead%20Log.md)
- [Индекс в PostgreSQL](Индекс%20в%20PostgreSQL.md)
- [Репликация в PostgreSQL](../../dev/database/postgresql/Репликация%20в%20PostgreSQL.md)
- [Бэкап в PostgreSQL](Бэкап%20в%20PostgreSQL.md)
- [Профилирование запросов в PostgreSQL](Профилирование%20запросов%20в%20PostgreSQL.md)
	- [Explain в PostgreSQL](Explain%20в%20PostgreSQL.md)

## Заметки
- PostgreSQL пишет на диск в два места – в хранилище данных и в журнал.
- Если транзакции нужно выполнить операцию с данными, с которыми работает другая транзакция, то она может встать в очередь.

## Дополнительные материалы
- [pg_utils](pg_utils.md)