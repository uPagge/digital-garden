---
aliases: 
tags:
  - maturity/🌱
date: 2024-09-11
zero-link:
  - "[[../../meta/zero/00 Java разработка|00 Java разработка]]"
parents: 
linked: 
---
В [моей библиотеке по конструированию Telegram ботов](https://git.struchkov.dev/Godfather-Bots/telegram-bot) при переходе на [[../../meta/zero/00 Quarkus|Quarkus 3]] возникала проблема. 

Проблема возникает при вызове метода в [библиотеке телеграма](https://mvnrepository.com/artifact/org.telegram/telegrambots) `AbsSender.executeAsync()`. Судя по всему сессии БД зависают и не освобождаются, из-за чего пул сессий заканчивается и возникает следующее исключение:

```shell
024-09-11 11:25:05,060 ERROR [io.qua.arc.imp.AbstractInstanceHandle] (pool-12-thread-1) Error occurred while destroying instance of bean [io.quarkus.hibernate.reactive.runtime.ReactiveSessionProducer_ProducerMethod_createMutinySession_1321d110ee9e92bda147899150401e0a136779c7_Bean]: java.util.concurrent.CompletionException: java.lang.IllegalStateException: HR000069: Detected use of the reactive Session from a different Thread than the one which was used to open the reactive Session - this suggests an invalid integration; original thread [186]: 'vert.x-eventloop-thread-5' current Thread [189]: 'vert.x-eventloop-thread-6'
```

Проблема в том, что в `DefaultAbsSender` есть поле `protected final ExecutorService exe`, который используется в `AbsSender.executeAsync()`. Этот `ExecutorService` никак не изменить, в конструктор не передать, сеттера нет, да и поле `final`. 

Эта особенность приводит к тому, что при использовании вызовов телеграм в контексте работы с [[../../meta/zero/00 Hibernate Reactive|Hibernate Reactive]] мы получаем ситуацию, в которой [[../fundamental/Поток процесса ОС|поток]] меняется. [[../../meta/zero/00 Hibernate Reactive|Hibernate Reactive]] в свою очередь требует, чтобы вся работа выполнялась в рамках одного и того же [[../fundamental/Поток процесса ОС|потока]] из-за особенностей управления сессиями и транзакциями. 

> В [документации](https://hibernate.org/reactive/documentation/2.0/reference/html_single/#_sessions_and_vert_x_contexts) четко сказано: "Сеанс не является потокобезопасным (или "потокобезопасным"), поэтому его использование в разных потоках (или реактивных потоках) может привести к ошибкам, которые крайне трудно обнаружить. Не говорите, что мы вас не предупреждали!"

Решением данной ситуации для своей библиотеки я нашел в следующем. У меня есть `TelegramPollingBot`, который является наследником `DefaultAbsSender`, поэтому в конструкторе я получаю доступ к `final` полю через [[../java/Java Reflection|рефлексию]], далее делаю его изменяемым и устанавливаю `ExecutorService`.

```java
final Field field = this.getClass().getSuperclass().getSuperclass().getDeclaredField("exe");  
// Делаем поле exe доступным для изменений  
field.setAccessible(true);  
// Заменяем поле exe в экземпляре наследника  
field.set(this, Infrastructure.getDefaultWorkerPool());  
// Закрываем доступ к полю exe  
field.setAccessible(false);
```

***
## Мета информация
**Область**:: [[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-09-11]]
**Автор**:: 
### Дополнительные материалы
- [Parallel execution: A Hibernate Reactive Gotcha](https://blog.lunatech.com/posts/2023-05-19-hibernate-reactive-gotchas)