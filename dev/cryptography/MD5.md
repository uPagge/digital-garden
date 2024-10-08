---
aliases:
  - Message Digest Algorithm 5
tags:
  - maturity/🌱
date: 2024-09-14
zero-link:
  - "[[../../meta/zero/00 Криптография|00 Криптография]]"
  - "[[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]"
parents:
  - "[[Хеш-функция]]"
linked: 
---
MD5 (Message Digest Algorithm 5) — это [[Хеш-функция]], которая преобразует входные данные в 128-битное (16-байтное) значение, называемое хешем или дайджестом сообщения.


> [!DANGER]
> Сегодня MD5 считается устаревшим и небезопасным для большинства криптографических приложений. В современных системах вместо MD5 рекомендуется использовать более безопасные алгоритмы, такие как [[SHA-256]] или SHA-3, которые обладают лучшей устойчивостью к коллизиям и другим атакам.


Широко используется для проверки целостности данных и в других криптографических задачах.

**Основные характеристики MD5:**
- **Фиксированная длина выхода**: Независимо от размера входных данных (например, текст или файл), хеш всегда имеет длину 128 бит (16 байт).
- **Однонаправленность**: MD5 является однонаправленной функцией, что означает, что невозможно восстановить исходные данные по их хешу.
- **Быстродействие**: MD5 работает быстро и эффективно, что сделало его популярным для использования в приложениях, где требуется быстрая обработка данных.

**Недостатки MD5:**
- **Уязвимость к коллизиям**: MD5 подвержен коллизиям, что означает, что существует возможность найти два различных входа, которые дают одинаковый хеш. Это делает MD5 небезопасным для криптографических применений, таких как цифровые подписи и сертификаты.
- **Атаки на предобраз**: Существуют методы, позволяющие найти вход, соответствующий заданному хешу, что еще больше подрывает надежность MD5.
- **Низкая устойчивость к криптографическим атакам**: Со временем были разработаны более мощные алгоритмы, такие как [[SHA-256|SHA-256]] и SHA-3, которые обеспечивают лучшую безопасность по сравнению с MD5.

**Применения MD5:**
- **Проверка целостности данных**: Используется для проверки целостности файлов и данных, например, в контексте загрузки программного обеспечения, где MD5 хеши публикуются вместе с файлами для проверки их целостности.
- **Создание контрольных сумм**: MD5 был популярен для создания контрольных сумм файлов, чтобы быстро проверить, не были ли файлы изменены.
- **Идентификаторы и хеширование строк**: MD5 использовался для создания уникальных идентификаторов и хеширования паролей (хотя сейчас это считается небезопасной практикой).
***
## Мета информация
**Область**:: [[../../meta/zero/00 Криптография|00 Криптография]]
**Родитель**:: [[Хеш-функция]]
**Источник**:: 
**Создана**:: [[2024-09-14]]
**Автор**:: 
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
