---
aliases: 
tags:
  - maturity/🌱
date: 2024-11-24
---
1. **Компиляция исходного кода в байт-код:** исходный код (`.java` файлы) компилируется компилятором Java (javac) в [[Java байт-код|байт-код]] (`.class` файлы).
2. **Загрузка байт-кода и классов:** класс-загрузчики [[Java Virtual Machine|JVM]] ([[ClassLoader|Class Loaders]]) загружают байт-код в память по мере необходимости. Сначала загружается основной класс, затем все остальные классы, необходимые для выполнения программы.
3. **Проверка байт-кода:** JVM проверяет байт-код для обеспечения его корректности и безопасности, чтобы предотвратить выполнение некорректного или вредоносного кода.
4. **Интерпретация:** интерпретатор начинает выполнение программы, интерпретируя байт-код в машинный код построчно. Этот этап позволяет сразу начать выполнение программы, не тратя время на полную компиляцию. Однако интерпретация может быть медленной, так как каждая инструкция должна заново преобразовываться в машинный код.
5. **JIT-компиляция:** Чтобы ускорить выполнение, JVM использует Just-In-Time (JIT) компилятор, который преобразует часто выполняемые части байт-кода в машинный код, позволяя процессору выполнять их напрямую.
6. **Сборка мусора:** Сборщик мусора (Garbage Collector) автоматически освобождает память от объектов, которые больше не используются, что предотвращает утечки памяти и снижает нагрузку на разработчика. Это улучшает управление ресурсами и обеспечивает надёжное выполнение программы.

***
## Мета информация
**Область**:: [[../../meta/zero/00 Java разработка|00 Java разр аботка]]
**Родитель**:: [[Java Virtual Machine|JVM]] 
**Источник**:: 
**Создана**:: [[2024-11-24]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

