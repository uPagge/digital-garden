---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-06-17
zero-link:
  - "[[00 PostgreSQL]]"
parents:
  - "[[Репликация в PostgreSQL]]"
linked:
---
## Физическая репликация
1. Создаем сеть, запоминаем адрес
    ```shell
    docker network create pgnet
    docker network inspect pgnet | grep Subnet # Запомнить маску сети
    ```

2. Поднимаем мастер
    ```shell
    docker run -dit -v "$PWD/volumes/pgmaster/:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=pass -p "5432:5432" --restart=unless-stopped --network=pgnet --name=pgmaster postgres
    ```

3. Меняем postgresql.conf на мастере
    ```conf
    ssl = off
    wal_level = replica
    max_wal_senders = 4 # expected slave num
    ```

4. Подключаемся к мастеру и создаем пользователя для репликации
    ```shell
    docker exec -it pgmaster su - postgres -c psql
    create role replicator with login replication password 'pass';
    exit
    ```

5. Добавляем запись в `pgmaster/pg_hba.conf` с `subnet` с первого шага
    ```
    host    replication     replicator       __SUBNET__          md5
    ```

6. Перезапустим мастер
    ```shell
    docker restart pgmaster
    ```

7. Сделаем бэкап для реплик
    ```shell
    docker exec -it pgmaster bash
    mkdir /pgslave
    pg_basebackup -h pgmaster -D /pgslave -U replicator -v -P --wal-method=stream
    exit
    ```

8. Копируем директорию себе
    ```shell
    docker cp pgmaster:/pgslave volumes/pgslave/
    ```

9. Создадим файл, чтобы реплика узнала, что она реплика
    ```shell
    touch volumes/pgslave/standby.signal
    ```

10. Меняем `postgresql.conf` на реплике `pgslave`
    ```conf
    primary_conninfo = 'host=pgmaster port=5432 user=replicator password=pass application_name=pgslave'
    ```

11. Запускаем реплику `pgslave`
    ```shell
    docker run -dit -v "$PWD/volumes/pgslave/:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=pass -p "15432:5432" --network=pgnet --restart=unless-stopped --name=pgslave postgres
    ```

12. Запустим вторую реплику `pgasyncslave`
    - скопируем бэкап
        ```shell
        docker cp pgmaster:/pgslave volumes/pgasyncslave/
        ```

    - изменим настройки `pgasyncslave/postgresql.conf`
        ```conf
        primary_conninfo = 'host=pgmaster port=5432 user=replicator password=pass application_name=pgasyncslave'
        ```

    - дадим знать что это реплика
        ```shell
        touch volumes/pgasyncslave/standby.signal
        ```

    - запустим реплику `pgasyncslave`
        ```shell
        docker run -dit -v "$PWD/volumes/pgasyncslave/:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=pass -p "25432:5432" --network=pgnet --restart=unless-stopped --name=pgasyncslave postgres
        ```

14. Убеждаемся что обе реплики работают в асинхронном режиме на `pgmaster`
    ```shell
    docker exec -it pgmaster su - postgres -c psql
    select application_name, sync_state from pg_stat_replication;
    exit;
    ```

15. Включаем синхронную репликацию на `pgmaster`
    - меняем файл `pgmaster/postgresql.conf`
        ```conf
        synchronous_commit = on
        synchronous_standby_names = 'FIRST 1 (pgslave, pgasyncslave)'
        ```

    - перечитываем конфиг
        ```shell
        docker exec -it pgmaster su - postgres -c psql
        select pg_reload_conf();
        exit;
        ```

16. Убеждаемся, что реплика стала синхронной
    ```shell
    docker exec -it pgmaster su - postgres -c psql
    select application_name, sync_state from pg_stat_replication;
    exit;
    ```

17. Создадим тестовую таблицу на `pgmaster` и проверим репликацию
    ```shell
    docker exec -it pgmaster su - postgres -c psql
    create table test(id bigint primary key not null);
    insert into test(id) values(1);
    select * from test;
    exit;
    ```

18. Проверим наличие данных на `pgslave`
    ```shell
    docker exec -it pgslave su - postgres -c psql
    select * from test;
    exit;
    ```

19. Проверим наличие данных на `pgasyncslave`
    ```shell
    docker exec -it pgasyncslave su - postgres -c psql
    select * from test;
    exit;
    ```
20. Попробуем сделать `insert` на `pgslave`
    ```shell
    docker exec -it pgslave su - postgres -c psql
    insert into test(id) values(2);
    exit;
    ```
21. Укладываем репилку `pgasyncslave` и проверяем работу `pgmaster` и `pgslave`
    ```shell
    docker stop pgasyncslave
    docker exec -it pgmaster su - postgres -c psql
    select application_name, sync_state from pg_stat_replication;
    insert into test(id) values(2);
    select * from test;
    exit;
    docker exec -it pgslave su - postgres -c psql
    select * from test;
    exit;
    ```
22. Укладываем репилку `pgslave` и проверяем работу `pgmaster`, а потом возвращаем реплику `pgslave`
    - terminal 1
        ```shell
        docker stop pgslave
        docker exec -it pgmaster su - postgres -c psql
        select application_name, sync_state from pg_stat_replication;
        insert into test(id) values(3);
        exit;
        ```
    - terminal 2
        ```shell
        docker start pgslave
        ```
23. Возвращаем вторую реплику `pgasyncslave`
    ```shell
    docker start pgasyncslave
    ```
24. Убиваем мастер `pgmaster`
    ```shell
    docker stop pgmaster
    ```
25. Запромоутим реплику `pgslave`
    ```shell
    docker exec -it pgslave su - postgres -c psql
    select pg_promote();
    exit;
    ```
