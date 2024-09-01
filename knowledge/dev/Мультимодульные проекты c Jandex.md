---
aliases:
  - jandex
tags:
  - зрелость/🌱
date: "[[2023-10-21]]"
zero-link:
  - "[[../../garden/ru/meta/zero/00 Разработка]]"
parents:
  - "[[Quarkus]]"
linked:
  - "[[Gradle]]"
---
Столкнулся с такой проблемой при использовании [Quarkus](Quarkus.md). Gradle проект, который состоит из нескольких модулей успешно собирался, но бины из одного модуля не обнаруживались в другом. Та же проблема будет и с [Maven](Maven.md). Эта проблема решилась с помощью специального плагина: Jandex. Есть версия как для Gradle, так и для [Maven](Maven.md).

[GitHub: Jandex Gradle Plugin](https://github.com/kordamp/jandex-gradle-plugin)

Пример настройки в корневом `build.gradle`

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

apply plugin: "org.kordamp.gradle.jandex"

subprojects {
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