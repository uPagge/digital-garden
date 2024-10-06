---
aliases: 
tags:
  - maturity/🌱
date:
  - - 2024-04-07
zero-link:
  - "[[../../../meta/zero/00 Quarkus|00 Quarkus]]"
parents:
  - "[[../Нативные сборки в Java|Нативные сборки в Java]]"
linked:
---
Провозился два дня, но в итоге смог собрать один из микро-сервисов в нативном режиме. Ничего сложного, но было много нюансов в настройке CICD.

Самое полезное, это вот [эта документация Quarkus](https://quarkus.io/guides/building-native-image). А конкретно флаги:
- `-Dquarkus.native.container-build=true`
- `-Dquarkus.native.remote-container-build=true`

Эти флаги необходимо добавить в команду сборки

```shell
gradle build -Dquarkus.package.type=native -Dquarkus.native.remote-container-build=true
```

```shell
./mvnw package -Dnative -Dquarkus.native.remote-container-build=true
```

Во время сборки будет скачан докер образ с GraalVM и сборка будет проходить уже в этом образе. То есть можно использовать любой раннер CI без предварительной настройки базового образа.

А вот так выглядит [Dockerfile](../../devops/docker/Dockerfile.md) сервиса:

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

Сервис стал собираться в 2,5 раза больше, около 5 минут, вместо 2. Но теперь он стартует моментально, наверное за доли секунды. При этом на под выделяется всего 256 mb ОЗУ на старте и 512 mb в момент работы.
## Более сложный путь
Также слепил образ для GitLab-раннера, который совмещает GraalVM и Docker, осталось добавить в него Gradle, но пока использую `./gradlew`. Оставлю это тут на всякий случай. 

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
***
## Мета информация
**Область**:: [[../../../meta/zero/00 Quarkus|00 Quarkus]]
**Родитель**:: [[../Нативные сборки в Java|Нативные сборки в Java]]
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-04-07]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