26. Пробуем записать в новый мастер `pgslave`
    ```shell
    docker exec -it pgslave su - postgres -c psql
    insert into test(id) values(4);
    exit;
    ```

27. Настраиваем репликацию на `pgslave` (`pgslave/postgresql.conf`)
    - изменяем конфиг
        ```conf
        synchronous_commit = on
        synchronous_standby_names = 'ANY 1 (pgmaster, pgasyncslave)'
        ```
    - перечитываем конфиг
        ```shell
        docker exec -it pgslave su - postgres -c psql
        select pg_reload_conf();
        exit;
        ```

28. Подключим вторую реплику `pgasyncslave` к новому мастеру `pgslave`
    - изменяем конфиг `pgasyncslave/postgresql.conf`
        ```conf
        primary_conninfo = 'host=pgslave port=5432 user=replicator password=pass application_name=pgasyncslave'
        ```
    - перечитываем конфиг
        ```shell
        docker exec -it pgasyncslave su - postgres -c psql
        select pg_reload_conf();
        exit;
        ```
29. Проверяем что к новому мастеру `pgslave` подключена реплика и она работает
    ```shell
    docker exec -it pgslave su - postgres -c psql
    select application_name, sync_state from pg_stat_replication;
    insert into test(id) values (5)
    select * from test;
    exit;
    docker exec -it pgasyncslave su - postgres -c psql
    select * from test;
    exit;
    ```
30. Восстановим старый мастер `pgmaster` как реплику
    1. Помечаем как реплику
        ```shell
        touch volumes/pgmaster/standby.signal
        ```
    2. Изменяем конфиг `pgmaster/postgresql.conf`
        ```conf
        primary_conninfo = 'host=pgslave port=5432 user=replicator password=pass application_name=pgmaster'
        ```
    3. Запустим `pgmaster`
       ```shell
        docker start pgmaster
        ```
    4. Убедимся что `pgmaster` подключился как реплика к `pgslave`
        ```shell
        docker exec -it pgslave su - postgres -c psql
        select application_name, sync_state from pg_stat_replication;
        exit;
        ```

## Логическая репликация
1. Меняем `wal_level` для текущего мастера `pgslave`
   1. Изменяем настройки `pgslave/postgresql.conf`
        ```conf
        wal_level = logical
        ```
    2. Перезапускаем `pgslave`
        ```shell
        docker restart pgslave
        ```
2. Создадим публикацию в `pgslave`
    ```shell
    docker exec -it pgslave su - postgres -c psql
    GRANT CONNECT ON DATABASE postgres TO replicator;
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO replicator;
    create publication pg_pub for table test;
    exit;
    ```
3. Создадим новый сервер `pgstandalone` для логической репликации
    ```shell
    docker run -dit -v "$PWD/volumes/pgstandalone/:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=pass -p "35432:5432" --restart=unless-stopped --network=pgnet --name=pgstandalone postgres
    ```
4. Копируем файлы c `pgslave` в `pgstandalone` и восстанавливаем
    ```shell
    docker exec -it pgslave su - postgres
    pg_dumpall -U postgres -r -h pgslave -f /var/lib/postgresql/roles.dmp
    pg_dump -U postgres -Fc -h pgslave -f /var/lib/postgresql/schema.dmp -s postgres
    exit;

    docker cp pgslave:/var/lib/postgresql/roles.dmp .
    docker cp roles.dmp pgstandalone:/var/lib/postgresql/roles.dmp
    docker cp pgslave:/var/lib/postgresql/schema.dmp .
    docker cp schema.dmp pgstandalone:/var/lib/postgresql/schema.dmp

    docker exec -it pgstandalone su - postgres
    psql -f roles.dmp
    pg_restore -d postgres -C schema.dmp
    exit
    ```

5. Создаем подписку на `pgstandalone`
    ```shell
    docker exec -it pgstandalone su - postgres -c psql
    CREATE SUBSCRIPTION pg_sub CONNECTION 'host=pgslave port=5432 user=replicator password=pass dbname=postgres' PUBLICATION pg_pub;
    exit;
    ```
6. Убеждаемся что репликация запущена
    ```shell
    docker exec -it pgstandalone su - postgres -c psql
    select * from test;
    exit;
    ```
7. Сделаем конфликт в данных
    1. Вставляем данные в подписчике `pgstandalone`
        ```shell
        docker exec -it pgstandalone su - postgres -c psql
        insert into test values(9);
        exit;
        ```
    2. Вставляем данные в паблишере `pgslave`
        ```shell
        docker exec -it pgslave su - postgres -c psql
        insert into test values(9);
        insert into test values(10);
        exit;
        ```
    3. Убеждаемся что записи с id 10 не появилось на `pgstandalone`
        ```shell
        docker exec -it pgstandalone su - postgres -c psql
        select * from test;
        exit;
        ```
    4. Посмотрим в логи `pgstandalone` и убедимся что у нас произошел разрыв репликации
        ```shell
        docker logs pgstandalone
        ```
        ```
        2023-03-27 16:15:02.753 UTC [258] ERROR:  duplicate key value violates unique constraint "test_pkey"
        2023-03-27 16:15:02.753 UTC [258] DETAIL:  Key (id)=(9) already exists.
        2023-03-28 18:30:42.893 UTC [108] CONTEXT:  processing remote data for replication origin "pg_16395" during message type "INSERT" for replication target relation "public.test" in transaction 739, finished at 0/3026450
        ```

8.  Исправляем конфликт
    ```shell
    docker exec -it pgstandalone su - postgres -c psql
    SELECT pg_replication_origin_advance('pg_16395', '0/3026451'::pg_lsn); # message from log + 1
    ALTER SUBSCRIPTION pg_sub ENABLE;
    select * from test;
    exit;
    ```
