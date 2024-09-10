---
aliases: 
tags:
  - maturity/🌱
date: 2023-10-21
zero-link:
  - "[[../../meta/zero/00 Gradle|00 Gradle]]"
parents: 
linked:
---
Чтобы автоматизировать релизы можно использовать специальный Gradle Plugin: [GitHub - researchgate/gradle-release](https://github.com/researchgate/gradle-release)

Плагин выполняет следующие действия:
- Проверяет наличие не зафиксированных изменений
- Проверяет наличие не опубликованных изменений в удаленный репозиторий
- Проверяет наличие SNAPSHOT зависимостей в файле `gradle.properties`
- Меняет версию сервиса со SNAPSHOT на релизную. В диалоговом режиме, но можно использовать флаги при работе в CI.
- Делает коммит.
- Меняет версию сервиса с релизной на новый SNAPSHOT. В диалоговом режиме.
- Автоматически публикует изменения, если удаленный репозиторий называется `origin`. Можно отключить или сконфигурировать названия веток.

Настройка плагина в корневом файле `build.gradle`:

```gradle
buildscript {  
    repositories {  
        gradlePluginPortal()  
        mavenCentral()  
    }  
    dependencies {  
        classpath 'org.kordamp.gradle:jandex-gradle-plugin:1.0.0'
    }  
}

apply plugin: "net.researchgate.release"  
release {  
    createReleaseTag.enabled = false  
    pushReleaseVersionBranch = 'rc'  
    preTagCommitMessage = 'Candidate release version commit: '  
    newVersionCommitMessage = 'New develop version commit: '  
    git {  
        requireBranch.set('developer')  
    }  
}
```

- `createReleaseTag.enabled = false` - отключает проставление релизного тега
- `pushReleaseVersionBranch = 'rc'` - запушит релиз в ветку rc
- `preTagCommitMessage` и `newVersionCommitMessage` задает текст в релизных коммитах
- `requireBranch` позволят настроить из какой ветки можно будет выпускать релизы.

Можно изменить конфигурацию формата версии для разработки. По умолчанию меняется патч версия. Вот эта конфигурация изменит минорную версию.

```
versionPatterns = [  
        /(\d+)\.\d+([^\d]*$)/: { Matcher m, Project p -> m.replaceAll("${(m[0][1] as int) + 1}.0${m[0][3] ? m[0][3] : ""}") }  
]
```

Запустить выполнение плагина:

```bash
gradle relase
```

Пример того, как будут выглядеть коммиты в Git

![](Pasted%20image%2020231021121612.png)
***
## Мета информация
**Область**:: [[../../meta/zero/00 Gradle|00 Gradle]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2023-10-21]]
### Дополнительные материалы
- [GitHub - researchgate/gradle-release](https://github.com/researchgate/gradle-release)
- [Автоматизация рутины при выпуске релизов с Maven](https://struchkov.dev/blog/ru/release-releases-with-maven/)
### Дочерние заметки
```dataview
LIST 
FROM [[]]
WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link)
```