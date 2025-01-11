---
aliases:
  - SBR
tags:
  - maturity/🌱
date:
  - - 2024-06-02
zero-link:
  - "[[../../../meta/zero/00 MySQL|00 MySQL]]"
parents:
  - "[[Репликация в MySQL]]"
linked:
  - "[[Row Based Replication (RBR)]]"
---
Первое, что приходит в голову, это сохранять в Binary Log непосредственно SQL-запросы: Statement-based Binary Log. На основе этого журнала работает Statement Based Replication (SBR). В этом случае master сохраняет в журнал SQL-запросы, а slave получает этот список запросов и выполняет их у себя.

В основе данной репликации лежит журнал [Statement-based Binary Log](Журналы%20в%20MySQL.md#Statement-based%20Binary%20Log).

**Плюсы:**
- Небольшое количество передаваемых данных, при однотипных изменениях. Например, если мы изменяем 5 миллионов строк одним запросом: `UPDATE users SET bonus=bonus+100`, то нужно передать только 1 строку запроса.
- В журнале все записано в понятном человеко-читаемом виде.

**Проблемы:**
* Недетерминирован. Каждый запрос самостоятельно исполняется на слейве.
	* Вызов функций, например функции `now()`. В момент попадания запроса на slave это будет уже другое время.
	- [Остальные примеры](https://dev.mysql.com/doc/refman/8.0/en/replication-rbr-safe-unsafe.html): uuid(), fund_rows(), rand(), UDF, триггеры на апдейт, auto_increment
- Долгое выполнение сложных запросов. Если запрос выполнялся 10 минут на master, то на slave он тоже будет выполняться 10 минут.

Для того чтобы SBR работала корректно, есть специальный флажок.
***
## Мета информация
**Область**:: [[../../../meta/zero/00 MySQL|00 MySQL]]
**Родитель**:: [[Репликация в MySQL]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-06-02]]
### Дополнительные материалы
- [[Row Based Replication (RBR)|Row Based Replication (RBR)]]
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
