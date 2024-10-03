---
aliases: 
tags:
  - maturity/🌱
date: 2024-10-04
zero-link: 
parents: 
linked:
---
**Fluent API** — это стиль проектирования API, в котором ==методы возвращают объект, к которому они принадлежат==, позволяя вызывать методы цепочкой (chaining).

**Основные концепции**
- **Method Chaining**. Fluent API позволяет вызывать методы один за другим, что уменьшает количество промежуточных переменных и улучшает читаемость.
- **Самоописывающийся код**. Использование цепочки методов делает код более понятным и логичным, приближая его к естественному языку.

**Где встречается?**
- Фреймворки с реактивным подходом.
- Java Stream
- **Библиотеки для работы с базами данных**. Такие фреймворки, как JPA или Hibernate, используют Fluent API для создания запросов. Например, запросы могут выглядеть так

```java
CriteriaBuilder builder = entityManager.getCriteriaBuilder();
CriteriaQuery<Car> query = builder.createQuery(Car.class);
query.select(query.from(Car.class))
     .where(builder.equal(root.get("color"), "Red"));
```

- **Настройка объектов**. Fluent API часто используется в [[../../../../garden/ru/dev/architecture/Builder Pattern|Builder Pattern]], где объект строится поэтапно через цепочку методов.
- Конфигурация. Например Spring Security, Kafka Streams
- **Фреймворки для тестирования**. Например, в JUnit или AssertJ можно строить цепочки утверждений:

Fluent API часто используется для построения специфических языков (DSL), которые имитируют человеческий язык и делают код максимально самоописательным.

Пример императивного кода
```java
Instant start = Instant.now();
Duration timeout = Duration.ofSeconds(10);
do {
	Thread.sleep(200);
	var entity = repo.get("id");
	if ("EXPECTED".equals(entity.status)) {
		return;
	｝
} while (Instant.now().isBefore(start.plus(timeout)));
throw new AssertionError("Status was not updated to EXPECTED");
```

И аналогичный в стиле Fluent API
```java
Awaitility.await("Entity status should be updated to EXPECTED")
	.atMost(Duration.ofSeconds(10))
	.pollDelay(Duration.ofMillis(200))
	.until(() -> "EXPECTED".equals(repo.get("id").status));
```
## Приемы и подходы
### Method chaining
**Method chaining** — это техника, при которой методы возвращают текущий объект (обычно через `this`), позволяя вызывать несколько методов последовательно в одной строке.

```java {7, 12}
public class Car {
    private String engine;
    private int doors;

    public Car setEngine(String engine) {
        this.engine = engine;
        return this;  // Возвращаем текущий объект
    }

    public Car setDoors(int doors) {
        this.doors = doors;
        return this;
    }
}
```
### Смена контекста
#### С помощью method chaining
Представим, что мы настраиваем серверное приложение с несколькими аспектами: базовая настройка, настройка безопасности, логирования и т.д. Здесь каждый вызов метода переключает нас на новый “контекст”, где мы продолжаем настраивать приложение, но в рамках другой области (например, с безопасности переключаемся на логирование).

```java
public class ServerConfig {

    public ServerConfig http() {
        System.out.println("HTTP basic configuration");
        return this; // Возвращаем тот же объект для продолжения цепочки
    }

    public ServerConfig security() {
        System.out.println("Security configuration");
        return this; // Переключение на контекст безопасности
    }

    public ServerConfig authorizeRequests() {
        System.out.println("Authorization configuration");
        return this; // Переключение на настройку авторизации запросов
    }

    public ServerConfig requestMatchers(String pattern) {
        System.out.println("Configuring request matchers for: " + pattern);
        return this; // Продолжение работы в контексте авторизации
    }

    public ServerConfig csrf() {
        System.out.println("CSRF protection disabled");
        return this; // Переключение на настройку защиты CSRF
    }

    public ServerConfig exceptionHandling() {
        System.out.println("Exception handling configuration");
        return this; // Переключение на обработку исключений
    }

    public Server build() {
        System.out.println("Server is configured and built");
        return new Server();
    }
}

class Server {
    // Имитация запущенного сервера
}
```

```java
Server server = new ServerConfig()
    .http()                     // Контекст базовой настройки HTTP
    .security()                  // Переключение на контекст безопасности
    .authorizeRequests()         // Настройка авторизации запросов
        .requestMatchers("/")    // Настройка доступа для главной страницы
        .requestMatchers("/api") // Настройка доступа к API
    .csrf()                      // Отключение CSRF
    .exceptionHandling()         // Настройка обработки исключений
    .build();                    // Завершаем конфигурацию и запускаем сервер
```
#### С помощью лямбда-выражений
```java
public class ServerConfig {

    public ServerConfig http(Consumer<HttpConfig> httpConfig) {
        System.out.println("Entering HTTP configuration context");
        httpConfig.accept(new HttpConfig());
        return this; // Возвращаем тот же объект для дальнейшей конфигурации
    }

    public ServerConfig security(Consumer<SecurityConfig> securityConfig) {
        System.out.println("Entering Security configuration context");
        securityConfig.accept(new SecurityConfig());
        return this; // Переключение на контекст безопасности
    }

    public ServerConfig logging(Consumer<LoggingConfig> loggingConfig) {
        System.out.println("Entering Logging configuration context");
        loggingConfig.accept(new LoggingConfig());
        return this; // Переключение на контекст логирования
    }

    public Server build() {
        System.out.println("Server is configured and built");
        return new Server();  // Финальный этап — запуск сервера
    }

    // Вложенные классы конфигураций для разных контекстов
    public static class HttpConfig {
        public HttpConfig enableHttp2() {
            System.out.println("HTTP/2 enabled");
            return this;
        }

        public HttpConfig port(int port) {
            System.out.println("Server will listen on port: " + port);
            return this;
        }
    }

    public static class SecurityConfig {
        public SecurityConfig enableTLS() {
            System.out.println("TLS enabled");
            return this;
        }

        public SecurityConfig authorizeRequests(Consumer<RequestAuthorization> authorizationConfig) {
            System.out.println("Authorizing requests...");
            authorizationConfig.accept(new RequestAuthorization());
            return this;
        }
    }

    public static class LoggingConfig {
        public LoggingConfig level(String level) {
            System.out.println("Logging level set to: " + level);
            return this;
        }
    }

    public static class RequestAuthorization {
        public RequestAuthorization permitAll() {
            System.out.println("All requests are permitted");
            return this;
        }

        public RequestAuthorization authenticated() {
            System.out.println("Authenticated requests only");
            return this;
        }
    }
}
```

