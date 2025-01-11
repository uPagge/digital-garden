---
aliases: 
tags:
  - maturity/🌱
date: 2024-09-14
zero-link:
  - "[[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]"
parents:
  - "[[../../../../knowledge/dev/java/other/Jackson|Jackson]]"
linked: 
---
Преобразовать Json строку в java коллекцию через `ObjectMapper` не получится, так как `ObjectMapper` не знает какую коллекцию нужно использовать и какой внутри нее тип данных.

Предварительно необходимо описать структуру вашей коллекции используя `ParameterizedType`.

Пример для `List` и `Map`:
```java {9,14}
import java.lang.reflect.ParameterizedType;

@UtilityClass  
public class CollectionTypes {  
  
    public static final Type LIST_STRINGS = new ParameterizedType() {  
        @Override  
        public Type[] getActualTypeArguments() {  
            return new Type[]{String.class};  
        }  
  
        @Override  
        public Type getRawType() {  
            return List.class;  
        }  
  
        @Override  
        public Type getOwnerType() {  
            return null;  
        }  
    };

	// Map<Long, Double>
	public static final Type MAP_LONG_DOUBLE = new ParameterizedType() {  
	    @Override  
	    public Type[] getActualTypeArguments() {  
	        return new Type[]{Long.class, Double.class};  
	    }  
	  
	    @Override  
	    public Type getRawType() {  
	        return Map.class;  
	    }  
	  
	    @Override  
	    public Type getOwnerType() {  
	        return null;  
	    }  
	};
  
}
```

Метод `getActualTypeArguments()` возвращает типы данных, которые используются в коллекции, а `getRawType()` описывает коллекцию.

Пример использования:
```java
import com.fasterxml.jackson.databind.JavaType;

...

String jsonValue = ...
JavaType javaType = JsonUtils.OBJECT_MAPPER.constructType(CollectionTypes.LIST_STRINGS);
List<String> resultList = finalJsonUtils.OBJECT_MAPPER.readValue(jsonValue, javaType);
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]
**Родитель**:: [[../../../../knowledge/dev/java/other/Jackson|Jackson]]
**Источник**:: 
**Создана**:: [[2024-09-14]]
**Автор**:: 
### Дополнительные материалы
- 