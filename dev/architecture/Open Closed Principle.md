---
aliases:
  - Open/Closed Principle
  - OCP
  - Принцип открытости/закрытости
tags:
  - maturity/🌱
date: 2024-09-27
zero-link:
  - "[[../../meta/zero/00 Архитектура ПО|00 Архитектура ПО]]"
parents:
  - "[[SOLID|SOLID]]"
linked: 
---
Классы должны быть открыты для расширения, но закрыты для модификации. Это значит, что поведение класса можно расширить без изменения его исходного кода. Обычно это достигается через наследование или использование интерфейсов.

- **Пример нарушения OCP**: Изменение существующего класса для добавления нового функционала (например, новый способ оплаты).
- **Решение**: Использовать интерфейсы или абстрактные классы для расширения функционала без изменения базового кода.

```java
public interface PaymentMethod {
    void pay(double amount);
}

public class CreditCardPayment implements PaymentMethod {
    @Override
    public void pay(double amount) {
        // Оплата через кредитную карту
    }
}

public class PayPalPayment implements PaymentMethod {
    @Override
    public void pay(double amount) {
        // Оплата через PayPal
    }
}
```

***
## Мета информация
**Область**:: [[../../meta/zero/00 Архитектура ПО|00 Архитектура ПО]]
**Родитель**:: [[SOLID|SOLID]]
**Источник**:: 
**Создана**:: [[2024-09-27]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
