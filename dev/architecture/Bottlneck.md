---
aliases:
  - узкое место
tags:
  - maturity/🌱
date: 2024-12-01
---
Узкое место (bottleneck) — компонент системы, ограничивающий её производительность или пропускную способность. Даже один неэффективный элемент может стать причиной снижения эффективности всей [[../../../../_inbox/Информационная система|информационной системы]].

Боттлнеки могут скрываться в любом элементе системы. Вот некоторые возможные области:
- [[highload/Балансировка нагрузки|Балансировщик нагрузки]]. Проблемы с распределением трафика.
- [[Бэкенд|Приложение]]. Ограничения на уровне кода или инфраструктуры.
- [[../../meta/zero/00 Реляционная база данных|База данных]]. Медленная обработка запросов, нехватка соединений.
- Распределенный [[Кэширование|кэш]]. Недостаток ресурсов или медленный доступ.
- [[Брокер сообщений]]. Ограничения на пропускную способность.
- Пропускная способность диска. Узкие места в файловых системах.

**Пример в** [[../../../../wiki/zero/00 Микросервисная архитектура|микросервисной архитектуре]].
Рассмотрим систему с несколькими микросервисами и сервисом аутентификации. Если общий объем запросов составляет 1000 rps, а сервис аутентификации может обработать только 100 rps, то он становится узким местом, замедляя работу всей системы.
***
## Мета информация
**Область**:: [[../../meta/zero/00 HighLoad|00 HighLoad]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-12-01]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
