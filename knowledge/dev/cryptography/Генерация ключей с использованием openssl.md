---
aliases:
  - openssl
tags:
  - зрелость/🌱
  - tag/openssl
  - tag/rsa
date:
  - - 2024-03-03
zero-link:
  - "[[00 Криптография]]"
parents: 
linked:
---
Сгенерировать приватный RSA ключ:
```shell
openssl genrsa -out privateKey.pem 2048
```

Получить публичный RSA ключ по существующему приватному:
```shell
 openssl rsa -pubout -in privateKey.pem -out publicKey.pem
```