---
aliases: 
tags:
  - maturity/🌱
date: 2024-10-30
---
Для проверки работоспособности запущенного контейнера можно задать команду `healthcheck`. Контейнер не будет считаться полностью запущенным, пока не выполнится проверка работоспособности. Это особенно полезно при запуске нескольких контейнеров, которые зависят друг от друга. Например, если один контейнер должен быть готов до того, как будет запущен другой.

Пример конфигурации:
```yaml
services:
  database:
    image: postgres:latest
    container_name: database
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 10s
      timeout: 5s
      retries: 3

  webapp:
    image: my-webapp:latest
    container_name: webapp
    depends_on:
      database:
        condition: service_healthy
    ...
```

В этом примере контейнер с веб-приложением (`webapp`) зависит от контейнера с базой данных (`database`). Команда healthcheck для базы данных проверяет, готова ли PostgreSQL принимать подключения (`pg_isready`), и контейнер будет считаться здоровым только после успешного выполнения этой проверки.
***
## Мета информация
**Область**:: [[../../../meta/zero/00 Docker Compose|00 Docker Compose]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-10-30]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

