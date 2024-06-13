---
aliases:
  - IoC
tags:
  - зрелость/🌱
date: "[[2023-10-26]]"
zero-link:
  - "[[00 Архитектура ПО]]"
parents:
  - "[[Паттерны программирования]]"
linked:
---
IoC, или "инверсия управления", является принципом программирования, при котором управление потоком программы переносится на внешние или обобщенные средства. Вместо того чтобы программист сам контролировал поток выполнения программы, это делает внешний "контроллер". Это помогает улучшить модульность и гибкость программы.

В случае с IoC, пример может быть таким:
```java
public class Application {
    private Service service;
    
    public Application(Service service) {
        this.service = service;
    }
    
    public void start() {
        service.serve();
    }
}

public class IoCContainer {
    public static void main(String[] args) {
        Service service = new ServiceImpl(); // Контролирование создания объекта и его жизненного цикла вынесено за пределы самого объекта.
        Application app = new Application(service);
        app.start();
    }
}
```

Здесь `IoCContainer` контролирует создание и управление объектами `Service` и `Application`, а не сами эти объекты. Это позволяет сделать код более гибким и модульным.