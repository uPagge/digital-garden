---
aliases:
  - DI
  - внедрение зависимостей
tags:
  - зрелость/🌱
date: "[[2023-10-26]]"
zero-link:
  - "[[00 Архитектура ПО]]"
parents:
  - "[[Inversion of Control]]"
linked:
---
DI, или "внедрение зависимостей", является формой реализации принципа IoC. Это процесс предоставления внешних зависимостей (объектов или компонентов) объекту. Вместо того чтобы объект сам создавал или искал свои зависимости, они ему предоставляются. Это облегчает тестирование и поддержание кода, так как зависимости могут быть легко заменены или подменены.

Сначала, класс без DI:

```java
public class TextEditor {
    private SpellChecker checker;
    
    public TextEditor() {
        this.checker = new SpellChecker(); // Зависимость создается внутри класса.
    }
    
    public void checkSpelling() {
        checker.checkSpelling();
    }
}
```

Теперь, используем DI через конструктор:

```java
public class TextEditor {
    private SpellChecker checker;
    
    // Зависимость передается через конструктор.
    public TextEditor(SpellChecker checker) {
        this.checker = checker;
    }
   
    public void checkSpelling() {
        checker.checkSpelling();
    }
}
```

Во втором примере `SpellChecker` передается в `TextEditor` через конструктор, что позволяет обеспечить гибкость. Вы можете легко заменить `SpellChecker` на другой класс (например, `AdvancedSpellChecker`), не меняя код `TextEditor`.