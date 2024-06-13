---
aliases: 
tags:
  - зрелость/🌱
date: "[[2023-11-11]]"
zero-link:
  - "[[00 Разработка]]"
parents: 
linked:
---
Если долго не обновлять версию Ghost, а потом в какой-то момент решить обновить, то можно столкнуться с неприятной ошибкой:

```
Migration lock was never released or currently a migration is running.

"If you are sure no migration is running, check your data and if your database is in a broken state, you could run `yarn knex-migrator rollback`."

Error ID:
    500
```

Можно попробовать выполнить команду `yarn knex-migrator rollback`, но это может и не помочь. Мне не помогло.

Если Ghost работает в Docker образе, то чтобы выполнить эту команду, необходимо запустить образ с альтернативной командой. Так как скорее всего ваш контейнер запускается и тут же падает, поэтому зайти в него и запустить попросту не получится. И еще раз обращу внимание, мы именно запускаем новый образ, а не контейнер.

Но для начала [скачайте](https://github.com/TryGhost/Ghost/blob/main/package.json) `package.json` с Ghost репозитория, по какой-то причине его нет в образе.

Далее укажите все необходимые параметры, которые вы используете в своем Docker Compose:

```bash
docker run -it -e database__client=mysql -e database__connection__host=<YOUR_DATABASE_HOST> -e database__connection__database=<YOUR_DATABASE_NAME> -e database__connection__user=<YOUR_DATABASE_USERNAME> -e database__connection__password="<YOUR_DATABASE_PASSWORD>" -v ./package.json:/var/lib/ghost/package.json --network <YOUR_DATABASE_NETWORK> --entrypoint /bin/bash ghost:5.72-alpine -c "yarn knex-migrator rollback"
```

Как я уже сказал мне это не помогло, была вот такая ошибка:

```bash
yarn run v1.22.19
$ yarn workspace ghost run knex-migrator rollback
error Unknown workspace "ghost".
info Visit https://yarnpkg.com/en/docs/cli/workspace for documentation about this command.
error Command failed with exit code 1.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
```

Тогда я натолкнулся на [вот эту статью](https://jessicadeen.com/posts/2019/ghost-migration-lock-was-never-released-or-currently-a-migration-is-running-fix/). И она мне помогла исправить проблему.

Нам необходимо выполнить скрипт, который отключит блокировку миграций. Кажется это то что иногда происходит с liquibase.

Для этого подключаемся к контейнере с базой данных:
```bash
docker exec -it coding-mariadb bash
```

Входим в консоль MySQL:
```bash
mysql -u ghost -p
```

Переключаемся на базу данных, которую использует Ghost:
```sql
USE ghost_production
```

И выполняем скрипт. (В статье скрипт написан с ошибками):
```
UPDATE migrations_lock set locked=0 where lock_key='km01';
```

Вот и все, после этого сайт через пару минут запустился.