---
aliases: 
tags:
  - maturity/🌱
date: 2024-09-10
zero-link:
  - "[[../../../meta/zero/00 Quarkus|00 Quarkus]]"
  - "[[../../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]"
parents: 
linked: 
---
`StartupEvent` позволяет выполнить операции после запуска сервиса

```java
@ApplicationScoped  
public class StartUp {  
  
    void onStart(@Observes StartupEvent event) {  
        
    }  
  
}
```

Но может возникнуть проблема с контекстом кваркуса. 

```log
ERROR [io.qua.mut.run.MutinyInfrastructure] - Mutiny had to drop the following exception: java.lang.IllegalStateException: No current Vertx context found
```

Для ее решения можно сделать следующее:

```java
@ApplicationScoped  
public class StartUp {  
  
    void onStart(@Observes StartupEvent event) {  
        Unis.voidItem()  
			.emitOn(MutinyHelper.executor(vertx))
			.subscribe().with(  
			    ok -> {},  
		        th -> {}
        )
    }  
  
}

@UtilityClass  
public class VertxHelper {  
  
    public static Executor getExecutor(Vertx vertx) {  
        final Context currentContext = Vertx.currentContext();  
        if (checkNotNull(currentContext)) {  
            return MutinyHelper.executor(currentContext);  
        } else {  
            return MutinyHelper.executor(vertx);  
        }  
    }  
  
}
```

В самом начале пайпа мы добавляем `.emitOn(MutinyHelper.executor(vertx))`, который создает нам контекст.

***
## Мета информация
**Область**:: 
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-09-10]]
**Автор**:: 
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
