---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-07-03
zero-link:
  - "[[00 Архитектура ПО]]"
parents:
  - "[[00 RabbitMQ]]"
linked: 
---
![](Pasted%20image%2020240703091701.png)

- Producer публикует Message в [Exchange](Exchange.md).
- [Exchange](Exchange.md) получает Message и отвечает за его перенаправление. Он берет различные атрибуты, такие как Routing Key, зависимость на тип обмена и другие.
- Создается Binding между [Queue](Queue.md) и [Exchange](Exchange.md)
- Сообщение остается в [Queue](Queue.md) до тех пор, пока не будет обработано Consumer
- Consumer обрабатывает сообщение