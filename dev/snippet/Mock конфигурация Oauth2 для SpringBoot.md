---
tags:
  - maturity/🌱
date: 2023-11-20
zero-link:
  - "[[../../../../../garden/ru/meta/zero/00 Снипеты для Java|00 Снипеты для Java]]"
  - "[[../../meta/zero/00 SpringBoot|00 SpringBoot]]"
parents: 
linked:
---
Конфигурация для подключения к мок-сервису авторизации по auth2. Полезно при локальной разработке, чтобы не цепляться к настоящему Oauth2 серверу.

```yml
spring:
  security:
    oauth2:
      client:
        registration:
          mocklab:
            provider: mocklab
            client-authentication-method: basic
            authorization-grant-type: authorization_code
            scope: profile, email
            redirect-uri: http://localhost:8080/login/oauth2/code/
            clientId: mocklab_oidc
            clientSecret: whatever
        provider:
          mocklab:
            authorization-uri: https://oauth.mocklab.io/oauth/authorize
            token-uri: https://oauth.mocklab.io/oauth/token
            user-info-uri: https://oauth.mocklab.io/userinfo
            user-name-attribute: sub
            jwk-set-uri: https://oauth.mocklab.io/.well-known/jwks.json
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]], [[../../meta/zero/00 SpringBoot|00 SpringBoot]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2023-11-20]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
