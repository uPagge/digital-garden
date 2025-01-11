---
aliases: 
tags:
  - maturity/🌱
date: 2024-09-14
zero-link:
  - "[[../../meta/zero/00 Разработка|00 Разработка]]"
parents:
  - "[[../garden/ru/dev/fundamental/Кодирование данных|Кодирование данных]]"
linked:
---
Base64 — это метод [[../fundamental/Кодирование данных|кодирования данных]], который преобразует двоичные данные (например, файлы, изображения, или любой другой тип бинарных данных) в текстовый формат, используя набор из 64 символов (буквы латинского алфавита, цифры, а также символы + и /). Base64 часто используется для передачи данных через текстовые среды, такие как электронная почта или URL, где могут быть ограничения на использование двоичных данных.

**Основные характеристики Base64:**
- **Кодирование и декодирование**: Base64 преобразует каждый триплет байтов (24 бита) входных данных в четыре символа (по 6 бит каждый). В случае, если количество байтов не кратно трём, на выход добавляются один или два символа = для заполнения.
- **Читаемый текстовый формат**: Закодированные данные выглядят как обычный текст, состоящий из букв, цифр и нескольких специальных символов.
- **Преобразование размера**: Закодированные Base64 данные увеличиваются в размере примерно на 33% по сравнению с исходными двоичными данными.
- **Безопасность и надежность передачи**: Base64 кодирование не является средством защиты данных, оно не обеспечивает шифрования.

**Применения Base64:**
- **Электронная почта (MIME)**: Используется для кодирования вложений в электронных письмах, чтобы их можно было безопасно передать через SMTP, который поддерживает только текст.
- **Web**: Используется для передачи данных через URL или в JSON, а также для встраивания изображений и других медиафайлов в HTML и CSS.
- **Кодирование API**: Используется для кодирования данных в API запросах, особенно когда нужно передать бинарные данные в JSON.
- **Хранение данных**: В некоторых базах данных или конфигурационных файлах может быть удобно хранить бинарные данные в текстовом формате.

**Реализации:**
- [[../snippet/Реализация Base64 на Java|Реализация Base64 на Java]]
***
## Мета информация
**Область**:: [[../../meta/zero/00 Разработка|00 Разработка]]
**Родитель**:: [[../fundamental/Кодирование данных|Кодирование данных]]
**Источник**:: 
**Создана**:: [[2024-09-14]]
**Автор**:: 
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
<!-- SerializedQuery: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
- [[Реализация Base64 на Java]]
<!-- SerializedQuery END -->