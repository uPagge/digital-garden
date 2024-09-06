---
aliases: 
tags:
  - maturity/🌱
date:
  - - 2024-09-06
zero-link:
  - "[[../../meta/zero/00 Snippets|00 Snippets]]"
parents:
  - "[[../garden/ru/dev/devops/docker/Полезные Docker образы|Полезные Docker образы]]"
linked:
---
Samba — это свободное программное обеспечение, позволяющее построить файловую помойку на базе SMB/CIFS.

Самый простой способ запустить файловый сервер, это использовать Docker-compose:
```docker-compose
samba:
    image: docker.struchkov.dev/samba:latest
    restart: always
    container_name: samba
    hostname: samba
    networks:
      samba:
    ports:
      - 139:139
      - 445:445
      - 137:137/udp
      - 138:138/udp
    volumes:
      - ./samba/:/cloud:z
    command: '-r -n -p -u "user1;pass1" -u "user2;$pass2" -s "rootfolder1;/cloud/share;yes;no;yes;user1,user2" -s "rootfolder2;/cloud/upagge;yes;no;no;user1" -s "footfolter3;/cloud/hmnitessa;yes;no;no;user2"'
```

**Параметры:**
- `-r` — Отключить корзину для расшаренных ресурсов.
- `-n` — Запустить демон nmbd для объявления расшаренных ресурсов.
- `-p` — Установить права собственности и разрешения на расшаренные ресурсы.
- `-u "<username;password>[;ID;group;GID]"` — Добавить пользователя.
	•	`<username>` — имя пользователя.
	•	`<password>` — пароль пользователя.
	•	`[ID]` — идентификатор пользователя.
	•	`[group]` — группа пользователя.
	•	`[GID]` — идентификатор группы.
- `-s "<name;/path>[;browse;readonly;guest;users;admins;writelist;comment]"` — Настроить расшаренный ресурс.
	•	`<name>` — имя, как будет отображаться для клиентов.
	•	`<path>` — путь к расшаренному ресурсу.
	•	`[browsable]` — по умолчанию: ‘yes’ или ‘no’.
	•	`[readonly]` — по умолчанию: ‘yes’ или ‘no’.
	•	`[users]` — разрешенные пользователи по умолчанию: ‘all’ или список разрешенных пользователей.
	•	`[admins]` — администраторы по умолчанию: ‘none’ или список администраторов.
	•	`[writelist]` — список пользователей, которые могут записывать в ресурс с только для чтения.
	•	`[comment]` — описание расшаренного ресурса.

**Доступные сборки Samba**:
- 4.18.9-ro
- 4.19.6-ro
## Полезные материалы
- [Исходный код проекта.](https://git.struchkov.dev/DockerFiles/samba) Форк, который я поддерживаю в актуальном состоянии.
	- [Оригинальный репозиторий на GitHub.](https://github.com/dperson/samba) Не поддерживается и не обновляется.
- [Образ проекта в моем Nexus](https://nexus.struchkov.dev/#browse/browse:docker:v2%2Fsamba%2Ftags)