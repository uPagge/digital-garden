---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-08-26
zero-link:
  - "[[00 Kafka]]"
parents: 
linked:
---
```yml
version: '3.1'

services:

  zookeeper:
    image: confluentinc/cp-zookeeper:latest
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181
      ZOOKEEPER_TICK_TIME: 2000
    ports:
      - 2181:2181

  kafka:
    image: confluentinc/cp-kafka:latest
    depends_on:
      - zookeeper
    ports:
      - 19092:19092
      - 9092:9092
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:9092,PLAINTEXT_HOST://localhost:19092
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT
      KAFKA_INTER_BROKER_LISTENER_NAME: PLAINTEXT
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1


  kafdrop:
    image: obsidiandynamics/kafdrop
    restart: "no"
    ports:
      - 9900:9000
    environment:
      KAFKA_BROKERCONNECT: "kafka:9092"
      JVM_OPTS: "-Xms16M -Xmx48M -Xss180K -XX:-TieredCompilation -XX:+UseStringDeduplication -noverify"
    depends_on:
      - "kafka"
```

```
docker-compose up -d
```

```
docker exec -it kafka-test-kafka-1 bash
```

Создание топика
```
kafka-topics --bootstrap-server localhost:9092 --topic test --create
```

Посмотреть список топиков
```
kafka-topics --bootstrap-server localhost:9092 --list
```

Добавляет консьюмера
```
kafka-console-consumer --bootstrap-server localhost:9092 --topic test
```

Позволяет добавить продюсера и отправить сообщение
```
kafka-console-producer --bootstrap-server localhost:9092 --topic test
```