---
aliases: 
tags:
  - maturity/🌱
  - content/problem
date: 2023-11-02
---
При создании VIEW в [[../../../../knowledge/dev/Liquibase|Liquibase]] возникают трудности с её поддержкой, особенно когда исходная таблица, меняется. Это становится ещё сложнее, если несколько VIEW ссылаются на одну таблицу. Когда происходят изменения, становится сложно быстро найти актуальный скрипт для создания VIEW, так как изменения могут быть разбросаны по нескольким файлам или версиям.

Для упрощения управления все VIEW выносятся в отдельный changeLog файл. Этот файл всегда указывается в конце основного master changeLog, поскольку VIEW создаются после создания всех таблиц, чтобы обеспечить корректность их работы.

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

Пример `views/changelog.xml`:

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

В файле changeLog для управления вьюхами необходимо соблюдать следующий порядок:
- Сначала используется changeSet, который удаляет вьюху, если она уже существует.
- Затем используется changeSet, который создаёт новую вьюху.

Ключевыми параметрами для changeSet являются:
- `runAlways="true"` — указывает Liquibase всегда выполнять данный changeSet, даже если он уже выполнялся ранее. Это важно для поддержания актуальности данных вьюхи после каждого изменения.
- `runOnChange="true"` — указывает Liquibase игнорировать изменения контрольной суммы для данного changeSet.

Таким образом, вы получите централизованное и актуальное место для управления структурами VIEW, что значительно упростит их поддержку и обновление.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Реляционная база данных|00 Реляционная база данных]]
**Родитель**:: [[Liquibase]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-11-02]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
