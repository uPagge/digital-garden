---
aliases: 
tags:
  - maturity/🌱
  - type/opinion
date: 2024-09-06
zero-link:
  - "[[../../meta/zero/00 Java разработка|00 Java разработка]]"
parents: 
linked:
---
Представьте, что у вас есть enum, который отвечает за статус пользователя в системе: "онлайн", "офлайн" и "занят".

```java
public enum UserStatus {

    ONLINE, OFFLINE, BUSY
    
}
```

```java
public class User {

    ...

    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    private UserStatus status;
    
    ...

}
```

Скорее всего для выполнения бизнес-логики вам потребуется проверять статус пользователя

```java
if (user.getStatus().equals(UserStatus.ONLINE)) {
    // to do something
}
```

Вроде бы все отлично, миссия выполнена. Но есть одно НО. Что если `getStatus()` вернет вам `null`? Правильно, вы получите `NullPointerException`.

Чтобы этого избежать следует придерживаться правила "Сравнения константы слева". Оно очень простое. В нашем примере, мы точно уверены, что `UserStatus.ONLINE` существует, поэтому `.equals()` стоит вызывать от него.

```java
if (UserStatus.ONLINE.equals(user.getStatus())) {
    // to do something
}
```

В остальных подобных ситуациях делайте также, например со строками:

```java
if ("Иванов".equals(user.getLastName())) {
    // to do something
}
```

Это простое правило защитит вас от `NullPointerException`.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Java разработка|00 Java разработка]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-09-06]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
