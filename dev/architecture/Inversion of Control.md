---
aliases:
  - IoC
tags:
  - maturity/🌱
date: 2023-10-26
zero-link:
  - "[[../../meta/zero/00 Архитектура ПО|00 Архитектура ПО]]"
parents:
  - "[[Архитектурная концепция]]"
linked:
---
Inversion of Control (IoC) — это [[архитектурная концепция]], которая заключается в передаче управления зависимостями программы от самого кода к внешней системе. Обычно, если один объект зависит от другого, он сам создаёт или запрашивает его. В IoC этот процесс контролируется извне, что позволяет программам быть более гибкими и легко расширяемыми.

Простой пример: допустим, у вас есть класс, который зависит от другого класса для выполнения своей работы. В обычном подходе класс сам создаёт объект-зависимость. 

```java
class Engine {
    public void start() {
        System.out.println("Engine started");
    }
}

class Car {
    private Engine engine;

    public Car() {
        // Класс Car сам создает зависимость
        this.engine = new Engine();
    }

    public void drive() {
        engine.start();
        System.out.println("Car is moving");
    }
}

public class Main {
    public static void main(String[] args) {
        Car car = new Car();
        car.drive();
    }
}
```

С использованием **IoC**, создание объекта Engine передаётся внешнему компоненту. Теперь Car не отвечает за создание своей зависимости:

```java
class Engine {
    public void start() {
        System.out.println("Engine started");
    }
}

class Car {
    private Engine engine;

    // Зависимость передается через конструктор (IoC)
    public Car(Engine engine) {
        this.engine = engine;
    }

    public void drive() {
        engine.start();
        System.out.println("Car is moving");
    }
}

public class Main {
    public static void main(String[] args) {
        // Создание зависимостей осуществляется снаружи
        Engine engine = new Engine();
        Car car = new Car(engine);
        car.drive();
    }
}
```

IoC помогает реализовать принципы [[../../../../garden/ru/dev/architecture/SOLID|SOLID]], особенно [[../../../../garden/ru/dev/architecture/Dependency Inversion Principle|Принцип инверсии зависимостей]] (Dependency Inversion Principle, DIP), согласно которому высокоуровневые модули не должны зависеть от низкоуровневых модулей напрямую. Оба типа модулей должны зависеть от абстракций. В контексте IoC это означает, что классы не должны напрямую создавать свои зависимости, а получать их через интерфейсы или внешние механизмы. Такой подход упрощает замену реализаций, тестирование и расширение приложения.

**Преимущества IoC**
- **Ослабление связности кода**. Поскольку классы не создают свои зависимости напрямую, их связь с конкретными реализациями уменьшается. Это облегчает изменение или замену зависимостей без изменения самого класса.
- **Упрощение тестирования**. IoC позволяет легко заменять реальные зависимости на тестовые (например, mock-объекты), что упрощает процесс модульного тестирования. Вы можете изолировать классы и тестировать их независимо от реальных зависимостей.
- **Лучшая расширяемость**. Система, построенная на принципах IoC, легче адаптируется к изменениям и новым требованиям. Новые зависимости могут быть добавлены или изменены без значительного изменения существующего кода.
- **Разделение ответственности**. С IoC создаётся чёткое разделение между бизнес-логикой и управлением зависимостями. Это помогает сосредоточить внимание на основной функциональности класса, не отвлекаясь на вопросы создания объектов.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Архитектура ПО|00 Архитектура ПО]]
**Родитель**:: [[Архитектурная концепция]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2023-10-26]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
<!-- SerializedQuery: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
- [[Dependency Injection]]
<!-- SerializedQuery END -->