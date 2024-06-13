---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-05-16
zero-link: 
parents: 
linked: 
link: https://sponsor.ajay.app/
---
Это сервис, который позволяет пропускать нативную рекламу в YouTube.

## Настройка для Smart TV
Данный функционал можно также подключить к Smart TV. Логика следующая, компонент устанавливается на сервер и подключается к YouTube в виде пульта. Данный пуль и будет выполнять переметку рекламы.

Сначала нужно создать файл конфигурации. Делается это следующей командой:

```shell
docker run --rm -it -v blocktv:/app/data ghcr.io/dmunozv04/isponsorblocktv --setup-cli
```

В итоге получаем такой код конфигурации
```json
{
    "devices": [
        {
            "screen_id": "your_id",
            "name": "YouTube on TV"
        }
    ],
    "apikey": "",
    "skip_categories": [
        "sponsor",
        "interaction"
    ],
    "channel_whitelist": [],
    "skip_count_tracking": false,
    "mute_ads": false,
    "skip_ads": false
}
```

Теперь в docker compose добавляем следующий сервис

```yml
  iSponsorBlockTV:
    image: ghcr.io/dmunozv04/isponsorblocktv
    container_name: iSponsorBlockTV
    restart: unless-stopped
    logging:
      options:
        max-size: "10m"
        max-file: "5"
    volumes:
      - ./blocktv:/app/data
```