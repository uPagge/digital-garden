---
aliases: 
tags:
  - maturity/🌱
date: 2024-11-03
---
![[../../../meta/files/Pasted image 20241103220651.png]]

- **Code Style (Стиль кода)**:
   - Применен ли стиль форматирования проекта?
   - Достаточно ли [[Читаемый код|читаем код]] (длина методов и т.п.)?
   - Соблюдается ли принцип DRY (Don't Repeat Yourself)?
   - Соответствует ли именование общепринятым соглашениям?
- **Tests (Тесты)**:
   - Проходят ли все тесты?
   - Новые функции протестированы?
   - Покрыты ли крайние случаи?
   - Используются ли юнит-тесты и интеграционные тесты?
   - Есть ли тесты для нефункциональных требований, например, производительность?
- **Documentation (Документация)**:
   - Есть ли документация для новых функций?
   - Покрыты ли различные виды документации: README, API, user guide и др.?
   - Понятны ли документы, нет ли ошибок в типографике и грамматике?
- **Implementation Semantics (Семантика реализации)**:
   - Соответствует ли реализация исходным требованиям?
   - Корректна ли логика?
   - Нет ли излишней сложности?
   - Надежна ли реализация (вопросы конкурентности, обработки ошибок и т.д.)?
   - Хорошая ли производительность?
   - Безопасна ли (например, отсутствие SQL-инъекций)?
   - Можно ли наблюдать за реализацией (метрики, логирование и т.д.)?
   - Тянут ли новые зависимости свой вес, приемлема ли их лицензия?
- **API Semantics (Семантика API)**:
   - Насколько компактно API, оно достаточно большое или наоборот?
   - Есть ли один способ достижения цели, без множественных подходов?
   - API предсказуемо, следует ли оно принципу наименьшего удивления?
   - Являются ли внутренности API скрытыми от пользователя?
   - Нет ли изменений, ломающих обратную совместимость?
   - Насколько полезно и не слишком специфично API?
***
## Мета информация
**Область**:: [[../meta/zero/00 Разработка|00 Разработка]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-11-03]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
