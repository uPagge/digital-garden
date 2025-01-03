---
aliases:
  - HTTP
tags:
  - maturity/🌱
date: 2024-10-29
---
HTTP (англ. HyperText Transfer Protocol) — протокол передачи гипертекста, функционирующий на прикладном уровне. Первоначально создан для передачи HTML-документов, теперь используется для работы с произвольными типами данных, такими как изображения, JSON, видео и другие.

HTTP-сообщения состоят из следующих элементов:
- **Стартовая строка** — определяет тип сообщения:
	- Для запросов включает метод (например, GET) и URL.
	- Для ответов включает код состояния (например, 200 OK).
- **HTTP-заголовки** — строки вида параметр: значение, которые описывают сообщение:
	- Например, Content-Type: application/json определяет формат тела сообщения.
- **Пустая строка** — разделяет заголовки и тело сообщения.
- **Тело сообщения** — содержит данные, передаваемые между клиентом и сервером. Например, в запросе POST тело может содержать JSON с информацией для сервера.

**Простая структура HTTP-запроса:**
```HTTP
GET /api/resource HTTP/1.1
Host: example.com
Authorization: Bearer my-token
```

**Ответ сервера:**
```HTTP
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 123

{
  "message": "Success",
  "data": []
}
```

- [[Cookie|Cookie]]
- [[HTTP over SSL or TLS|HTTP over SSL/TLS]]

![[../../meta/files/images/Pasted image 20241103014445.png]]

**Версии HTTP**
- [[HTTP 1|HTTP/1.1]]:
	- Широко распространен.
	- Поддержка постоянных соединений (keep-alive)
- [[HTTP 2|HTTP/2]]:
	- Использует бинарный формат (вместо текстового).
	- Поддержка мультиплексирования (одновременная отправка нескольких запросов в одном соединении).
- [[HTTP 3|HTTP/3]]:
	- Основан на протоколе QUIC (работает поверх [[../../../../knowledge/dev/network/UDP|UDP]]).
	- Улучшенная скорость соединений.
## Http методы
Методы HTTP определяют действия, которые клиент хочет выполнить на сервере:
- **GET**: Получение данных с сервера.
- **HEAD**: Запрос только заголовков ресурса, без тела.
- **POST**: Отправка данных на сервер для создания ресурса.
- **PUT**: Обновление или замена существующего ресурса.
- **DELETE**: Удаление ресурса.
- **OPTIONS**: Запрос информации о поддерживаемых сервером методах.

Дополнительно есть методы, такие как PATCH (частичное обновление) и TRACE (трассировка маршрута сообщения).
## HTTP заголовки
Заголовки в HTTP структурируют метаинформацию сообщения. Пример заголовков:

```http
Content-Type: application/json
Authorization: Bearer token
Cache-Control: no-cache
```

Заголовки подразделяются на четыре основные группы:
- **General Headers** — общие для запросов и ответов:
	- Cache-Control: управление кешированием.
	- Date: время отправки сообщения.
- **Request Headers** — используются только в запросах:
	- Accept: указывает желаемый формат ответа.
	- Authorization: передача токена аутентификации.
- **Response Headers** — характерны для ответов сервера:
	- Server: информация о сервере.
	- Set-Cookie: установка cookies.
- **Entity Headers** — сопровождают тело сообщения:
	- Content-Type: тип содержимого.
	- Content-Length: размер тела в байтах.

Разработчики могут создавать собственные заголовки. Префикс `X-` традиционно указывает, что заголовок нестандартный.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Сети|00 Сети]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-11-03]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
<!-- SerializedQuery: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
- [[Cookie]]
- [[Chunked transfer encoding]]
- [[Условный GET запрос]]
- [[HTTP 2]]
- [[HTTP 1]]
- [[HTTP 3]]
- [[HTTP over SSL or TLS]]
<!-- SerializedQuery END -->

