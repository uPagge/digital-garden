---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-04-07
zero-link:
  - "[[Quarkus|00 Quarkus]]"
parents: 
linked:
---
На самом деле все просто. Необходимо добавить определенные флаги в команду сборки [Gradle](Gradle.md).

```gradle
gradle build -Dquarkus.package.type=native -Dquarkus.native.remote-container-build=true
```

```maven
./mvnw package -Dnative -Dquarkus.native.remote-container-build=true
```

Во время сборки будет скачан докер образ с GraalVM и сборка будет проходить уже в этом образе. То есть можно использовать любой текущий раннер. В нашем случае раннер с тегом `java17`.

А вот так выглядит Dokerfile сервиса:
```Dockerfile
FROM registry.access.redhat.com/ubi8/ubi-minimal:8.6
WORKDIR /work/
RUN chown 1001 /work \
    && chmod "g+rwX" /work \
    && chown 1001:root /work
COPY ./build/*-runner /work/application

EXPOSE 8080
USER 1001

CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
```

Вот и все.

### Более сложный путь
Оставлю это тут на всякий случай. Первый сборки использовали кастомный образ с GraalVM

```Dockerfile
FROM ghcr.io/graalvm/graalvm-ce:ol9-java17-22.3.0
WORKDIR /opt/graalvm
RUN gu install native-image
RUN microdnf -y install dnf-plugins-core
RUN microdnf -y install yum
RUN yum install -y yum-utils
RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
RUN yum install -y docker-ce docker-ce-cli containerd.io
```