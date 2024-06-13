---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-03-01
zero-link:
  - "[[00 DevOps]]"
parents:
  - "[[Git]]"
---
Когда запускается пайплайн он работает не с git репозиторием, а с его слепком. По факту с файлами из коммита, но не с самим репозиторием.

Но можно подключить репозиторий. Это обычно требуется, когда необходимо сделать какие-то действия и закоммитить изменения прямо в пайпе, после чего отправить их. Например, [Автоматизация релиза с помощью Gradle](Автоматизация%20релиза%20с%20помощью%20Gradle.md).

Вот команды, которые позволят привязать git-репозиторий к слепку.

```
git config --global user.email "git@upagge.ru
git config --global user.name "Gitlab Runner"
git remote set-url origin https://$GITLAB_USER_LOGIN:$GITLAB_TOKEN@gitlab.com/uPagge/dolboblog.git
git checkout master && git pull
```


> [!WARNING] Git в образе
> Для этого в образе раннера должен быть установлен [Git](Git.md).
