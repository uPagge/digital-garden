---
aliases: 
tags:
  - maturity/🌱
  - content/problem
date: 2024-10-30
---
Столкнулся со следующей проблемой при подключении к imap. Проблема, заключается в том, что клиент не может завершить SSL/TLS рукопожатие с сервером на портах 993 (IMAPS) и 143 (IMAP с STARTTLS).

```bash
openssl s_client -connect imap.server.name:993

Connecting to 217.30.171.87
CONNECTED(00000005)
40CF76EB01000000:error:0A000126:SSL routines::unexpected eof while reading:ssl/record/rec_layer_s3.c:692:
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 0 bytes and written 332 bytes
Verification: OK
---
New, (NONE), Cipher is (NONE)
This TLS version forbids renegotiation.
Compression: NONE
Expansion: NONE
No ALPN negotiated
Early data was not sent
Verify return co
```

Сообщения об ошибках и поведение указывают на то, что сервер немедленно закрывает соединение после его установления, что препятствует любой дальнейшей коммуникации.

```
error:0A000126:SSL routines::unexpected eof while reading:ssl/record/rec_layer_s3.c:692:
SSL handshake has read 0 bytes and written 332 bytes
```

Клиент отправил 332 байта для инициирования SSL рукопожатия, но не получил никакого ответа от сервера перед закрытием соединения.

Пытаемся подключиться по 143 с STARTTLS (IMAP)
```bash
openssl s_client -starttls imap -connect imap.server.name:143

Didn't find STARTTLS in server response, trying anyway...
error:0A000126:SSL routines::unexpected eof while reading:ssl/record/rec_layer_s3.c:692:
SSL handshake has read 0 bytes and written 358 bytes
```

Похожим образом, сервер не ответил должным образом на попытку клиента инициировать SSL рукопожатие.

```bash
telnet imap.server.name 143

Connected to imap.server.name.
Escape character is '^]'.
Connection closed by foreign host.
```

Сервер принимает TCP-соединение, но сразу же его закрывает без отправки каких-либо данных (например, приветственного баннера IMAP).

Nmap сканирование порта 993:
```bash
nmap -p 993 imap.server.name

PORT    STATE SERVICE
993/tcp open  imaps
```

Порт открыт на уровне TCP, но это не гарантирует, что сервис IMAPS функционирует корректно.

Возможные причины:
- Неправильная конфигурация сервера:
	- Сервисы IMAP/IMAPS могут быть неправильно настроены или не запущены.
	- SSL/TLS сертификаты могут быть неправильно настроены или истекли.
- Брандмауэр или политики безопасности:
	- Брандмауэр или политика безопасности может принимать соединения, но сразу же их закрывать.
	- Сервер может быть настроен на прием соединений только с определенных IP-адресов или сетей.
- Несовместимость протоколов или шифров:
	- Сервер может поддерживать только определенные версии SSL/TLS или шифры, которые не совместимы с настройками вашего клиента OpenSSL.
	- Если сервер поддерживает только устаревшие протоколы (например, SSLv3), современные клиенты могут отказываться от соединения.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Сети|00 Сети]], [[../../meta/zero/00 Криптография|00 Криптография]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-10-30]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

