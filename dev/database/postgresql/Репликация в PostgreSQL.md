---
aliases: 
tags:
  - maturity/🌱
date:
  - - 2024-05-28
zero-link:
  - "[[../../../meta/zero/00 PostgreSQL|00 PostgreSQL]]"
parents:
  - "[[../../architecture/highload/Репликация БД|Репликация БД]]"
linked:
---
## Тезисы
- Реализуется на базе журнала [WAL](Write-Ahead%20Log.md).
- Репликация упирается в диск, а не в процессор.
- Реплика это точная бинарная копия мастера.
- Работает по push модели
- При физической репликации фильтрация не возможна
***
Распространение изменений в PostgreSQL происходит по push модели. То есть, master отправляет [[Write-Ahead Log|WAL]] на реплики, а реплика применяет данные физически, согласно записям в WAL. Таким образом, если остановить запись в master, дождаться синхронизации реплик и сделать бинарное сравнение master и slaves, они будут идентичны.

![](../../../meta/files/images/Pasted%20image%2020240606094952.png)

Производительность репликации в PostgreSQL обычно ограничена производительностью дисков, а не процессора. Поэтому при использовании HDD рекомендуется выделять отдельный диск для WAL.

Добавление реплики требует остановки работы приложения, чтобы никакие записи не менялись в БД. Хотя, если данные пишутся не так часто, то новая реплика может просто догнать отставание в мастер, которое образуется за время подключения слейва.


## Синхронизация
Async:
- synchronus_commit = 
	- off - не будет дожидаться даже локального подтверждения, нет гарантии что данные дошли до бд
	- local - происходит локальный коммит и в этот же момент отправляется подтверждение

Sync/Semi-symc:
- synchronus_commit = remote_write \/ on \/ remote_apply
	- remote_write - транзакция подтверждается только если получено подтверждение со всех реплик
- synchronus_standby_names = \[FIRST \/ ANY\] N (replicas_list)
	- позволяет настроить от скольких реплик ожидается ответ
## Логическая репликация
Логическая репликация позволяет более гибко управлять копированием данных. Она предоставляет возможность реплицировать отдельные таблицы или схемы, а не всю базу данных целиком. Это особенно полезно для частичного копирования данных и интеграции с другими системами.

Logical Log Streaming Replication – это способ трансформировать Write-Ahead Log. Например, мы не хотим реплицировать все таблицы из данной базы, а хотим реплицировать только часть. Logical Log Streaming Replication позволяет мастеру объяснить, что из таблиц будет уезжать на слэйв.

Logical Decoding – способ визуализировать то, что находится в PostgreSQL Write-Ahead Log. На самом деле, если мы можем напечатать в каком-то виде то, что у нас происходит на слэйве, точнее, что нам пришло через Write-Ahead Log, это значит, что мы можем программно реализовать все то, что делает libslave. Получили insert, update, delete, у нас “дернулся” нужный callback, мы узнали про изменения. Это и есть Logical Decoding.

![](Pasted%20image%2020240606100439.png)

**Конфликты:**
- Нужно идентифицировать запись для update/delete (по первичному ключу/по уникальному ненуллабельному индексу/по всем столбцам).
- В случае возникновения конфликта требуется вручную исправить данные.
***
## Мета информация
**Область**:: [[../../../meta/zero/00 PostgreSQL|00 PostgreSQL]]
**Родитель**:: [[../../architecture/highload/Репликация БД|Репликация БД]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-05-28]]
### Дополнительные материалы
- [[Настройка репликации в PostgreSQL]]
- [BDR User Guide - PostgreSQL wiki](https://wiki.postgresql.org/wiki/Logical_Log_Streaming_Replication)
- [PostgreSQL: Documentation: 16: Chapter 31. Logical Replication](https://www.postgresql.org/docs/current/logical-replication.html)
- [PostgreSQL: Documentation: 9.4: Logical Decoding](https://www.postgresql.org/docs/9.4/logicaldecoding.html). Аналог [libslave](libslave.md) в MySQL
- [Отладка и устранение проблем в PostgreSQL Streaming Replication / Хабр](https://m.habr.com/ru/company/oleg-bunin/blog/414111/)
- [An Overview of Logical Replication in PostgreSQL | Severalnines](https://severalnines.com/blog/overview-logical-replication-postgresql/)
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
<!-- SerializedQuery: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
- [[Настройка репликации в PostgreSQL]]
<!-- SerializedQuery END -->
