---
aliases:
  - jandex
tags:
  - maturity/🌱
date: 2023-10-21
zero-link:
  - "[[../../meta/zero/00 Gradle|00 Gradle]]"
  - "[[../../meta/zero/00 Maven|00 Maven]]"
parents: 
linked:
  - "[[../../meta/zero/00 Quarkus|00 Quarkus]]"
---
Столкнулся с такой проблемой при использовании [[../../meta/zero/00 Quarkus|Quarkus]]. [[../../meta/zero/00 Gradle|Gradle]] проект, который состоит из нескольких модулей успешно собирался, но бины из одного модуля не обнаруживались в другом. Та же проблема будет и с [[../../meta/zero/00 Maven|Maven]]. 

Проблема решилась с помощью плагина: [Jandex](https://github.com/kordamp/jandex-gradle-plugin).

Пример настройки в корневом `build.gradle`

```gradle
plugins {
  id("org.kordamp.gradle.jandex") version "2.0.0"
}

buildscript {  
    repositories {  
        gradlePluginPortal()  
        mavenCentral()  
    }  
    dependencies {  
        classpath 'org.kordamp.gradle:jandex-gradle-plugin:1.0.0'
    }  
}

apply plugin: "org.kordamp.gradle.jandex"

subprojects {
	
	apply plugin: "org.kordamp.gradle.jandex"
	
	tasks.withType(Javadoc).configureEach {  
	    dependsOn('jandex')  
	    options.encoding = 'UTF-8'  
	    options.addStringOption("Xdoclint:none", "-quiet")  
	}
}

allprojects {
	tasks.matching { task ->  
	    task.name in ['quarkusDependenciesBuild']  
	}.configureEach {  
	    dependsOn 'jandex'  
	}
}
```

Пример настройки в корневом `pom.xml`

- [Maven Repository: io.smallrye » jandex](https://mvnrepository.com/artifact/io.smallrye/jandex)

```xml
<build>
	<plugins>
	    <plugin>
		    <groupId>io.smallrye</groupId>
		    <artifactId>jandex-maven-plugin</artifactId>
		    <version>3.1.6</version>
		    <executions>
			    <execution>
				    <id>make-index</id>
		            <goals>
			            <goal>jandex</goal>
		            </goals>
	            </execution>
	        </executions>
	    </plugin>
	</plugins>
</build>
```

***
## Мета информация
**Область**:: [[../../meta/zero/00 Maven|00 Maven]], [[../../meta/zero/00 Gradle|00 Gradle]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2023-10-21]]
### Дополнительные материалы
- 
### Дочерние заметки
```dataview
LIST 
FROM [[]]
WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link)
```