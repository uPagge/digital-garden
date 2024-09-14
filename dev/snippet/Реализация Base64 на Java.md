---
aliases: 
tags:
  - maturity/🌱
date: 2024-09-14
zero-link:
  - "[[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]"
parents:
  - "[[../other/Base64]]"
linked: 
---

**Кодирование данных в Base64:**
```java
import java.util.Base64;

public class Base64EncodingExample {

    public static void main(String[] args) {
        // Пример строки для кодирования
        String originalString = "This is a test string for Base64 encoding.";

        // Кодирование строки в Base64
        String encodedString = Base64.getEncoder().encodeToString(originalString.getBytes());
        System.out.println("Encoded String: " + encodedString);
    }
}
```

**Декодирование данных из Base64:**
```java
import java.util.Base64;

public class Base64DecodingExample {

    public static void main(String[] args) {
        // Пример закодированной строки Base64
        String encodedString = "VGhpcyBpcyBhIHRlc3Qgc3RyaW5nIGZvciBCYXNlNjQgZW5jb2Rpbmcu";

        // Декодирование строки из Base64
        byte[] decodedBytes = Base64.getDecoder().decode(encodedString);
        String decodedString = new String(decodedBytes);
        System.out.println("Decoded String: " + decodedString);
    }
}
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]
**Родитель**:: [[../other/Base64|Base64]]
**Источник**:: 
**Создана**:: [[2024-09-14]]
**Автор**:: 
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
