---
aliases: 
tags:
  - maturity/🌱
date: "[[2023-11-02]]"
zero-link: 
parents: 
linked:
---
## Проблема
==При создании VIEW в Liquibase возникают проблемы с её поддержкой, поскольку она часто изменяется, особенно когда меняется исходная таблица, используемая вьюхой.== Проблемы усложняются, если к одной таблице привязано несколько вьюх.

После нескольких изменений становится сложно находить актуальный скрипт создания VIEW для его обновления, так как изменения могут быть разбросаны по нескольким файлам или версиям. Например, изменения в логике могут быть внесены в один файл, а изменения в структуре — в другой, что затрудняет сборку актуальной версии скрипта.
## Решение
Для решения этой проблемы все VIEW выносятся в отдельный changeLog файл. Этот changeLog файл всегда указывается в конце master changeLog, так как вьюхи создаются после создания всех необходимых таблиц и данных в базе, чтобы обеспечить их корректность.

Пример master changeLog файла:

```xml
<?xml version="1.1" encoding="UTF-8"?>  
<databaseChangeLog  
       xmlns="http://www.liquibase.org/xml/ns/dbchangelog"  
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  
       xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog  
       http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-latest.xsd">  
  
    <include file="v.1.0.0/changelog.xml" relativeToChangelogFile="true"/>  
    
    <!-- VIEWS -->  
    <include file="views/changelog.xml" relativeToChangelogFile="true"/>  
  
</databaseChangeLog>
```

В changeLog файле для создания вьюх необходимо придерживаться следующего порядка:
- Сначала идет changeSet, который удаляет вьюху, если она уже существует.
- Затем идет changeSet, который создает новую вьюху.

Важным здесь является указывание следующий параметров changeSet-а:
-  `runAlways="true"` — указывает Liquibase всегда выполнять этот changeSet, даже если он был уже выполнен ранее. Это особенно полезно, когда необходимо поддерживать актуальность данных вьюхи после каждого изменения.
- `runOnChange="true"` — указывает Liquibase игнорировать несовпадение контрольной суммы данного changeSet-а. Это важно, когда вносятся изменения в структуру вьюхи, и необходимо обновить её без возникновения ошибок из-за изменения контрольной суммы.

Пример changeSet-ов.

```xml
<?xml version="1.0" encoding="UTF-8"?>  
<databaseChangeLog  
        xmlns="http://www.liquibase.org/xml/ns/dbchangelog"  
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  
        xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-latest.xsd  
        http://www.liquibase.org/xml/ns/dbchangelog http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-latest.xsd">  
  
    <changeSet id="drop-view" author="uPagge" runAlways="true" runOnChange="true">  
        <preConditions onFail="CONTINUE">  
            <viewExists viewName="view_name"/>  
        </preConditions>        
        <dropView viewName="view_name"/>  
    </changeSet>  
    <changeSet id="create-view" author="uPagge" runAlways="true" runOnChange="true">  
        <preConditions onFail="CONTINUE">  
            <not>                
	            <viewExists viewName="view_name"/>  
            </not>        
        </preConditions>        
        <createView viewName="view_name">  
           ...SQL FOR CREATE VIEW...   
        </createView>  
    </changeSet>  
</databaseChangeLog>
```

Таким образом, у нас появляется единое место, которое содержит актуальные структуры наших VIEW.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Базы Данных|00 Базы Данных]]
**Родитель**:: [[Liquibase]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-11-02]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
