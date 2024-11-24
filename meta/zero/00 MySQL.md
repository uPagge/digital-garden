---
aliases:
  - MySQL
tags:
  - type/zero-link
zero-link:
  - "[[00 Реляционная база данных]]"
title: MySQL
---
- [[../../dev/database/mysql/Архитектура MySQL|Архитектура MySQL]]
- [Репликация в MySQL](../../dev/database/mysql/Репликация%20в%20MySQL.md)
- [libslave](libslave.md)
- [Бекап в MySQL](Бекап%20в%20MySQL.md)
- [Индекс в MySQL](../../../../_inbox/Индекс%20в%20MySQL.md)
- [Журналы в MySQL](../../dev/database/mysql/Журналы%20в%20MySQL.md)
- [Explain в MySQL](Explain%20в%20MySQL.md)
## Идентификация транзакций
До версии 5.5 идентифицировать транзакцию можно было только по имени файла и позиции в этом файле. Потом появились GTID, но надо явно включить gtid_mode =ON. C 5.6.5 GTID используется по умолчанию.

binary log position:
- Пример: mysql-bin.00078:44
- Локальный для сервера
- Обязательно сломается

GTID:
- Пример: 7F33BC78-56CA-44B3-5E33-B34CC7689333:44
- Глобален, генерируется автоматически при коммите
- Бесплатная трассировка
- Простой slave promotion
- ==Используйте его==

## Заметки
- MySQL пишет на диск в три места – хранилище (tablespace), журнал (undo/redo log), и Binary Log