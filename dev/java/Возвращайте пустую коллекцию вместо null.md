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