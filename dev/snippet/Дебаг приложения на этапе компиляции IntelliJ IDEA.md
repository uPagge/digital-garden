---
aliases: 
tags:
  - maturity/🌱
date:
  - - 2024-04-07
zero-link:
  - "[[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]"
parents: 
linked: 
link: https://struchkov.dev/blog/ru/java-debugging-annotation-processor/
---
Я столкнулся с необходимостью дебага annotation processor, когда писал библиотеку со своими аннотациями и обработчиками к ним. Проблема заключается в том, что обработка аннотаций происходит на этапе компиляции.
## 1. Создание Remote JVM Debug Configuration
Создаем новую конфигурацию. Вам нужно найти: “Remote JVM Debug”.

![](../../meta/files/images/Pasted%20image%2020240407184559.png)

Выберите режим “Attach to remote JVM” и любой доступный порт, например 8000.

![](../../meta/files/images/Pasted%20image%2020240407184611.png)

## 2. Убедитесь, что процесс сборки использует ваш порт
Нажмите `Ctrl+Shift+A` и найдите пункт “Edit Custom VM Options…”

Добавьте новую строку `-Dcompiler.process.debug.port=8000` и ==перезапустите IDEA.==

![](../../meta/files/images/Pasted%20image%2020240407184626.png)
## 3. Включите “Debug build process”
Нажмите `Ctrl+Shift+A` и пункт “Debug build process”.

> [!WARNING] 
> Вам нужно будет повторять этот шаг каждый раз при перезапуске IDEA.
## 4. Дебажим
Сначала установите точку останова в коде обработчика аннотаций.

![](Pasted%20image%2020240407184705.png)

Для запуска вашего обработчика аннотаций пересоберите проект: `Build -> Rebuild Project`. ==При выборе пункта Build Project обработчик аннотации может не запуститься.==

Процесс сборки приостановится, и вы сможете подключить отладчик:

![](../../meta/files/images/Pasted%20image%2020240407184716.png)

Теперь запустите добавленную вами конфигурацию в режиме Debug (Shift+F9). Javac возобновит компиляцию. IDEA теперь должна остановиться на установленной вами точке останова.

![](../../meta/files/images/Pasted%20image%2020240407184727.png)

На этом все, теперь вы можете отлаживать ваши обработчики аннотаций.