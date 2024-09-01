---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2023-11-20
zero-link:
  - "[[../../../../garden/ru/meta/zero/00 Java разработка]]"
parents:
  - "[[Снипеты на Java]]"
linked:
  - "[[SpringBoot]]"
article: https://note.struchkov.dev/sozdaniie-linux-siervisa-dlia-prilozhieniia-spring-boot/
---
Для запуска `jar` файла в linux в виде сервиса, необходимо создать файл конфигурации.

```java
sudo nano /etc/systemd/system/app_name_service.service
```

В этот файл вставляем примерно следующее. Не забудьте заменить в выделенных строках `app_path`, `app_name`.

```java
[Unit]
Description=App Description
After=network.target

[Service]
Type=simple
SyslogIdentifier=appdescription
WorkingDirectory=/app_path
PIDFile=/app_path/app_name.pid
ExecStart=/bin/sh -c "exec /usr/bin/java -jar app_name.jar & echo $! > /app_path/app_name.pid"
ExecReload=/bin/kill -s HUP $MAINPID ExecStop=/bin/kill -s QUIT $MAINPID

[Service]
Type=forking
PIDFile=/app_path/app_name.pid

[Install]
WantedBy=default.target
```

Для автоматического запуска приложение после перезагрузки сервиса, используйте следующую команду.

```bash
systemctl enable app_service
```

Чтобы убрать приложения из автозагрузки:

```bash
systemctl disable app_service
```