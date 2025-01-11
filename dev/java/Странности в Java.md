---
aliases:
  - polygenelubricants
tags:
  - maturity/🌱
date: 2024-10-30
---
## Арифметические
### Особые числа

- +0.0, -0.0
	- Равны по equals, но различаются по toString
- Double.POSITIVE_INFINITY
	- Больше всякого другого числа, положительное
	- 1/Infinity = 0.0
	- Infinity+1=Infinity, Infinity+Infinity=Infinity
- Double.NEGATIVE_INFINITY
	- Меньше всякого другого числа, отрицательное
	- 1/-Infinity = -0.0
- `Double.NAN`
	- Не больше, не меньше и не равно никакому числу, в том числе себе
	- Любая операция с NaN даст NaN
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
### Хранение массивов в памяти 
```
int[][] table = new int[2][500]; // 4056 байт, 1.4%
int[][] table = new int[500][2]; // 14016 байт, 350.4%
```

- [[../../../../knowledge/dev/java/Устройство объекта в памяти Java|Устройство объекта в памяти Java]]
	- Мы создаём **только 2 объекта массива** (главный массив и два подмассива). На каждый массив выделяется небольшая дополнительная память для служебной информации, связанной с объектом.
	- Мы создаём **500 подмассивов** (главный массив и 500 маленьких подмассивов). На каждый массив также выделяется дополнительная память для служебной информации о каждом объекте.
### polygenelubricants
```java
System.out.println("polygenelubricants".hashCode()); // Integer.MIN_VALUE
```
### Bugaga
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

