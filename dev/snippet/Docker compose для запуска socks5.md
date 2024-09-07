---
aliases: 
tags:
  - maturity/🌱
date: 2024-02-02
zero-link:
  - "[[../../meta/zero/00 Docker|00 Docker]]"
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
      - PROXY_USER=username
      - PROXY_PASSWORD=pass
      - PROXY_PORT=1080
    ports:
      - "1080:1080/tcp"
      - "1080:1080/udp"
```