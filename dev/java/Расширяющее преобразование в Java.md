---
aliases:
  - widening conversions
tags:
  - maturity/🌱
date: 2024-11-01
---
Расширяющие преобразования (widening conversions) позволяют в Java автоматически преобразовывать значение одного типа к другому, более широкому типу без явного приведения.

```
byte → short → int → long → float → double
                ↑
               char
```

**Потеря точности**:
- int -> float
- long -> float (на больших значениях long)
- long -> double (на больших значениях long)

***
## Мета информация
**Область**:: [[../../meta/zero/00 Java разработка|00 Java разработка]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-11-01]]
**Автор**:: 
### Дополнительные материалы
- [[Сжимающее преобразование в Java]]

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

