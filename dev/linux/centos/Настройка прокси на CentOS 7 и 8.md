---
aliases: 
tags:
  - maturity/🌱
date: 2024-09-08
zero-link:
  - "[[../garden/ru/meta/zero/00 Linux|00 Linux]]"
parents: 
linked:
---
Ремарка, которую можно пропустить: Помню свой первый день на работе, тогда мне поручили настраивать сервер на CentOS 7. Установить необходимые пакеты, уже не помню точно что, но не суть. Я тогда еще обладатель ПК на windows погуглил и нашел команду `yum install pack_name`.

И как же я был удивлен, когда это не сработало. Корпоративные сервера чаще всего находятся в изоляции от интернета, и для доступа необходимо настраивать прокси. Но я тогда не знал об этом, и устанавливал пакеты вручную, скачивая их сначала к себе и перенося на сервер, то еще занятие, на это ушел целый день 😄

Потом я узнал о существовании прокси, которое открывало доступ в интернет. Сейчас расскажу, как его настроить.

Особенность использования прокси в том, что его надо настраивать везде. Недостаточно настроить только на уровне ОС, надо также настроить на уровне каждого приложения, даже у пакетного менеджера типа `yum` и `dnf`, нужно указать прокси.
## Настройка для ОС
Первым делом настраиваем прокси на linux машине. Для этого нужно установить значения для некоторых переменных среды.

Если прокси без пароля:

```shell
export http_proxy="http://SERVER:PORT/"
export https_proxy="http://SERVER:PORT/"
export no_proxy="127.0.0.1,localhost"
export HTTP_PROXY="http://SERVER:PORT/"
export HTTPS_PROXY="http://SERVER:PORT/"
export NO_PROXY="127.0.0.1,localhost"
```

Если у вас есть логин и пароль:

```shell
export http_proxy="http://USERNAME:PASSWORD@SERVER:PORT/"
export https_proxy="http://USERNAME:PASSWORD@SERVER:PORT/"
export no_proxy="127.0.0.1,localhost"
export HTTP_PROXY="http://USERNAME:PASSWORD@SERVER:PORT/"
export HTTPS_PROXY="http://USERNAME:PASSWORD@SERVER:PORT/"
export NO_PROXY="127.0.0.1,localhost"
```

> [!WARNING]
> Если в имени пользователя или пароле используется символ `@`, добавьте обратную косую черту (`\`) перед `@`.


Данным способом мы установили временное прокси, ==после перезагрузки подключение пропадет.== Чтобы добавить постоянное прокси, нужно изменить файл `/etc/environment`.

Если вам повезло и редактор nano был предустановлен, то воспользуйтесь им, добавив следующие строчки:

```shell
sudo nano /etc/environment

export http_proxy="http://USERNAME:PASSWORD@SERVER:PORT/"
export https_proxy="http://USERNAME:PASSWORD@SERVER:PORT/"
export no_proxy="127.0.0.1,localhost"
export HTTP_PROXY="http://USERNAME:PASSWORD@SERVER:PORT/"
export HTTPS_PROXY="http://USERNAME:PASSWORD@SERVER:PORT/"
export NO_PROXY="127.0.0.1,localhost"
```

Если повезло чуть меньше, и установлен только редактор vi. Инструкция будет чуть сложнее, сначала открываем файл в редакторе:

```shell
sudo vi /etc/environment
```

Далее необходимо нажать клавишу i, чтобы войти в режим редактирования, после вставляем наши заветные строчки:

```shell
export http_proxy="http://USERNAME:PASSWORD@SERVER:PORT/"
export https_proxy="http://USERNAME:PASSWORD@SERVER:PORT/"
export no_proxy="127.0.0.1,localhost"
export HTTP_PROXY="http://USERNAME:PASSWORD@SERVER:PORT/"
export HTTPS_PROXY="http://USERNAME:PASSWORD@SERVER:PORT/"
export NO_PROXY="127.0.0.1,localhost"
```

Чтобы сохранинть изменения санчала нажмите `ESC`, а далее наберите `:wq`, чтобы выйти без сохранения нажмите `ESC` и наберите просто `:q`

Если вам совсем не повезло, и по какой-то причине редакторов совсем не предустановлено, то воспользуйтесь следующей командой:

```shell
sudo cat >> /etc/environment << EOFXX
export http_proxy="http://USERNAME:PASSWORD@SERVER:PORT/"
export https_proxy="http://USERNAME:PASSWORD@SERVER:PORT/"
export no_proxy="127.0.0.1,localhost"
export HTTP_PROXY="http://USERNAME:PASSWORD@SERVER:PORT/"
export HTTPS_PROXY="http://USERNAME:PASSWORD@SERVER:PORT/"
export NO_PROXY="127.0.0.1,localhost"
EOFXX
```
## Настройка для пакетных менеджеров
Теперь настроим прокси для пакетных менеджеров `yum` и `dnf`. Для этого отредактируем файл `/etc/yum.conf`, добавив в конец следующие строки:

```toml
proxy=http://SERVER:PORT
```

Для авторизации укажите также следующие строки:

```toml
proxy_username=USERNAME
proxy_password=PASS
proxy_auth_method=basic
```