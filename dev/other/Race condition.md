---
aliases:
  - состояние гонки
  - условие гонки
  - состояния гонки
  - race conditions
tags:
  - maturity/🌱
date:
  - - 2024-06-19
---
Состояние гонки возникает, когда два или более потока одновременно пытаются получить доступ к одному и тому же ресурсу (например, переменной), причём хотя бы один поток изменяет его значение. В таких случаях порядок выполнения потоков не гарантирован, что приводит к непредсказуемому поведению программы. Например, один поток может записывать данные, в то время как другой — читать, что вызывает некорректные результаты.

Для предотвращения состояния гонки применяются механизмы синхронизации, такие как мьютексы, блокировки или ключевое слово synchronized в Java. Эти средства гарантируют, что только один поток может изменять общий ресурс в любой момент времени.

Пример race condition в БД: 
![](../../meta/files/images/Pasted%20image%2020240619200549.png)
***
## Мета информация
**Область**:: [[../../meta/zero/00 Разработка|00 Разработка]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-06-19]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
