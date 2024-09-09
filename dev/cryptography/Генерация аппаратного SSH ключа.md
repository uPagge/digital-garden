---
tags:
  - maturity/🌾
date:
  - - 2024-01-13
zero-link:
  - "[[../../meta/zero/00 Криптография|00 Криптография]]"
parents:
  - "[[SSH]]"
linked:
---
> [!WARNING] Версия OpenSSH
> Для работы такого ключа нужен OpenSSH версии 8.2 и выше как на сервере, так и на вашем ПК

> [!WARNING] PGP
>   В интернете полно гайдов, как использовать GPG агент вместо SSH, когда у вас вместо ssh ключа будут ключи gpg. Но эти настройки выглядит как костыли.

```bash
ssh-keygen -t ed25519-sk -O resident -O application=ssh:key_name -f ~/.ssh/key_name 
```

Все как с обычными SSH ключами, появится 2 файла в папке ssh `key_name` и `key_name.pub`. Только вот, воспользоваться секретным ключом без подключения аппаратного ([Yubikey](Yubikey.md)) не выйдет.

Флаги:
-  `-O verify-required`. Потребует вводить пароль от аппаратного ключа для доступа к SSH ключу.
- `-O application=ssh:key_name`. Позволяет установить название ключу, которое можно будет увидеть в приложении Yubico Authentification. ![](../../meta/files/images/Pasted%20image%2020240113100105.png)

Такой ключ подойдет и для доступа к репозиториям. Но необходимо будет прописать в `~/.ssh/config` информацию о том, какой ключ использовать:

```yaml
Host github.com
    Hostname github.com
    IdentityFile ~/.ssh/github
    IdentitiesOnly yes
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Криптография|00 Криптография]]
**Родитель**:: [[../../../../knowledge/dev/network/SSH|SSH]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-01-13]]
### Дополнительные материалы
- 
### Дочерние заметки
```dataview
LIST 
FROM [[]]
WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link)
```