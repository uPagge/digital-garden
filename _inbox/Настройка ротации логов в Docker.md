---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-08-21
zero-link:
  - "[[00 Docker]]"
parents: 
linked:
---
По умолчанию все что пишется в stdout контейнера попадает в итоге в файл лога. И по умолчанию нет никакой ротации. Из-за чего память на сервере постепенно заканчивается.

Можно настроить ротацию глобально для всех контейнеров через файл `/etc/docker/daemon.json`:
```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
```

После этого перезапустите Docker:
```bash
sudo systemctl restart docker
```

А можно настроить для каждого контейнера индивидуально
```yaml
services:
	nexus:
		image: sonatype/nexus3:3.70.1
		logging:
		  options:
			max-size: "10m"
			max-file: "5"
```