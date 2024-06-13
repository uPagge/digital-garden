---
aliases: 
tags:
  - зрелость/🌱
date: "[[2023-11-09]]"
zero-link:
  - "[[00 Java разработка]]"
parents:
  - "[[00 Hibernate]]"
linked: 
---
## SpringBoot
```yml
spring: 
	jpa: 
		show-sql: true 
		properties: 
			hibernate: 
				format_sql: true
```

![](Pasted%20image%2020231109104008.png)

Если требуется добавить вывод аргументов, то добавляем еще

```yaml
logging: 
	level: 
		org: 
			hibernate: 
				type: trace
```

![](Pasted%20image%2020231109104112.png)
## Quarkus
```yml
quarkus: 
	hibernate-orm: 
		log: 
			sql: true 
			format-sql: true 
			bind-parameters: true
```

![](Pasted%20image%2020231109104248.png)

## Дополнительные материалы
- [Логирование sql в SpringBoot Hibernate](https://note.struchkov.dev/sql-logging/)