---
aliases:
  - LRU
tags:
  - maturity/🌱
date:
  - - 2024-05-24
zero-link:
  - "[[../../meta/zero/00 Алгоритм|00 Алгоритм]]"
parents:
  - "[[Алгоритм вытеснения кэша]]"
linked:
  - "[[Most Recently Used]]"
  - "[[Псевдо-LRU]]"
---
Least Recently Used (LRU) — это алгоритм управления кэш-памятью, который выбирает для удаления тот элемент, который давно не использовался. Этот алгоритм часто используется в системах, где ограничены ресурсы памяти, и необходимо эффективно управлять кэшированием данных.

**Принцип работы:**
1. **Отслеживание использования**: Каждый элемент в кэше имеет метку времени или счетчик, который обновляется каждый раз, когда элемент используется.
2. **Удаление устаревших элементов**: Когда необходимо освободить место в кэше для нового элемента, удаляется элемент с наименьшим значением метки времени или счетчика, то есть наименее недавно использованный элемент.

**Преимущества**:
- Эффективное управление памятью.
- Простота реализации и понятная логика работы.

**Недостатки**:
- Высокие накладные расходы на обновление меток времени или счетчиков. Поэтому чаще всего используют [Псевдо-LRU](Псевдо-LRU.md).
- Возможность неэффективной работы в некоторых специфических случаях, когда часто используемые элементы могут вытесняться из кэша.

**Примеры использования:**
- [[../architecture/Кэширование|Кэширование]] страниц в веб-браузерах.
- Управление оперативной памятью в [[../../../../knowledge/dev/pc/Операционная система|операционных системах]].
- Кэширование данных в базах данных и других системах хранения.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Алгоритм|00 Алгоритм]]
**Родитель**:: [[Алгоритм вытеснения кэша]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-05-24]]
### Дополнительные материалы
- [[Most Recently Used]]
- [[Псевдо-LRU]]
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
