---
aliases: 
tags:
  - maturity/🌱
date: "[[2023-11-09]]"
zero-link:
  - "[[../../../meta/zero/00 Hibernate|00 Hibernate]]"
  - "[[../../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]"
parents: 
linked: 
---
Чтобы каждый раз не искать эти проперти оставлю их тут.
## SpringBoot
```yml
spring: 
	jpa: 
		show-sql: true 
		properties: 
			hibernate: 
				format_sql: true
```

![](../../../meta/files/images/Pasted%20image%2020231109104008.png)

Если требуется добавить вывод аргументов, то добавляем еще

```yaml
logging: 
	level: 
		org: 
			hibernate: 
				type: trace
```

![](../../../meta/files/images/Pasted%20image%2020231109104112.png)
## Quarkus
```yml
quarkus: 
	hibernate-orm: 
		log: 
			sql: true 
			format-sql: true 
			bind-parameters: true
```

![](../../../meta/files/images/Pasted%20image%2020231109104248.png)