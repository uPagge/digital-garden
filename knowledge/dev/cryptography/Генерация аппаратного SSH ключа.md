---
tags:
  - зрелость/🌾
date:
  - - 2024-01-13
zero-link:
  - "[[00 Криптография]]"
parents:
  - "[[SSH]]"
article: https://struchkov.dev/blog/ru/yubikey-ssh/
linked: []
---

> [!WARNING] Версия OpenSSH
> Для работы такого ключа нужен OpenSSH версии 8.2 и выше как на сервере, так и на вашем ПК

```bash
ssh-keygen -t ed25519-sk -O resident -O application=ssh:key_name -f ~/.ssh/key_name 
```

Все как с обычными SSH ключами, появится 2 файла в папке ssh `key_name` и `key_name.pub`. Только вот, воспользоваться секретным ключом без подключения аппаратного ([Yubikey](Yubikey.md)) не выйдет.

Флаг `-O application=ssh:key_name` позволяет установить название ключу, которое можно будет увидеть в приложении Yubico Authentification.

![](Pasted%20image%2020240113100105.png)

Дополнительные флаги:
-  `-O verify-required`. Потребует вводить пароль от аппаратного ключа для доступа к SSH ключу.