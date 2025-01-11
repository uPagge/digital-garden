---
aliases: 
tags:
  - maturity/🌱
date: 2024-11-24
---
`ResultSet` — это интерфейс, используемый для хранения и управления результатами SQL-запроса типа SELECT к базе данных. Он позволяет Java-программе извлекать и обрабатывать данные, возвращаемые запросом.

- **Получение данных**: при выполнении запроса SELECT база данных возвращает данные в виде таблицы. `ResultSet` предоставляет доступ к этим данным в Java-коде.
- **Обработка данных**: интерфейс включает методы для навигации по строкам и извлечения значений из текущей строки.
- **Управление данными**: `ResultSet` также позволяет перемещать курсор по строкам данных и получать доступ к столбцам по имени или индексу.

Создание и выполнение запроса
   ```java
   Statement stmt = connection.createStatement();
   ResultSet rs = stmt.executeQuery("SELECT * FROM employees");
   ```

Обработка данных
   ```java
   while (rs.next()) {
       int id = rs.getInt("id");
       String name = rs.getString("name");
       double salary = rs.getDouble("salary");
       System.out.println("ID: " + id + ", Name: " + name + ", Salary: " + salary);
   }
   ```
## Основные методы
Эти методы являются ключевыми для работы с объектом `ResultSet`, позволяя эффективно взаимодействовать с базой данных:

`next()` — перемещает курсор к следующей строке.

  ```java
  rs.next();
  ```

`getInt()`, `getString()`, `getDouble()` и другие get-методы — извлекают данные из текущей строки.

  ```java
  int id = rs.getInt("id");
  String name = rs.getString("name");
  double salary = rs.getDouble("salary");
  ```

`close()` — закрывает ResultSet и освобождает связанные с ним ресурсы.

  ```java
  rs.close();
  ```

`getMetaData()` — возвращает объект `ResultSetMetaData`, содержащий метаданные о результирующем наборе данных, такие как количество столбцов и их типы.

  ```java
  ResultSetMetaData metaData = rs.getMetaData();
  int columnCount = metaData.getColumnCount();
  ```

***
## Мета информация
**Область**:: [[../../meta/zero/00 Java разработка|00 Java разработка]]
**Родитель**:: [[../../../../knowledge/dev/java/other/Java Database Connectivity|Java Database Connectivity]]
**Источник**:: 
**Создана**:: [[2024-11-24]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

