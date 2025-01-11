---
aliases: 
tags:
  - maturity/🌱
date:
  - - 2024-06-20
zero-link: 
parents: 
linked:
---
Дедлок — это ситуация, при которой два или более [[Поток процесса ОС|потока]] блокируют друг друга, ожидая освобождения ресурсов, которые удерживаются другим потоком. Чтобы понять это, нужно рассмотреть, что такое «блокировки» и «ресурсы».

[[Блокировка]] — это способ «захвата» ресурса, чтобы предотвратить доступ других потоков к этому ресурсу до завершения текущей операции.

Ресурс может быть любой частью программы, к которой требуется эксклюзивный доступ: файл, переменная, раздел памяти или даже объект базы данных.

Простой пример дедлока:
- Поток A захватывает ресурс 1 (например, файл) и пытается получить доступ к ресурсу 2 (например, переменной), но этот ресурс уже захвачен потоком B.
- Поток B захватывает ресурс 2 и пытается получить доступ к ресурсу 1, который удерживается потоком A.

В результате оба потока зависают — каждый ждёт освобождения ресурса, который удерживает другой поток. Это называется дедлоком, и программа перестаёт выполнять свои задачи, так как ни один из потоков не может продолжить работу.

**Советы:**
- Делать транзакции короче.
- Выполнить повторно откатившуюся транзакцию

**Что реально поможет:**
- Разделить потоки чтения и записи: [CQRS](CQRS.md)
- Использовать материализованные view.
- Изменить порядок блокировок ресурсов. Если в разных операциях блокируется определенный набор ресурсов, то блокироваться первым должен всегда один и тот же ресурс
- Пересмотреть [Уровни изоляций транзакций БД](Уровни%20изоляций%20транзакций%20БД.md)
- Сразу использовать Exclusive lock. Но это сильно может сказаться на производительности.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Разработка|00 Разработка]]
**Родитель**:: [[Multithreading|Многопоточность]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-06-20]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->