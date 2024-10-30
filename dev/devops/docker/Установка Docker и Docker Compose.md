---
aliases: 
tags:
  - maturity/🌱
date:
  - - 2024-04-07
zero-link:
  - "[[../../../meta/zero/00 Docker|00 Docker]]"
parents: 
linked:
---
Гайдов, как устанавливать docker полно в интернете. [Официальная документации](https://docs.docker.com/engine/install/) написана доступным языком.

Команды установки docker для CentOS 8 и RHEL 8.

```shell
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli
sudo systemctl start docker
sudo systemctl enable --now docker
```

Также установим docker-compose. Обращаю ваше внимание, что актуальным является Docker Compose V2, который в отличие от первой версии поставляется бинарными файлами.

```shell
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.14.0/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
```
[Актуальная версия docker-compose](https://github.com/docker/compose/releases/)

> [!INFO]
> Эта команда устанавливает Compose V2 для активного пользователя в каталог `$HOME`. Чтобы установить Docker Compose для всех пользователей вашей системы, замените `~/.docker/cli-plugins` на `/usr/local/lib/docker/cli-plugins`.

Проверяем, что установка прошла успешно.

```shell
$ docker compose version
Docker Compose 2.2.3
```

> [!WARNING]
> Также обращаю ваше внимание, что в Compose V1 для работы использовалась команда `docker-compose`, а в V2 отказались от дефиса `docker compose`

***
## Мета информация
**Область**:: [[../../../meta/zero/00 Docker|00 Docker]], [[../../../meta/zero/00 Docker Compose|00 Docker Compose]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-04-07]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
