---
aliases:
  - HeapDumpOnOutOfMemoryError
  - HeapDumpPath
tags:
  - maturity/🌱
date: 2024-11-25
---
При запуске Java-приложения с помощью следующей команды:
```shell
/app/jdk/bin/java -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/dumps/oom.bin -jar your-app.jar
```

параметры `-XX:+HeapDumpOnOutOfMemoryError` и `-XX:HeapDumpPath=/dumps/oom.bin` позволяют автоматически сохранить heap dump в файл `/dumps/oom.bin` при возникновении ошибки `OutOfMemoryError`.

**Рекомендации:**
- Убедитесь, что каталог `/dumps` существует.
- Проверьте, что у процесса Java есть права на запись в этот каталог.
- Если каталог отсутствует или недостаточно прав, heap dump может не сохраниться.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Java разработка|00 Java разработка]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-11-25]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

