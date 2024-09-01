---
aliases: 
tags:
  - зрелость/🌱
date: "[[2023-10-21]]"
zero-link:
  - "[[../../../garden/ru/meta/zero/00 Разработка]]"
parents: 
linked:
  - "[[Gradle]]"
link: https://github.com/researchgate/gradle-release
---
Чтобы автоматизировать релизы можно использовать специальный Gradle Plugin.

Плагин выполняет следующие действия:
- Проверяет наличие незакомиченных изменений
- Проверяет наличие не опубликованных изменений в удаленный репозиторий
- Проверяет наличие SNAPSHOT зависимостей в файле `gradle.properties`
- Меняет версию сервиса со SNAPSHOT на релизную. В диалоговом режиме.
- Делает коммит.
- Меняет версию сервиса с релизной на новый SNAPSHOT. В диалоговом режиме.
- Автоматически публикует изменения, если удаленный репозиторий называется `origin`


Настройка плагина в корневом файле `build.gradle`
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
        requireBranch.set('stage')  
    }  
}
```

- `createReleaseTag.enabled = false` - отключает проставление релизного тега
- `pushReleaseVersionBranch = 'rc'` - запушит релиз в ветку RC
- `preTagCommitMessage` и `newVersionCommitMessage` задает текст в релизных коммитах
- `requireBranch` позволят настроить из какой ветки можно будет выпускать релизы.
- [GitHub репозиторий с документацией](https://github.com/researchgate/gradle-release).

```bash
gradle relase
```

Пример того, как будут выглядеть коммиты в Git

![](Pasted%20image%2020231021121612.png)
## Дополнительные материалы
- [Автоматизация рутины при выпуске релизов с Maven](https://struchkov.dev/blog/ru/release-releases-with-maven/)