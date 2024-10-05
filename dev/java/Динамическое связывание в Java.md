---
aliases: 
tags:
  - maturity/🌱
date: 2024-10-05
zero-link: 
parents: 
linked:
---
Важной особенностью [[../../../../garden/ru/dev/other/Динамическое связывание|динамического связывания]] в Java является использование **виртуальных методов** — методов, которые могут быть переопределены в наследуемых классах, и выбор нужного метода происходит в зависимости от типа объекта, а не ссылки на него.

Динамическое связывание в Java обеспечивается [[../../../../knowledge/dev/java/JVM|JVM]] через таблицы виртуальных методов (vtable). Когда создается объект, JVM строит таблицу, содержащую указатели на методы, которые могут быть вызваны для данного объекта. Если метод переопределён в подклассе, JVM заменяет соответствующую запись в таблице. Это позволяет JVM выбрать нужный метод во время выполнения, основываясь на фактическом типе объекта.

Ключевые шаги, которые выполняет JVM:
1. Когда вызывается метод через ссылку, JVM проверяет vtable для конкретного типа объекта.
2. Если метод был переопределён, ссылка указывает на новый метод в vtable.
3. Это позволяет избежать необходимости решать, какой метод вызывать, на этапе компиляции.

**Преимущества:**
- **Гибкость.** Позволяет легко реализовывать полиморфизм, давая возможность объектам разных типов обрабатывать вызовы по-разному.
- **Расширяемость.** Классы можно легко расширять или заменять, не изменяя уже существующий код.

**Недостатки:**
- **Производительность.** Динамическое связывание требует дополнительных вычислительных ресурсов для поиска метода во время выполнения.
- **Сложность отладки.** Ошибки, связанные с динамическим связыванием, могут проявиться только во время выполнения, что усложняет их обнаружение.

## Примеры динамического связывания в Java
**Переопределение методов (Method Overriding)**
Динамическое связывание чаще всего проявляется при переопределении методов в классах-наследниках. Когда метод базового класса переопределён в подклассе, JVM выбирает метод для вызова во время выполнения, основываясь на фактическом типе объекта.

```java
class Animal {
    void sound() {
        System.out.println("Animal makes a sound");
    }
}

class Dog extends Animal {
    @Override
    void sound() {
        System.out.println("Dog barks");
    }
}

public class Main {
    public static void main(String[] args) {
        Animal myAnimal = new Dog();  // Ссылка на Animal, объект Dog
        myAnimal.sound();             // Вызывается Dog.sound() благодаря динамическому связыванию
    }
}
```

**Работа с интерфейсами**
Когда класс реализует интерфейс, метод интерфейса может быть реализован по-разному в каждом классе. JVM динамически выбирает метод во время выполнения в зависимости от типа объекта.

```java
interface Shape {
    void draw();
}

class Circle implements Shape {
    public void draw() {
        System.out.println("Drawing a Circle");
    }
}

class Square implements Shape {
    public void draw() {
        System.out.println("Drawing a Square");
    }
}

public class Main {
    public static void main(String[] args) {
        Shape myShape = new Circle();  // Ссылка на Shape, объект Circle
        myShape.draw();                // Вызывается Circle.draw() благодаря динамическому связыванию

        myShape = new Square();        // Ссылка теперь указывает на объект Square
        myShape.draw();                // Вызывается Square.draw()
    }
}
```

**Абстрактные классы**
Когда у нас есть абстрактные классы с абстрактными методами, конкретные реализации этих методов в подклассах также связаны динамически. Фактический метод выбирается во время выполнения программы.

```java
abstract class Animal {
    abstract void sound();
}

class Cat extends Animal {
    @Override
    void sound() {
        System.out.println("Cat meows");
    }
}

class Lion extends Animal {
    @Override
    void sound() {
        System.out.println("Lion roars");
    }
}

public class Main {
    public static void main(String[] args) {
        Animal myAnimal = new Cat();    // Ссылка на Animal, объект Cat
        myAnimal.sound();               // Вызывается Cat.sound() благодаря динамическому связыванию

        myAnimal = new Lion();          // Ссылка теперь указывает на объект Lion
        myAnimal.sound();               // Вызывается Lion.sound()
    }
}
```

**Виртуальные методы**

В Java ==все нестатические методы являются виртуальными по умолчанию, то есть они могут быть переопределены в подклассах и будут динамически связаны на этапе выполнения.== Исключение составляют методы, помеченные как `final`, `private`, или `static`, которые не могут быть переопределены и, соответственно, не требуют динамического связывания.

```java
class Parent {
    void show() {
        System.out.println("Parent's show()");
    }
}

class Child extends Parent {
    @Override
    void show() {
        System.out.println("Child's show()");
    }
}

public class Main {
    public static void main(String[] args) {
        Parent obj = new Child();  // Ссылка на Parent, объект Child
        obj.show();                // Вызывается Child.show() благодаря динамическому связыванию
    }
}
```

**Вызов методов через типы-переменные родительского класса**
Когда у нас есть переменная или ссылка на объект базового типа (например, через тип переменной `Object` или `Animal`), которая ссылается на объект производного класса, вызов методов будет зависеть от фактического типа объекта. Это типичный сценарий динамического связывания.

```java
class Example {
    @Override
    public String toString() {
        return "Example class";
    }
}

public class Main {
    public static void main(String[] args) {
        Object obj = new Example();   // Ссылка на Object, объект Example
        System.out.println(obj);      // Вызывается Example.toString() благодаря динамическому связыванию
    }
}
```

**Работа с коллекциями и их элементами (включая generics)**
При работе с коллекциями, особенно с элементами типа Object, динамическое связывание происходит при вызове методов объектов, которые содержатся в этих коллекциях.

```java
import java.util.ArrayList;

class Animal {
    void sound() {
        System.out.println("Animal makes a sound");
    }
}

class Dog extends Animal {
    @Override
    void sound() {
        System.out.println("Dog barks");
    }
}

public class Main {
    public static void main(String[] args) {
        ArrayList<Animal> animals = new ArrayList<>();
        animals.add(new Dog());  // Добавляем объект Dog в коллекцию типа Animal

        for (Animal animal : animals) {
            animal.sound();  // Вызывается Dog.sound() благодаря динамическому связыванию
        }
    }
}
```

**Приведение типов**
Когда объект приводится к типу родительского класса или интерфейса, динамическое связывание всё равно продолжает работать. Тип ссылки может быть `Animal`, но если объект фактически является `Dog`, будет вызван метод `Dog`, а не `Animal`.

```java
class Bird extends Animal {
    @Override
    void sound() {
        System.out.println("Bird sings");
    }
}

public class Main {
    public static void main(String[] args) {
        Animal myAnimal = new Bird();  // Ссылка на Animal, объект Bird
        myAnimal.sound();              // Вызывается Bird.sound() благодаря динамическому связыванию
    }
}
```

***
## Мета информация
**Область**:: [[../../../../garden/ru/meta/zero/00 Java разработка|00 Java разработка]]
**Родитель**:: [[../../../../garden/ru/dev/other/Динамическое связывание|Динамическое связывание]]
**Источник**:: 
**Создана**:: [[2024-10-05]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

