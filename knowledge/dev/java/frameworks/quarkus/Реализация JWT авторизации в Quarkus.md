---
aliases: 
tags:
  - зрелость/🌱
  - tag/quarkus
  - tag/auth
  - tag/jwt
date:
  - - 2024-03-03
zero-link:
  - "[[Quarkus]]"
parents: 
linked: 
---
Quarkus из коробки поддерживаеет JWT авторизацию.

Чтобы получить возможность создавать JWT необходимо добавить зависимость
```xml
<dependency>  
    <groupId>io.quarkus</groupId>  
    <artifactId>quarkus-smallrye-jwt-build</artifactId>  
</dependency>
```

Чтобы получить возможность валидировать JWT необходимо добавить зависимость
```xml
<dependency>  
    <groupId>io.quarkus</groupId>  
    <artifactId>quarkus-smallrye-jwt</artifactId>  
</dependency>
```

Далее необходимо [сгенерировать приватный и публичный ключ](Генерация%20ключей%20с%20использованием%20openssl.md). После чего положить их в папку `src/main/resources`.

Далее необходимо отредактировать файл `application.yml`

```
quarkus:
  native:
    resources:
      includes:
        - publicKey.pem
smallrye:
  jwt:
    sign:
      key:
        location: privateKey.pem
mp:  
  jwt:
    verify:
      publickey:
        location: publicKey.pem
      issuer: http://localhost:8080
```

Теперь Quarkus будет самостоятельно проверять HTTP Header на наличие JWT токена и проверять его валидность.

Генерация токена происходит вручную. Необходимо написать REST-контроллер, который будет отдавать пользователям токен.
```java
Jwt.issuer("http://localhost:8080")  
        .up(person.getEmail())  
        .expiresIn(Duration.ofMinutes(15))  
        .groups(Collections.singleton("USER"))  
        .claim("id", person.getId())  
        .sign()
```

После этого над REST-эндпойнтами можно использовать аннотации из пакета `jakarta.annotation.security.*`: `@PermitAll`, `@RolesAllowed({"USER"})`.
## Дополнительные материалы
- [Using JWT RBAC - Quarkus](https://quarkus.io/guides/security-jwt)