---
aliases: 
tags:
  - maturity/🌱
date:
  - - 2024-06-17
zero-link:
  - "[[../../../meta/zero/00 PostgreSQL|00 PostgreSQL]]"
parents:
  - "[[Репликация в PostgreSQL|Репликация в PostgreSQL]]"
linked:
---
## Физическая репликация
Создаем сеть, запоминаем адрес
```shell
docker network create pgnet
docker network inspect pgnet | grep Subnet # Запомнить маску сети
```

Поднимаем мастер
```shell
docker run -dit -v "$PWD/volumes/pgmaster/:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=pass -p "5432:5432" --restart=unless-stopped --network=pgnet --name=pgmaster postgres
```

Меняем postgresql.conf на мастере
```conf
ssl = off
wal_level = replica
max_wal_senders = 4 # expected slave num
```

Подключаемся к мастеру и создаем пользователя для репликации
```shell
docker exec -it pgmaster su - postgres -c psql
create role replicator with login replication password 'pass';
exit
```

Добавляем запись в `pgmaster/pg_hba.conf` с `subnet` с первого шага
```
host    replication     replicator       __SUBNET__          md5
```

Перезапустим мастер
```shell
docker restart pgmaster
```

Сделаем бэкап для реплик
```shell
docker exec -it pgmaster bash
mkdir /pgslave
pg_basebackup -h pgmaster -D /pgslave -U replicator -v -P --wal-method=stream
exit
```

Копируем директорию себе
```shell
docker cp pgmaster:/pgslave volumes/pgslave/
```

Создадим файл, чтобы реплика узнала, что она реплика
```shell
touch volumes/pgslave/standby.signal
```

Меняем `postgresql.conf` на реплике `pgslave`
```conf
primary_conninfo = 'host=pgmaster port=5432 user=replicator password=pass application_name=pgslave'
```

Запускаем реплику `pgslave`
```shell
docker run -dit -v "$PWD/volumes/pgslave/:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=pass -p "15432:5432" --network=pgnet --restart=unless-stopped --name=pgslave postgres
```

Запустим вторую реплику `pgasyncslave`

Скопируем бэкап
```shell
docker cp pgmaster:/pgslave volumes/pgasyncslave/
```

Изменим настройки `pgasyncslave/postgresql.conf`
```conf
primary_conninfo = 'host=pgmaster port=5432 user=replicator password=pass application_name=pgasyncslave'
```

Дадим знать что это реплика
```shell
touch volumes/pgasyncslave/standby.signal
	```

Запустим реплику `pgasyncslave`
```shell
docker run -dit -v "$PWD/volumes/pgasyncslave/:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=pass -p "25432:5432" --network=pgnet --restart=unless-stopped --name=pgasyncslave postgres
	```

Убеждаемся что обе реплики работают в асинхронном режиме на `pgmaster`
```shell
docker exec -it pgmaster su - postgres -c psql
select application_name, sync_state from pg_stat_replication;
exit;
    ```

Включаем синхронную репликацию на `pgmaster`

Меняем файл `pgmaster/postgresql.conf`
```conf
synchronous_commit = on
synchronous_standby_names = 'FIRST 1 (pgslave, pgasyncslave)'
```

Перечитываем конфиг
```shell
docker exec -it pgmaster su - postgres -c psql
select pg_reload_conf();
exit;
```

Убеждаемся, что реплика стала синхронной
```shell
docker exec -it pgmaster su - postgres -c psql
select application_name, sync_state from pg_stat_replication;
exit;
```

Создадим тестовую таблицу на `pgmaster` и проверим репликацию
```shell
docker exec -it pgmaster su - postgres -c psql
create table test(id bigint primary key not null);
insert into test(id) values(1);
select * from test;
exit;
```

Проверим наличие данных на `pgslave`
```shell
docker exec -it pgslave su - postgres -c psql
select * from test;
exit;
```

Проверим наличие данных на `pgasyncslave`
```shell
docker exec -it pgasyncslave su - postgres -c psql
select * from test;
exit;
```

Попробуем сделать `insert` на `pgslave`
```shell
docker exec -it pgslave su - postgres -c psql
insert into test(id) values(2);
exit;
    ```

Укладываем репилку `pgasyncslave` и проверяем работу `pgmaster` и `pgslave`
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

Укладываем репилку `pgslave` и проверяем работу `pgmaster`, а потом возвращаем реплику `pgslave`

terminal 1
```shell
docker stop pgslave
docker exec -it pgmaster su - postgres -c psql
select application_name, sync_state from pg_stat_replication;
insert into test(id) values(3);
exit;
```

terminal 2
```shell
docker start pgslave
```

Возвращаем вторую реплику `pgasyncslave`
```shell
docker start pgasyncslave
```

