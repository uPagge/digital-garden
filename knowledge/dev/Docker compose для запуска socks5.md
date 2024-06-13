---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-02-02
zero-link:
  - "[[00 Разработка]]"
parents: 
linked:
---
```yaml
socks-proxy:
    image: serjs/go-socks5-proxy
    restart: always
    hostname: socks-proxy
    container_name: socks-proxy
    environment:
      - PROXY_USER=Omission7840
      - PROXY_PASSWORD=Bhk9CZrZjwqMoX@7T
      - PROXY_PORT=1080
    ports:
      - "1080:1080/tcp"
      - "1080:1080/udp"
```