```java
Server server = new ServerConfig()
    .http(http -> http.enableHttp2().port(8080))  // Настройка HTTP с использованием лямбда-выражения
    .security(security -> security
        .enableTLS()  // Настройка безопасности
        .authorizeRequests(auth -> auth.authenticated()))  // Смена контекста внутри лямбды
    .logging(log -> log.level("INFO"))  // Настройка логирования с помощью лямбда
    .build();  // Финальная сборка сервера
```

### Step building
Позволяет организовать процесс создания объектов или выполнения операций через строго упорядоченные шаги. Хотя этот подход часто используется в [[../../../../garden/ru/dev/architecture/Builder Pattern|Builder Pattern]], он применим и в других контекстах, например, при вызове API, конфигурации сложных процессов, построении запросов и даже в рабочих процессах (workflow).

**Основные концепции**
- **Упорядоченные шаги**. Процесс выполнения операции или создания объекта разделен на несколько этапов (шагов), которые должны выполняться в определённой последовательности. Каждый шаг может представлять собой настройку, изменение состояния или выполнение отдельной операции.
- **Контроль обязательных шагов**. Пошаговая сборка гарантирует, что определенные важные шаги не будут пропущены. Это особенно полезно для процессов, где важно соблюдение последовательности действий или конфигурации обязательных параметров.

**Примеры применения пошаговой сборки**

**Построение SQL-запросов**

```java
public interface SelectStep {
    FromStep select(String... columns);
}

public interface FromStep {
    WhereStep from(String table);
}

public interface WhereStep {
    OrderByStep where(String condition);
}

public interface OrderByStep {
    BuildStep orderBy(String column);
}

public interface BuildStep {
    String build();
}

public class SqlQueryBuilder implements SelectStep, FromStep, WhereStep, OrderByStep, BuildStep {
    private String query;

    @Override
    public FromStep select(String... columns) {
        query = "SELECT " + String.join(", ", columns);
        return this;
    }

    @Override
    public WhereStep from(String table) {
        query += " FROM " + table;
        return this;
    }

    @Override
    public OrderByStep where(String condition) {
        query += " WHERE " + condition;
        return this;
    }

    @Override
    public BuildStep orderBy(String column) {
        query += " ORDER BY " + column;
        return this;
    }

    @Override
    public String build() {
        return query;
    }

    public static SelectStep start() {
        return new SqlQueryBuilder();
    }
}
```

### Самообобщение
Когда мы используем наследование для создания подклассов, возникает проблема, что методы Fluent API могут возвращать не подкласс, а базовый класс, разрывая цепочку вызовов. **Самообобщение** решает эту проблему, позволяя методам возвращать правильный тип подкласса.

**Пример проблемы без самообобщения**. Допустим, у нас есть базовый класс с цепочкой методов, и мы хотим унаследовать этот класс.

```java
class BaseBuilder {
    public BaseBuilder setName(String name) {
        System.out.println("Name set to: " + name);
        return this;
    }
}

class AdvancedBuilder extends BaseBuilder {
    public AdvancedBuilder setFeature(String feature) {
        System.out.println("Feature set to: " + feature);
        return this;
    }
}

public class Main {
    public static void main(String[] args) {
        AdvancedBuilder builder = new AdvancedBuilder();
        builder.setName("MyObject")
               .setFeature("AdvancedFeature"); // Ошибка: возвращается BaseBuilder
    }
}
```

В этом примере `setName()` возвращает тип `BaseBuilder`, поэтому попытка вызвать `setFeature()` на результат этого вызова приведет к ошибке. Метод `setFeature()` будет недоступен.

**Решение с использованием самообобщения (Self-type Generics)**. Мы можем решить эту проблему, используя самообобщение с помощью обобщений (generics). Это позволит методам возвращать **самый специфичный тип**.

```java
class BaseBuilder<T extends BaseBuilder<T>> {
    public T setName(String name) {
        System.out.println("Name set to: " + name);
        return (T) this;  // Возвращаем текущий объект с типом T
    }
}

class AdvancedBuilder extends BaseBuilder<AdvancedBuilder> {
    public AdvancedBuilder setFeature(String feature) {
        System.out.println("Feature set to: " + feature);
        return this;  // Возвращаем текущий объект с типом AdvancedBuilder
    }
}

public class Main {
    public static void main(String[] args) {
        AdvancedBuilder builder = new AdvancedBuilder();
        builder.setName("MyObject")
               .setFeature("AdvancedFeature");  // Теперь работает правильно
    }
}
```
***
## Мета информация
**Область**:: [[../../../../garden/ru/meta/zero/00 Java разработка|00 Java разработка]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-10-04]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

