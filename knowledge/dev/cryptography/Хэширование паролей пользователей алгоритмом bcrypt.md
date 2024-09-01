---
aliases:
  - bcrypt
tags:
  - зрелость/🌱
date:
  - - 2024-03-03
zero-link:
  - "[[../../../garden/ru/meta/zero/00 Java разработка]]"
  - "[[00 Криптография]]"
parents: 
linked: 
---
Добавляем зависимость
```xml
<dependency>
    <groupId>org.mindrot</groupId>
    <artifactId>jbcrypt</artifactId>
    <version>0.4</version>
</dependency>
```

Чтобы получить хэш пароля:
```java
String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());
```

Чтобы проверить введенный пользователем пароль:
```java
// Извлекаете хешированный пароль из базы данных для данного пользователя
boolean isPasswordCorrect = BCrypt.checkpw(rawPassword, hashedPasswordFromDatabase);
// rawPassword - пароль, введённый пользователем при попытке входа
// hashedPasswordFromDatabase - хешированный пароль, извлеченный из базы данных
```

Этот процесс не зависит от перезапуска приложения. Соль и хеш, которые были созданы при первоначальном хешировании пароля, остаются неизменными в базе данных, и вы используете их каждый раз при аутентификации пользователя, независимо от того, сколько раз приложение было перезапущено.