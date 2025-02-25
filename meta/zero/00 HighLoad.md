---
tags:
  - type/zero-link
parents:
  - "[[00 Архитектура ИС]]"
title: HighLoad
aliases:
  - HighLoad
  - высоконагруженных системах
  - высоконагруженная система
  - высоконагруженных систем
  - систем с высокой нагрузкой
  - высокой нагрузкой
  - высоконагруженных приложений
---
## Что такое HighLoad?
Например, один запрос в секунду – это нагрузка явно не highload, любой сервер, вроде бы, справится. Но, например, если он перекодирует видеоролики, то тут может наступить highload.

> Высокая нагрузка это нагрузка, с которой не справляется железо.

Нет языков, технологий или баз данных, которые лучше или хуже подходят для высоконагруженного проекта. Вопрос - на чём лучше писать highload-проект - на Ruby или Python'е лишён смысла и говорит о низкой технической грамотности вопрошающего. 

> Высокие нагрузки, [отказоустойчивость](Reliability.md) - это не про технологии, это про АРХИТЕКТУРУ!

Основная логика увеличения производительности:
- Увеличиваем эффективность использования [[../../dev/other/Ресурсы для работы приложений|ресурсов]]
- Увеличиваем количество [[../../dev/other/Ресурсы для работы приложений|ресурсов]]
## Алгоритм проектирования
1. Первым делом необходимо провести [Анализ данных проекта](Анализ%20данных%20проекта.md).
2. Для каждого использования подобрать архитектурный прием, разработать архитектуру.
3. Для каждой архитектуры подобрать инструменты и технологии.

## Алгоритм диагностики существующего решения
Что делать если решение уже разработано и его нужно переделать в highload-решение. Для начала необходимо поставить "диагноз". А именно понять где у системы [[../../dev/architecture/Bottlneck|узкое горлышко]]. На какие процессы тратится больше всего ресурсов.


## Архитектурные паттерны
- [Сервис-ориентированная архитектура](Service%20Oreinted%20Architecture.md)
- [Вертикальное масштабирование](../../dev/architecture/highload/Вертикальное%20масштабирование.md)
- [Горизонтальное масштабирование](../../dev/architecture/highload/Горизонтальное%20масштабирование.md)
	- [Репликация](../../dev/architecture/highload/Репликация.md)
		- [[../../dev/architecture/highload/Репликация БД|Репликация БД]]
			- [[../../dev/database/postgresql/Репликация в PostgreSQL|Репликация в PostgreSQL]]
			- [[../../dev/database/postgresql/Репликация в PostgreSQL|Репликация в PostgreSQL]]
- Отложенные вычисления
- Асинхронная обработка
- Конвейерная обработка
- Использование толстого клиента
- [Кэширование](../../dev/architecture/Кэширование.md)
- [Функциональное разделение](Функциональное%20разделение.md)
- [Шардинг](../../../../_inbox/Шардирование%20БД.md)
- Виртуальные шарды
- Центральный диспетчер
- Партиционирование
- Кластеризация
- Денормализация
- Параллельное выполнение
- [Избыточность данных](../../dev/architecture/Избыточность%20данных.md)
- [Допустимая деградация системы](Допустимая%20деградация%20системы.md)

## Улучшения
- [Pipelining](Pipelining.md)
- [Прокси перед базой данных (БД)](Прокси%20перед%20базой%20данных%20(БД).md)
- [Улучшение производительности отдельного сервиса](Улучшение%20производительности%20отдельного%20сервиса.md)
## Заметки

В чем измеряется нагрузка:
- Количество запросов в единицу времени 
	- Requests per seconds (RPS)
	- Request per minute (RPM)
- Количество данных в единицу времени
	- Packets per seconds (PPS)
	- Мегабит в секунду (MB/s)
- Количество одновременно обслуживаемых соединений
	- Simultaneous connections
	- Cuncurrency

Зачем нужен хайлоад?
- Защита от [DDOS](DDOS.md)
- Защита от [Slashdot-эффект](Slashdot-эффект.md)

- [Availability](../../../../_inbox/Availability.md)
- [Reliability](Reliability.md)
- [Disaster recovery](../../dev/architecture/highload/Disaster%20recovery.md)

[Пропускная способность](../../dev/architecture/Throughput.md) сетевой карты 1 Гбит/с (реальная 800-900 Мбит/с) или 120 000 пакетов в секунду. Bonding позволяет несколько физических интернет соединений объединить в одно логическое, например, 4 интерфейса -  3.5 Гбит/с.

В highload системах как правило отдают предпочтение [throughput](../../dev/architecture/Throughput.md).