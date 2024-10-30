---
tags:
  - type/zero-link
zero-link:
  - "[[00 DevOps|00 DevOps]]"
aliases:
  - Docker
title: Docker
---
Для изоляции и управления ресурсами контейнеров активно используется [cgroup](../../dev/linux/Control%20group.md). Так же для изоляции активно используется [Namespace](../../dev/linux/Namespace.md). Все это функционал ядра Linux, поэтому не оказывает сильного влияния на производительность. Однако, нужно быть осторожным при работе с диском и сетью. С сутью больше всего проблем, например при запуске nginx можно получить просадку в 5%.

Обычно docker запускается от root пользователя.

- [[../../dev/devops/docker/Установка Docker и Docker Compose|Установка Docker и Docker Compose]]
- [Команды Docker](Команды%20Docker.md)
- [Dockerfile](../../dev/devops/docker/Dockerfile.md)
- [Docker Network](../../dev/devops/docker/Docker%20Network.md)
- [Структура хранилища файлов Docker](Структура%20хранилища%20файлов%20Docker.md)
- [Очистка мусора в Docker](Очистка%20мусора%20в%20Docker.md)
	- [Настройка ротации логов в Docker](Настройка%20ротации%20логов%20в%20Docker.md)
## Полезное
- Утилита для анализа докер образов: [Утилита Dive](Утилита%20Dive.md)
- Утилита [Hadolint](https://github.com/hadolint/hadolint). Проверяет докер файл на плохие практики.
- xfs более производительный
- Native Overlay Diff рекомендуют отключать (docker info)
- [Полезные Docker образы](../../dev/devops/docker/Полезные%20Docker%20образы.md)