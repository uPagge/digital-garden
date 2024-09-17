---
aliases: 
tags:
  - maturity/🌱
date: 2023-11-20
zero-link:
  - "[[../../../../garden/ru/meta/zero/00 Снипеты для Java|00 Снипеты для Java]]"
parents:
  - "[[../../../../knowledge/dev/java/other/Jackson|Jackson]]"
linked: 
---
Чаще всего по работе я сталкиваюсь с проблемой десериализации и сериализации даты. Многие разработчики отступают от стандартного формата времени `yyyy-MM-dd'T'HH:mm:ss*SSSZZZZ` и изобретают свои форматы.

К сожалению, в Jackson не заложены все возможные форматы даты, поэтому необходимо написать свой десериализатор.
## Десериализация
В данном случае это преобразование json формата в Java объект. Необходимо расширить абстрактный класс `StdDeserializer`.

```java
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CustomDeserializer extends StdDeserializer<LocalDateTime> {

    protected CustomDeserializer() {
        this(null);
    }

    protected CustomDeserializer(Class<?> vc) {
        super(vc);
    }

    @Override
    public LocalDateTime deserialize(JsonParser jsonParser, DeserializationContext context) throws IOException {
        String value = jsonParser.getText();
        if (!"".equals(value)) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");
            return LocalDateTime.parse(value, formatter);
        }
        return null;
    }

}
```

После этого необходимо над полем поставить аннотацию `@JsonDeserialize` c указанием нашего кастомного десериализатора.

```java
public class Foo {

    // ... ... ... ... ...

    @JsonDeserialize(using = CustomDeserializer.class)
    private LocalDateTime date;

    // ... ... ... ... ...

}
```

## Сериализация
В данном случае это преобразование Java объекта в json формат. Для сериализации необходимо расширить класс `StdSerializer`.

```java
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.std.StdSerializer;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CustomSerializer extends StdSerializer<LocalDateTime> {

    protected CustomSerializer(Class<LocalDateTime> t) {
        super(t);
    }

    protected CustomSerializer() {
        this(null);
    }

    @Override
    public void serialize(LocalDateTime value, JsonGenerator gen, SerializerProvider provider) throws IOException {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss");
        gen.writeString(formatter.format(value));
    }

}
```

Для работы над полем поставить аннотацию `@JsonSerialize`

```java
public class Foo {

    // ... ... ... ... ...

    @JsonSerialize(using = LocalDateTimestampSerializer.class)
    private LocalDateTime date;

    // ... ... ... ... ...

}
```
***
## Мета информация
**Область**:: [[../../meta/zero/00 Снипеты для Java|00 Снипеты для Java]]
**Родитель**:: [[../../../../knowledge/dev/java/other/Jackson|Jackson]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2023-11-20]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
