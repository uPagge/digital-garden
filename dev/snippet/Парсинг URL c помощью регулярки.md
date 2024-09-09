---
tags:
  - maturity/🌱
date: 2023-11-20
zero-link:
  - "[[../../../../garden/ru/meta/zero/00 Снипеты для Java|00 Снипеты для Java]]"
parents: 
linked:
---
Разделение URL-адреса на протокол, домен, порт и URI с помощью регулярного выражения.

```java
// Split URL into protocol, domain, port and URI
Pattern pattern = Pattern.compile("(https?://)([^:^/]*)(:\\d*)?(.*)?");
Matcher matcher = pattern.matcher(url);

matcher.find();

String protocol = matcher.group(1);
String domain   = matcher.group(2);
String port     = matcher.group(3);
String uri      = matcher.group(4);
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2023-11-20]]
### Дополнительные материалы
- 
### Дочерние заметки
```dataview
LIST 
FROM [[]]
WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link)
```