Убиваем мастер `pgmaster`
```shell
docker stop pgmaster
```

Запромоутим реплику `pgslave`
```shell
docker exec -it pgslave su - postgres -c psql
select pg_promote();
exit;
```

Пробуем записать в новый мастер `pgslave`
```shell
docker exec -it pgslave su - postgres -c psql
insert into test(id) values(4);
exit;
```

Настраиваем репликацию на `pgslave` (`pgslave/postgresql.conf`)

изменяем конфиг
```conf
synchronous_commit = on
synchronous_standby_names = 'ANY 1 (pgmaster, pgasyncslave)'
```

перечитываем конфиг
```shell
docker exec -it pgslave su - postgres -c psql
select pg_reload_conf();
exit;
```

Подключим вторую реплику `pgasyncslave` к новому мастеру `pgslave`

изменяем конфиг `pgasyncslave/postgresql.conf`
```conf
primary_conninfo = 'host=pgslave port=5432 user=replicator password=pass application_name=pgasyncslave'
```

перечитываем конфиг
```shell
docker exec -it pgasyncslave su - postgres -c psql
select pg_reload_conf();
exit;
```

Проверяем что к новому мастеру `pgslave` подключена реплика и она работает
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

Восстановим старый мастер `pgmaster` как реплику

Помечаем как реплику
```shell
touch volumes/pgmaster/standby.signal
```

Изменяем конфиг `pgmaster/postgresql.conf`
```conf
primary_conninfo = 'host=pgslave port=5432 user=replicator password=pass application_name=pgmaster'
```

Запустим `pgmaster`
```shell
docker start pgmaster
```

Убедимся что `pgmaster` подключился как реплика к `pgslave`
```shell
docker exec -it pgslave su - postgres -c psql
select application_name, sync_state from pg_stat_replication;
exit;
```

## Логическая репликация
Меняем `wal_level` для текущего мастера `pgslave`

Изменяем настройки `pgslave/postgresql.conf`
```conf
wal_level = logical
```

Перезапускаем `pgslave`
```shell
docker restart pgslave
```

Создадим публикацию в `pgslave`
```shell
docker exec -it pgslave su - postgres -c psql
GRANT CONNECT ON DATABASE postgres TO replicator;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO replicator;
create publication pg_pub for table test;
exit;
```

Создадим новый сервер `pgstandalone` для логической репликации
```shell
docker run -dit -v "$PWD/volumes/pgstandalone/:/var/lib/postgresql/data" -e POSTGRES_PASSWORD=pass -p "35432:5432" --restart=unless-stopped --network=pgnet --name=pgstandalone postgres
```

Копируем файлы c `pgslave` в `pgstandalone` и восстанавливаем
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

Создаем подписку на `pgstandalone`
```shell
docker exec -it pgstandalone su - postgres -c psql
CREATE SUBSCRIPTION pg_sub CONNECTION 'host=pgslave port=5432 user=replicator password=pass dbname=postgres' PUBLICATION pg_pub;
exit;
```

Убеждаемся что репликация запущена
```shell
docker exec -it pgstandalone su - postgres -c psql
select * from test;
exit;
```

Сделаем конфликт в данных

Вставляем данные в подписчике `pgstandalone`
```shell
docker exec -it pgstandalone su - postgres -c psql
insert into test values(9);
exit;
```

Вставляем данные в паблишере `pgslave`
```shell
docker exec -it pgslave su - postgres -c psql
insert into test values(9);
insert into test values(10);
exit;
```

Убеждаемся что записи с id 10 не появилось на `pgstandalone`
```shell
docker exec -it pgstandalone su - postgres -c psql
select * from test;
exit;
```

Посмотрим в логи `pgstandalone` и убедимся что у нас произошел разрыв репликации
```shell
docker logs pgstandalone

2023-03-27 16:15:02.753 UTC [258] ERROR:  duplicate key value violates unique constraint "test_pkey"
2023-03-27 16:15:02.753 UTC [258] DETAIL:  Key (id)=(9) already exists.
2023-03-28 18:30:42.893 UTC [108] CONTEXT:  processing remote data for replication origin "pg_16395" during message type "INSERT" for replication target relation "public.test" in transaction 739, finished at 0/3026450
```

Исправляем конфликт
```shell
docker exec -it pgstandalone su - postgres -c psql
SELECT pg_replication_origin_advance('pg_16395', '0/3026451'::pg_lsn); # message from log + 1
ALTER SUBSCRIPTION pg_sub ENABLE;
select * from test;
exit;
```
***
## Мета информация
**Область**:: [[../../../meta/zero/00 PostgreSQL|00 PostgreSQL]]
**Родитель**:: [[Репликация в PostgreSQL|Репликация в PostgreSQL]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-06-17]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
