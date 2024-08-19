---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-07-03
zero-link:
  - "[[00 RabbitMQ]]"
parents: []
linked: 
---
Сообщения публикуются в очередь не напрямую. Вместо этого Producer отправляет сообщение в Exchange, который отвечает за перенаправление его в нужную [Queue](Queue.md).

![600](Pasted%20image%2020240819134918.png)

Типы Exchange:
- [direct](Exchange%20Direct.md)
- [fanout](Exchange%20Fanout.md)
- [topics](Exchange%20Topics.md)
- [headers](Exchange%20Headers.md)