---
aliases: 
tags:
  - maturity/🌱
date: 2024-09-07
zero-link:
  - "[[../../meta/zero/00 Java разработка|00 Java разработка]]"
parents: 
linked:
---
Если ваша программа может вернуть коллекцию, которая не содержит никаких значений, убедитесь, что возвращается пустая коллекция, а не `null`. Это сэкономит вам время на различные проверки и избавит от многих потенциальных ошибок.

```java
public List<Event> getAllEventByUserId(int userId) {
    if (userId == 0) {
        return Collections.emptyList();
    }
    return eventRepository.findAllByUserId(userId);
}
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Java разработка|00 Java разработка]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-09-07]]
### Дополнительные материалы
- 
### Дочерние заметки
```dataview
LIST 
FROM [[]]
WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link)
```