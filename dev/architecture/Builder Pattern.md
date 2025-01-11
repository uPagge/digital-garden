---
aliases: 
tags:
  - maturity/🌱
date: 2024-10-04
zero-link: 
parents: 
linked:
---
Builder Pattern — это [[порождающий паттерн проектирования]], который используется для пошагового создания сложных объектов. Этот паттерн особенно полезен, когда объект может иметь множество конфигураций или параметров, которые делают его создание через конструкторы неудобным или даже невозможным.

Основные концепции
- **Разделение построения и представления**. Билдер позволяет отделить логику создания объекта от его конечной структуры. Это делает код более чистым и поддерживаемым.
- **Пошаговая сборка**. Позволяет добавлять параметры или части объекта последовательно, при этом сам процесс создания может контролироваться и меняться независимо от основной логики объекта.
- **Иммутабельность**. Паттерн билдер часто применяется для создания неизменяемых объектов. После сборки объекта его нельзя изменить, что улучшает предсказуемость и безопасность.

## Пример применения
Рассмотрим создание объекта `Car`, у которого много настроек, таких как тип двигателя, количество дверей, цвет и т.д.

Без использования паттерна «Билдер» мы можем столкнуться с такой проблемой: необходимо создавать различные конструкторы, что ухудшает читаемость и поддержку кода. Паттерн «Билдер» помогает избежать этого, при этом используя [[Fluent API|fluent API]] стиль — подход, при котором методы возвращают сам объект билдера, позволяя вызывать их цепочкой. Это делает код более выразительным и легким для чтения.

```java
public class Car {
    private String engine;
    private int doors;
    private String color;

    private Car(CarBuilder builder) {
        this.engine = builder.engine;
        this.doors = builder.doors;
        this.color = builder.color;
    }

    public static class CarBuilder {
        private String engine;
        private int doors;
        private String color;

        public CarBuilder setEngine(String engine) {
            this.engine = engine;
            return this;
        }

        public CarBuilder setDoors(int doors) {
            this.doors = doors;
            return this;
        }

        public CarBuilder setColor(String color) {
            this.color = color;
            return this;
        }

        public Car build() {
            return new Car(this);
        }
    }
    
}
```

Использование паттерна:
```java
Car car = new Car.CarBuilder()
    .setEngine("V8")
    .setDoors(4)
    .setColor("Red")
    .build();

System.out.println(car);
```

**Преимущества**
1. **Чистый код**. Конфигурация объектов становится ясной и понятной, даже если у объекта множество параметров.
2. **Гибкость в создании объектов**. Можно не указывать все параметры сразу, а добавлять их по мере необходимости, что делает процесс сборки более гибким.
3. **Поддержка иммутабельности**. Объекты могут быть неизменяемыми после создания, так как параметры устанавливаются только в процессе сборки.
4. **Минимизация перегрузок конструкторов**. Это позволяет избежать множества конструкторов для различных комбинаций параметров.

**Недостатки**
- **Усложнение кода**. Добавление класса-билдера может увеличить объем кода, особенно если объект не настолько сложен, чтобы оправдать использование паттерна.
- **Многословность**. Если объект требует только нескольких параметров, то использование билдера может казаться излишним и создавать ненужную многословность.

**Когда применять?**
- Когда объект имеет множество конфигураций и параметров.
- Когда нужен гибкий процесс создания объектов с возможностью пошагового добавления параметров.
- Когда объект должен быть неизменяемым, и после сборки его состояние не должно меняться.

## Продвинутый билдер
### Обязательные поля
Одной из распространенных проблем является ==отсутствие явного указания на обязательные поля== при использовании билдера. Если объект имеет поля, которые обязательны для заполнения (например, идентификатор или имя), но их установка не контролируется билдером, это может привести к созданию некорректных или невалидных объектов.

**Решение**:
- Обязательные поля можно передавать через конструктор билдера, чтобы их указание было обязательным. Остальные параметры можно указывать через цепочку методов.

Пример:
```java
public class Car {
    private final String engine;  // Обязательное поле
    private final String model;   // Обязательное поле
    private int doors;            // Необязательное поле
    private String color;         // Необязательное поле

    // Приватный конструктор для сборки объекта через билдер
    private Car(CarBuilder builder) {
        this.engine = builder.engine;
        this.model = builder.model;
        this.doors = builder.doors;
        this.color = builder.color;
    }

    // Статический метод для создания билдера с обязательными полями
    public static CarBuilder builder(String engine, String model) {
        return new CarBuilder(engine, model);
    }

    public static class CarBuilder {
        private final String engine;  // Обязательное поле
        private final String model;   // Обязательное поле
        private int doors = 4;        // Значение по умолчанию
        private String color = "Black";  // Значение по умолчанию

        // Конструктор билдера с обязательными полями
        public CarBuilder(String engine, String model) {
            if (engine == null || engine.isEmpty()) {
                throw new IllegalArgumentException("Engine is required");
            }
            if (model == null || model.isEmpty()) {
                throw new IllegalArgumentException("Model is required");
            }
            this.engine = engine;
            this.model = model;
        }

        // Методы для установки необязательных полей
        public CarBuilder setDoors(int doors) {
            this.doors = doors;
            return this;
        }

        public CarBuilder setColor(String color) {
            this.color = color;
            return this;
        }

        // Метод для сборки объекта Car
        public Car build() {
            return new Car(this);
        }
    }
}
```

