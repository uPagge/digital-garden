---
aliases: 
tags:
  - maturity/🌱
date: 2024-09-10
zero-link:
  - "[[../../meta/zero/00 Архитектура ИС|00 Архитектура ИС]]"
parents:
  - "[[highload/Инвалидация кэша|Инвалидация кэша]]"
linked: []
---
При реализации [[highload/Кэширование на стороне браузера|кэширования на стороне браузера]]  важно иметь механизм [[highload/Инвалидация кэша|инвалидации кэша]]. Иначе пользователи могут продолжить видеть неактуальные JS-скрипты и CSS-стили, что приведет к проблемам.

Самый простой способ побороть эту проблему, это использовать fingerprint файла. То есть, когда файл меняется, вы меняете его название. Делается это обычно добавлением какого-нибудь префикса/суфикса к названию файла.

Например у нас есть файл стилей `style.css`, мы можем посчитать для него [[../cryptography/MD5|MD5]] хеш и добавить его в название. Тогда у нас получится следующее название: `style.e626dd36e0085927f334adbe3eb38e7a.css`.

При любом изменении файла [[../cryptography/MD5|MD5]] хеш должен пересчитываться. Таким образом при изменении файла у него будет другое название, и браузер будет вынужден скачать его в любом случае.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Архитектура ИС|00 Архитектура ИС]]
**Родитель**:: [[highload/Инвалидация кэша|Инвалидация кэша]]
**Источник**:: 
**Создана**:: [[2024-09-10]]
**Автор**:: 
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
