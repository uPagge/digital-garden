---
aliases:
  - polygenelubricants
tags:
  - maturity/🌱
date: 2024-10-30
---
## Арифметические
### Отсутствие переполнения
```java
System.out.println(-Integer.MIN_VALUE) // -2147483648
```

Можно использовать `Math.negateExact()`, чтобы получить исключение

```java
Math.negateExact(Integer.MIN_VALUE)
```

### Абсолютное значение
```java
Math.abs(-Integer.MIN_VALUE) // -2147483648
```

### Character
```java
System.out.println(Character.isDigit('⑤')); // false
System.out.println(Character.getNumericValue('⑤') == 5); // true
```
## Прочее
### polygenelubricants
```java
System.out.println("polygenelubricants".hashCode()); // Integer.MIN_VALUE
```
### 
```java
class Hello {
	public static void main(String[] args) {
		// Безобидный комментарий \u000a System.out.println("Bugaga") ;
		System.out.println("Hello World");
	}
}
```

Sout:
```
Bugaga
Hello World
```


***
## Мета информация
**Область**:: [[../../meta/zero/00 Java разработка|00 Java разработка]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-10-30]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

