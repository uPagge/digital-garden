---
aliases:
  - Hibernate Reactive
tags:
  - type/zero-link
zero-link:
  - "[[00 Hibernate|00 Hibernate]]"
parents: 
linked: 
title: Hibernate Reactive
---
- [[../../dev/snippet/Проблема с Hibernate Reactive в Telegram SDK для Java|Проблема с Hibernate Reactive в Telegram SDK для Java]]

В [документации](https://hibernate.org/reactive/documentation/2.0/reference/html_single/#_sessions_and_vert_x_contexts) сказано: "Сеанс не является потокобезопасным (или "потокобезопасным"), поэтому его использование в разных потоках (или реактивных потоках) может привести к ошибкам, которые крайне трудно обнаружить. Не говорите, что мы вас не предупреждали!"