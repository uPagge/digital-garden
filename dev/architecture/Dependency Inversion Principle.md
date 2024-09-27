---
aliases:
  - DIP
  - Принцип инверсии зависимостей
tags:
  - maturity/🌱
date: 2024-09-27
zero-link:
  - "[[../../meta/zero/00 Архитектура ПО|00 Архитектура ПО]]"
parents:
  - "[[SOLID|SOLID]]"
linked:
---
Высокоуровневые модули не должны зависеть от низкоуровневых модулей. Оба должны зависеть от абстракций. Это означает, что классы не должны напрямую зависеть от конкретных реализаций, вместо этого они должны работать с абстракциями (интерфейсами или абстрактными классами). Это делает код гибким и легко расширяемым.

- **Пример нарушения DIP**: Высокоуровневый модуль напрямую использует конкретный класс, что приводит к жёсткой связности.
- **Решение**: Заменить зависимости на интерфейсы и внедрять зависимости через инверсии (например, через конструктор или контейнеры зависимостей).

```java
public class Lamp {
    public void turnOn() {
        // Лампа включена
    }
}

public class Switch {
    private Lamp lamp;

    public Switch(Lamp lamp) {
        this.lamp = lamp;
    }

    public void toggle() {
        lamp.turnOn(); // Нарушение DIP — жесткая зависимость от класса Lamp
    }
}
```

Исправление с использованием интерфейсов:
```java
public interface Switchable {
    void turnOn();
}

public class Lamp implements Switchable {
    public void turnOn() {
        // Лампа включена
    }
}

public class Switch {
    private Switchable device;

    public Switch(Switchable device) {
        this.device = device;
    }

    public void toggle() {
        device.turnOn(); // Теперь зависимость инверсирована — Switch зависит от абстракции
    }
}
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Архитектура ПО|00 Архитектура ПО]]
**Родитель**:: [[SOLID]]
**Источник**:: 
**Создана**:: [[2024-09-27]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
