---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-02-05
zero-link:
  - "[[00 Базы Данных]]"
parents: 
linked:
---
B MySQL используется метод nested loops, но с оптимизациями.

```sql
SELECT * FROM posts WHERE author = "Peter"
JOIN comments ON posts. id = comments.post_id
```

Индекс по `posts.id` бесполезен. Индекс по `comments.post_id` обязателен.