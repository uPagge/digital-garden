
Если у вас все тесты проходят локально, но не проходят в GitHub, то скорее всего дело в schema.sql. GitHub использует базу H2 при запуске тестов, а локально вы можете разрабатывать на PostgreSQL. Но необходимо убедиться. что тесты проходят и с базой H2.

Для этого:
* Первым делом проверьте ваш проперти файл, он должен выглядеть как во вложении.
* Далее запустите свое приложение c профилями ci,test, как на скриншоте.
* Запустите тесты постмана локально

Скорее всего вы получите те же ошибки, что и в гитхабе. Но иногда это не помогает. Тогда вместо третьего пункта, необходимо:

* Создаем папки в проекте tests/postman
* Кладем в postman файл spring.json — это файл с тестами для посотмана
* Далее самое сложное. Нужно установить утилиту newman. Тут все зависит от вашей ОС. Именно эта утилита запускает тесты в GitHub
* Далее из терминала в Idea запускаем следующую команду

```shell
newman run ./tests/postman/sprint.json  --delay-request 50 -r cli,htmlextra  --verbose --color on --reporter-htmlextra-darkTheme  --reporter-htmlextra-export reports/shareIt.html --reporter-htmlextra-title "Отчет по тестам" --reporter-htmlextra-logs true --reporter-htmlextra-template ./tests/.github/workflows/dashboard-template.hbs
```

![](Снимок%20экрана%202022-11-08%20в%2018.36.25%20(1).png)![](Снимок%20экрана%202022-11-10%20в%2017.33.53.png)

Проперти:

```properties
spring.jpa.hibernate.ddl-auto=none
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQL10Dialect
spring.jpa.properties.hibernate.format_sql=true
spring.sql.init.mode=always

#---
spring.datasource.driverClassName=org.postgresql.Driver
spring.datasource.url=jdbc:postgresql://localhost:5434/shareit
spring.datasource.username=shareit
spring.datasource.password=shareit
#---
spring.config.activate.on-profile=ci,test
spring.datasource.driverClassName=org.h2.Driver
spring.datasource.url=jdbc:h2:mem:shareit
spring.datasource.username=test
spring.datasource.password=test
#spring.h2.console.enabled=true
```

Файл с пропертями: ![](application.properties)