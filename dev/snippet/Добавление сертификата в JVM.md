---
tags:
  - maturity/🌱
date:
  - - 2024-01-10
---
Первым делом необходимо [скачать сертификат сайта](../cryptography/Скачать%20сертификат%20сайта.md).

Теперь используя `keytool` добавим сертификат в JVM.

```shell
keytool -importcert -file cert_name.cer -keystore keystore_path -storepass "changeit" -noprompt -alias "alias_cert"
```

Где
- `cert_name.cer` - имя сертификата
- `keystore_path` - путь до хранилища сертификатов в JVM
	- Пример: `jdk_path/lib/security/cacerts`
- `alias_cert` - алиас для сертификата

> [!WARNING]
> Возможно потребуется выход из системы, чтобы применились изменения.

***
## Мета информация
**Область**:: [[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-01-10]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
