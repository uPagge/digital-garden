---
aliases: 
tags:
  - maturity/🌱
date: 2024-09-14
zero-link:
  - "[[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]"
  - "[[../../meta/zero/00 Криптография|00 Криптография]]"
parents:
  - "[[../cryptography/SHA-256|SHA-256]]"
linked: 
---
Преобразование строки в [[../cryptography/SHA-256|SHA-256]]:

```java
public class SHA {  
  
    public static String hashSha256(String data) {  
        try {  
            final MessageDigest digest = MessageDigest.getInstance("SHA-256");  
            byte[] encodedHash = digest.digest(data.getBytes(StandardCharsets.UTF_8));  
            return bytesToHex(encodedHash);  
        } catch (NoSuchAlgorithmException e) {  
            throw new RuntimeException("Cannot find SHA-256 algorithm", e);  
        }  
    }  
  
    private static String bytesToHex(byte[] hash) {  
        final StringBuilder hexString = new StringBuilder();  
        for (byte b : hash) {  
            String hex = Integer.toHexString(0xff & b);  
            if (hex.length() == 1) {  
                hexString.append('0');  
            }  
            hexString.append(hex);  
        }  
        return hexString.toString();  
    }  
  
}
```

***
## Мета информация
**Область**:: [[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]], [[../../meta/zero/00 Криптография|00 Криптография]]
**Родитель**:: [[../cryptography/SHA-256|SHA-256]]
**Источник**:: 
**Создана**:: [[2024-09-14]]
**Автор**:: 
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
