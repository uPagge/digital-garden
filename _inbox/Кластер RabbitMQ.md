---
aliases: 
tags:
  - зрелость/🌱
date: [[2024-07-03]]
zero-link: 
parents: 
linked:
---

```
docker run -itd -p 5672:5672 -p 15672:15672 --name rabbit rabbitmq:3-management
```

```
docker exec -it rabbit bash
```

```
docker network create cluster-network
```

```
docker run -d --hostname node1.rabbit --net cluster-network --name rabbitNode1 --add-host node2.rabbit:172.24.0.3 -p  "15673:15672" -e "RABBITMQ_USE_LONGNAME=true" -e RABBITMQ_ERLANG_COOKIE="cookie" rabbitmq:3-management
```

```
docker run -d --hostname node2.rabbit --net cluster-network --name rabbitNode2 --add-host node1.rabbit:172.24.0.2 -p  "15674:15672" -e "RABBITMQ_USE_LONGNAME=true" -e RABBITMQ_ERLANG_COOKIE="cookie" rabbitmq:3-management
```
6. docker exec -it rabbitNode1 bash

7. rabbitmqctl stop_app

8. rabbitmqctl join_cluster rabbit@node2.rabbit

9. rabbitmqctl start_app

10. cd kafka-test

11. docker-compose up -d

12. docker exec -it kafka-test-kafka-1 bash

13. kafka-topics --bootstrap-server localhost:9092 --topic test --create

14. kafka-topics --bootstrap-server localhost:9092 --list

15. kafka-console-consumer --bootstrap-server localhost:9092 --topic test

16. kafka-console-producer --bootstrap-server localhost:9092 --topic test

Синхронизировать через файл `/var/lib/rabbitmq/.erlang.cookie`
```
rabbitmqctl stop_app
rabbitmqetl join_cluster -ram rabbit@master
rabbitmqctl start_app
```

По умолчанию [Queue](Queue.md) не синхронизированы. Включение зеркалирования очередей:
```
rabbitmqctl set_policy ha-all ".*" {"ha-mode":"all","ha-sync-mode": "automatic"}'
```