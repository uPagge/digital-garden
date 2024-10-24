---
aliases: 
tags:
  - maturity/🌱
date: 2024-10-19
---
Важно понимать, как происходит передача данных в методы. При передаче [[Примитивный тип|примитивных типов]] в метод, копируется **значение** переменной. Это значит, что ==любые изменения, которые вы делаете с переменной внутри метода, не влияют на оригинальную переменную.==

Однако, при передаче [[Ссылочный тип|ссылочных типов]] копируется значение ссылки на объект, а не сам объект. Это значит, что ==если изменить содержимое объекта через эту ссылку, изменения отразятся и на оригинальном объекте==. 

Это часто становится причиной ошибок у новичков, поэтому представьте, что [[Примитивный тип|примитивные типы]] — это как копирование листа бумаги: вы даете кому-то копию, и он может писать на ней, но оригинал останется нетронутым. А [[Ссылочный тип|ссылочные типы]] — это как передача адреса на дом: если кто-то приедет по адресу и изменит что-то в доме, оригинальный дом изменится, даже если у каждого будет только этот “адрес”.

```java
public class Example {
    public static void main(String[] args) {
        int primitive = 5;
        modifyPrimitive(primitive);
        System.out.println("После изменения примитива: " + primitive);  // Выведет 5

        int[] reference = {1, 2, 3};
        modifyReference(reference);
        System.out.println("После изменения ссылочного типа: " + reference[0]);  // Выведет 100
    }

    public static void modifyPrimitive(int number) {
        number = 10;  // Изменение копии примитива, оригинал не затронут
    }

    public static void modifyReference(int[] array) {
        array[0] = 100;  // Изменение объекта по ссылке, оригинальный массив изменится
    }
}
```
- В примере с примитивным типом (int), значение переменной primitive не изменяется, потому что в метод передаётся копия значения.
- В примере с массивом (ссылочный тип), изменяется оригинальный объект, так как в метод передается ссылка на массив, и мы изменяем содержимое этого объекта через ссылку.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Java разработка|00 Java разработка]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-10-19]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

