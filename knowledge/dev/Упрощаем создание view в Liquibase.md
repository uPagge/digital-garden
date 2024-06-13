---
aliases: 
tags:
  - зрелость/🌱
date: "[[2023-11-02]]"
zero-link:
  - "[[00 Разработка]]"
parents:
  - "[[Liquibase]]"
linked:
---
## Проблема
При создании VIEW в Liquibase способом аналогичным таблице возникает проблема поддержки этой VIEW, так как она может часто меняться. Также будет проблема, когда меняется исходная таблица, которую использует вьюха. Еще больше проблем, если к одной таблице подвязано N вьюх. Через пару изменений становится очень сложно находить актуальный скрипт создания VIEW, чтобы его изменить.
## Решение
Для решений этой проблемы все VIEW выносятся в отдельный changeLog файл. Этот changeLog файл всегда будет в конце списка в master changeLog-файле, потому что вьюхи необходимо создавать по уже созданным актуальным базам данных.

Пример master changeLog файла.

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

При этом в chageLog файле для создания вьюх необходимо поддерживать следующий порядок.
- Сначала идет changeSet, который удаляет вьюху, если она уже существует
- Потом идет changeSet, который создает новую вьюху.

Важным здесь является указывание следующий параметров changeSet-а:
- `runAlways="true"` - говорит Liquibase всегда выполнять этот changeSet, даже если он был уже выполнен ранее.
- `runOnChange="true"` - говорит Liquibase игнорировать несовпадение чек-суммы данного changeSet-а.

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

Таким образом у нас появляется единое место, которое содержит актуальные структуры наших VIEW.