---
aliases: 
tags:
  - maturity/🌱
date: 2024-02-02
zero-link:
  - "[[../../meta/zero/00 Snippets|00 Snippets]]"
parents:
  - "[[../devops/docker/Полезные Docker образы|Полезные Docker образы]]"
linked:
---
```yaml
socks-proxy:
    image: serjs/go-socks5-proxy
    restart: always
    hostname: socks-proxy
    container_name: socks-proxy
    environment:
      - PROXY_USER=username
      - PROXY_PASSWORD=pass
      - PROXY_PORT=1080
    ports:
      - "1080:1080/tcp"
      - "1080:1080/udp"
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Snippets|00 Snippets]]
**Родитель**:: [[../devops/docker/Полезные Docker образы|Полезные Docker образы]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-02-02]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
