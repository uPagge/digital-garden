---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-05-17
zero-link:
  - "[[00 Hibernate]]"
parents: 
linked:
---
Конвертеры в Hibernate позволяют изменить тип хранения в БД. Например, у нас в колонке будет храниться строка "POST, GET, PUT", а в Java мы хотим сразу получать `Set<String>`, а не строку, для этого нужно написать конвертер.

Создаем класс-конвертер, который будет преобразовывать строку в `Set<String>` и обратно:

```java
import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

@Converter
public class StringSetConverter implements AttributeConverter<Set<String>, String> {

    @Override
    public String convertToDatabaseColumn(Set<String> attribute) {
        if (attribute == null || attribute.isEmpty()) {
            return "";
        }
        return attribute.stream().collect(Collectors.joining(", "));
    }

    @Override
    public Set<String> convertToEntityAttribute(String dbData) {
        if (dbData == null || dbData.isEmpty()) {
            return new HashSet<>();
        }
        return Arrays.stream(dbData.split(", "))
                     .collect(Collectors.toSet());
    }
}

```

Используем этот конвертер в нашей сущности:

```java
import io.quarkus.hibernate.orm.panache.PanacheEntity;
import javax.persistence.Convert;
import javax.persistence.Entity;
import java.util.Set;

@Entity
public class MyEntity extends PanacheEntity {

    @Convert(converter = StringSetConverter.class)
    public Set<String> methods;

    // остальные поля и методы
}

```

Можно также использовать `@Converter(autoApply = true)`, чтобы данный конвертер автоматически применялся ко всем полям соответствующего типа в любых сущностях, где это возможно. Другими словами, если у вас есть несколько сущностей с полями типа `Set<String>`, этот конвертер будет автоматически применяться ко всем этим полям без необходимости явно указывать его с помощью `@Convert`.