Теперь обязательные поля передаются при создании билдера:
```java
Car car = Car.builder("V8", "Sedan")  // Передача обязательных полей через статический метод
    .setDoors(2)                      // Опциональные поля
    .setColor("Red")
    .build();
```
### Валидация создания объекта
Ещё одна частая проблема заключается в том, что во время процесса построения ==не проверяются ограничения на совместимость полей.== Например, не всегда проверяется корректность значений или логика взаимодействия между параметрами, что может привести к созданию некорректного объекта.

**Решение**:
Добавляйте в билдер логику валидации и проверки состояния перед созданием объекта. Это позволит убедиться, что все параметры совместимы и объект корректен.

Пример:
```java
public Car build() {
    if (doors < 2 || doors > 6) {
        throw new IllegalArgumentException("Invalid number of doors");
    }
    return new Car(this);
}
```
### Многократный вызов методов
Когда методы билдера вызываются несколько раз, каждый вызов может перезаписывать значение параметра, что может остаться незамеченным или вызвать непредсказуемое поведение.

Предположим, что у нас есть билдер для создания объекта `Car`, и метод для установки количества дверей (`setDoors`) был вызван дважды:
```java
Car car = new Car.CarBuilder("V8")
    .setDoors(4)
    .setDoors(2)  // Этот вызов перезапишет предыдущее значение
    .setColor("Red")
    .build();
```

В результате объект car будет создан с двумя дверями, хотя программист мог ожидать, что будет 4 двери (из-за первого вызова). Такая ситуация особенно распространена, когда объект конфигурируется динамически, или когда несколько разработчиков работают с билдером, не зная всех деталей.
#### Возможные решения проблемы
**Введение проверок на повторный вызов.** Чтобы избежать многократных вызовов одного и того же метода, можно добавить логику проверки, которая будет отслеживать, был ли метод уже вызван ранее. Если метод вызывается повторно, можно выбросить исключение или проигнорировать повторный вызов.

```java
public static class CarBuilder {
    private String engine;
    private int doors;
    private String color;
    private boolean doorsSet = false;  // Флаг, указывающий на то, что метод setDoors уже был вызван

    public CarBuilder(String engine) {
        this.engine = engine;
    }

    public CarBuilder setDoors(int doors) {
        if (doorsSet) {
            throw new IllegalStateException("Doors can only be set once");
        }
        this.doors = doors;
        doorsSet = true;
        return this;
    }

    public CarBuilder setColor(String color) {
        this.color = color;
        return this;
    }

    public Car build() {
        return new Car(this);
    }
}
```

**Логирование перезаписи параметров.** Если необходимо разрешить многократные вызовы методов, но при этом важно отслеживать перезапись параметров, можно добавлять логирование, чтобы было видно, когда параметр перезаписывается новым значением.

```java
public CarBuilder setDoors(int doors) {
    if (this.doors != 0) {
        System.out.println("Warning: Doors value is being overwritten from " + this.doors + " to " + doors);
    }
    this.doors = doors;
    return this;
}
```

 **Использование** [[Fluent API#Step building|Fluent API Step building]]. Позволит конфигурировать объект в определенной последовательности.
 
```java
public class Car {
    private final String engine;  // Обязательное поле
    private final int doors;      // Обязательное поле
    private final String color;   // Обязательное поле

    // Приватный конструктор для сборки через пошаговую сборку
    private Car(String engine, int doors, String color) {
        this.engine = engine;
        this.doors = doors;
        this.color = color;
    }

    // Интерфейс для первого шага: выбор двигателя
    public interface EngineStep {
        DoorsStep setEngine(String engine);
    }

    // Интерфейс для второго шага: выбор дверей
    public interface DoorsStep {
        ColorStep setDoors(int doors);
    }

    // Интерфейс для третьего шага: выбор цвета
    public interface ColorStep {
        BuildStep setColor(String color);
    }

    // Интерфейс для финального шага: завершение сборки
    public interface BuildStep {
        Car build();
    }

    // Класс, который реализует пошаговую сборку
    public static class Builder implements EngineStep, DoorsStep, ColorStep, BuildStep {
        private String engine;
        private int doors;
        private String color;

        @Override
        public DoorsStep setEngine(String engine) {
            this.engine = engine;
            return this;
        }

        @Override
        public ColorStep setDoors(int doors) {
            this.doors = doors;
            return this;
        }

        @Override
        public BuildStep setColor(String color) {
            this.color = color;
            return this;
        }

        @Override
        public Car build() {
            return new Car(engine, doors, color);
        }
    }

    // Метод для запуска пошаговой сборки
    public static EngineStep builder() {
        return new Builder();
    }
}
```

***
## Мета информация
**Область**:: [[../../meta/zero/00 Разработка|00 Разработка]]
**Родитель**:: [[Порождающий паттерн проектирования]]
**Источник**:: 
**Создана**:: [[2024-10-04]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

