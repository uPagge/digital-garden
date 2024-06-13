---
tags:
  - зрелость/🌱
date:
  - - 2023-11-20
zero-link:
  - "[[00 Java разработка]]"
parents:
  - "[[Снипеты на Java]]"
linked:
  - "[[SpringBoot]]"
article: https://note.struchkov.dev/mock-konfighuratsiia-dlia-oauth2-springboot/
---
Полезно при локальной разработке, чтобы не цепляться к настоящему Oauth2 серверу.

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

Сначала регистрируем нашего кастомного провайдера, а дальше подключаем его.