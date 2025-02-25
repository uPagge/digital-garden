---
aliases: 
tags:
  - maturity/🌱
date: 2025-02-18
---
В этой заметке описывается процесс миграции с [[../../Universal Unique IDentifier|UUID]] на [[Автоинкремент в БД]]

Подготовка и анализ зависимостей
- Нет ли в других таблицах внешних ключей (FK), ссылающихся на старую колонку UUID.
- Проверьте код приложения, API, скрипты: не используют ли они явным образом старый тип ключа или его формат.

Создание нового столбца
- Создайте новую колонку с типом `BIGINT` (или `BIGSERIAL`, если используете PostgreSQL).
- Если требуется, создайте последовательность:

```sql
CREATE SEQUENCE your_table_id_seq;
```

Назначьте этой колонке `DEFAULT`, чтобы при вставке новых данных значение генерировалось автоматически:

```sql
ALTER TABLE your_table
    ALTER COLUMN temp_id SET DEFAULT nextval('your_table_id_seq');
```

Сделайте колонку `NOT NULL` (если уверены, что в ней не должно быть пропусков):

```sql
ALTER TABLE your_table
    ALTER COLUMN temp_id SET NOT NULL;
```

Заполнение новой колонки (бэкфил). Обновите существующие записи, чтобы у каждой строки появилось уникальное значение:
```sql
UPDATE your_table
   SET temp_id = nextval('your_table_id_seq');
```

> [!WARNING] 
> Если важен порядок (например, по дате создания), можно использовать более сложный запрос с сортировкой.

Переключение на новый ключ
- Удалите внешние ключи, если они указывали на старую колонку-ключ.
- Удалите или переименуйте старую колонку:

```sql
ALTER TABLE your_table DROP COLUMN old_uuid_column;
```
или:
```sql
ALTER TABLE your_table RENAME COLUMN old_uuid_column TO uuid_backup;
```

Переименуйте `temp_id` в `id`:
```sql
ALTER TABLE your_table
    RENAME COLUMN temp_id TO id;
```

Добавьте первичный ключ:
```sql
ALTER TABLE your_table
    ADD CONSTRAINT your_table_pkey PRIMARY KEY (id);
```

- Если были внешние ключи, которые ссылаются на старый UUID, обновите их или добавьте новые, ссылающиеся на новую колонку.
- Проверьте код приложения: там, где раньше ожидался UUID, теперь будет число. При необходимости скорректируйте схемы, DTO, сервисы и т. п.
### Пример миграции с Liquibase
Добавление нового столбца с автоинкрементом
```xml
<changeSet id="1" author="dev">
    <addColumn tableName="your_table">
        <column name="temp_id" type="BIGINT" autoIncrement="true"/>
    </addColumn>
</changeSet>
```

Заполнение нового столбца значениями
```xml
<changeSet id="2" author="dev">
    <sql>UPDATE your_table SET temp_id = nextval('your_table_id_seq');</sql>
</changeSet>
```

Удаление старого UUID и установка нового первичного ключа
```xml
<changeSet id="3" author="dev">
    <dropPrimaryKey tableName="your_table" constraintName="your_table_pkey"/>
    <dropColumn tableName="your_table" columnName="old_uuid_column"/>
    <renameColumn tableName="your_table" oldColumnName="temp_id" newColumnName="id"/>
    <addPrimaryKey tableName="your_table" columnNames="id" constraintName="your_table_pkey"/>
</changeSet>
```
***
## Мета информация
**Область**:: [[../../../meta/zero/00 Реляционная база данных|00 Реляционная база данных]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2025-02-18]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

