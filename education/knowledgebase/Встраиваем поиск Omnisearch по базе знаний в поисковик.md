---
aliases: 
tags:
  - maturity/🌱
date: 2024-11-24
---
Т.е. мы что-то ищем в сети, и одновременно видим на этом же экране все релевантные заметки из нашей локальной базы знаний. Такое можно вполне организовать и в Obsidian.
  
Алгоритм активации этой функции:
- Установите последнюю версию Omnisearch
- Активируйте опцию Enable HTTP Server, порт оставьте по умолчанию 51361
- Установите [Tampermonkey](https://www.tampermonkey.net/) или любой другой менеджер пользовательских скриптов. Плагин нужно устанавливать в режиме разработчика, иначе работать не будет. 
- Установите скрипт под ваш поисковик:
	- [Kagi](https://github.com/scambier/userscripts/raw/master/dist/obsidian-omnisearch-kagi.user.js)
	- [Google](https://github.com/scambier/userscripts/raw/master/dist/obsidian-omnisearch-google.user.js)
	- [DuckDuckGo](https://github.com/scambier/userscripts/raw/master/dist/obsidian-omnisearch-ddg.user.js)
	- [Bing](https://github.com/scambier/userscripts/raw/master/dist/obsidian-omnisearch-bing.user.js)

***
## Мета информация
**Область**:: [[../../meta/zero/00 База знаний|00 База знаний]]
**Родитель**:: [[Obsidian]]
**Источник**:: 
**Создана**:: [[2024-11-24]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

