---
aliases:
  - страница
  - страницы
  - страница БД
  - Страница БД
  - странице бд
tags:
  - maturity/🌱
date: 2024-11-04
---
В базе данных страница — это базовая единица хранения данных, используемая для организации таблиц и индексов. Она представляет собой фиксированный блок данных (обычно 8 килобайт в PostgreSQL, но размер может варьироваться) и содержит строки таблицы или фрагменты индексов. Когда база данных выполняет запрос, она обращается к страницам, чтобы получить нужные строки, и может считывать их из диска или из кэша, где часто используемые страницы уже загружены в память.

База данных работает поверх операционной системы и поэтому использует [[../fundamental/Страница|страницы ОС]] для хранения своих страниц данных. Когда СУБД загружает страницу базы данных из диска, операционная система выделяет ей одну или несколько страниц оперативной памяти. В результате страницы базы данных хранятся в страницах памяти ОС.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Реляционная база данных|00 Реляционная база данных]]
**Родитель**:: [[../fundamental/Страница|Страница]]
**Источник**:: 
**Создана**:: [[2024-11-04]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
