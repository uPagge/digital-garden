---
aliases: 
tags:
  - maturity/🌱
date: 2024-11-04
---
## Тезисы
- Classloader — это компонент JVM, отвечающий за динамическую загрузку классов в память во время выполнения программы.
- Classloader выполняет загрузку, проверку, связывание и инициализацию классов.
- В Java существует иерархия Classloader: Bootstrap, Extension (Platform), и Application (System).
- Классы могут загружаться из нестандартных источников с использованием кастомного Classloader, что полезно для создания модульных систем или плагинов.
***

Classloader — это компонент [[Java Virtual Machine|JVM]], отвечающий за динамическую загрузку классов в память во время выполнения программы. В Java каждый класс должен быть загружен в память перед его использованием, и именно Classloader выполняет эту задачу.

**Функции Classloader**
1. **Загрузка классов**: Classloader находит и загружает файлы классов (обычно с расширением `.class`) из classpath в память.
2. **Проверка классов**: После загрузки Classloader проверяет [[Java байт-код|байт-код]] класса для обеспечения его корректности и безопасности.
3. **Связывание классов**: Classloader связывает загруженные классы, включая проверку ссылок и разрешение символов.
4. **Инициализация классов**: Classloader инициализирует загруженные классы, вызывая их статические инициализаторы и инициализаторы переменных.

**Иерархия Classloader**
- **Bootstrap ClassLoader**: Базовый загрузчик классов, встроенный в JVM. Он загружает основные классы Java из файла rt.jar, такие как классы из `java.lang`, `java.util` и других. Реализован на нативном языке и является частью ядра JVM.
- **Extension ClassLoader (Platform ClassLoader)**: Загружает классы из стандартных расширений Java, находящихся в директории `jre/lib/ext` или другой директории, определенной системным параметром `java.ext.dirs`. Обратите внимание, что директория `jre/lib/ext` используется в старых версиях Java, а более новые версии могут использовать другой подход. Сам загружается с помощью Bootstrap ClassLoader.
- **Application ClassLoader (System ClassLoader)**: Загружает классы приложения из директории classpath. Обычно это директория, указанная в переменной окружения `CLASSPATH` или параметре командной строки `-cp`. Используется для загрузки классов приложений и библиотек.

Пример:
```java
public class Main {
    public static void main(String[] args) {
        ClassLoader classLoader = Main.class.getClassLoader();
        System.out.println("ClassLoader: " + classLoader);

        try {
            Class<?> aClass = classLoader.loadClass("Example");
            System.out.println("Class loaded: " + aClass.getName());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
```

Этот пример демонстрирует, как можно использовать Classloader для динамической загрузки классов во время выполнения программы. Он полезен в случаях, когда классы могут быть неизвестны на этапе компиляции и должны быть загружены из внешних источников, например, при создании плагинов или модулей, добавляемых на лету.
## Кастомный Classloader
Можно создавать собственные Classloader, расширяя класс `java.lang.ClassLoader`, для загрузки классов из нестандартных источников (например, из базы данных, сети или зашифрованных архивов). Это может быть полезно, когда требуется загрузить обновляемые модули или плагины, которые могут меняться без необходимости перезапуска всей системы. Например, кастомный Classloader можно использовать для реализации системы плагинов, где плагины загружаются динамически по запросу пользователя.

```java
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;

public class CustomClassLoader extends ClassLoader {

    @Override
    public Class<?> findClass(String name) throws ClassNotFoundException {
        try {
            byte[] bytes = loadClassData(name);
            return defineClass(name, bytes, 0, bytes.length);
        } catch (IOException e) {
            throw new ClassNotFoundException(name, e);
        }
    }

    private byte[] loadClassData(String name) throws IOException {
        String path = name.replace('.', '/') + ".class";
        InputStream inputStream = Files.newInputStream(Paths.get(path));
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        int data;
        while ((data = inputStream.read()) != -1) {
            byteArrayOutputStream.write(data);
        }
        return byteArrayOutputStream.toByteArray();
    }
}
```

- Мы расширяем `ClassLoader` и переопределяем метод `findClass`.
- Метод `loadClassData` загружает данные класса из файла.
- Метод `defineClass` создает класс из байтового массива.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Java разработка|00 Java разработка]]
**Родитель**:: [[Class Loader Subsystem|Class Loader Subsystem]]
**Источник**:: 
**Создана**:: [[2024-11-04]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

