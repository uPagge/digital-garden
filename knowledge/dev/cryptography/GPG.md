---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-01-09
zero-link:
  - "[[00 Криптография]]"
parents: 
linked:
---
## Полезные команды
Посмотреть все ключи:
```shell
gpg --list-keys --keyid-format=long
```

Посмотреть все доступные **приватные** ключи:
```shell
gpg --list-secret-keys --keyid-format=long
```

Позволяет проверить Yubikey
```shell
gpg --card-status
```

Экспорт публичного ключа
```shell
gpg --armor --export <KEY_ID>
```

Экспорт **приватного** ключа
```shell
gpg --armor --export-secret-key <KEY_ID>
```

Удалить ключ
```shell
gpg --delete-key [uid]
```

Удалить **секретный** ключ
```shell
gpg --delete-secret-key [uid]
```
## Генерация нового ключа
Генерация нового ключа
```shell
gpg --full-generate-key
```

Нам предложат выбрать тип создаваемого ключа

```
Выберите тип ключа:
   (1) RSA and RSA
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
   (9) ECC (sign and encrypt) *default*
  (10) ECC (только для подписи)
  (14) Existing key from card
```

Самый современный способ установлен по умолчанию (9). Также можно выбрать вариант (10). В нашем случае между ними не будет разницы.

Далее выбираем элептическую кривую. Также оставляем по умолчанию (1):

```
Выберите эллиптическую кривую:
   (1) Curve 25519 *default*
   (4) NIST P-384
   (6) Brainpool P-256
```

Теперь устанавливаем срок действия ключа.

```
Выберите срок действия ключа.
         0 = не ограничен
      <n>  = срок действия ключа - n дней
      <n>w = срок действия ключа - n недель
      <n>m = срок действия ключа - n месяцев
      <n>y = срок действия ключа - n лет
Срок действия ключа? (0) 1y
```

После чего надо указать информацию о себе: ФИО, почту. В примечании можно указать зачем создается этот GPG ключ, чтобы потом не путаться.

```
Ваше полное имя: Struchkov Mark
Адрес электронной почты: mark@struchkov.dev
Примечание: Key for git commit
Вы выбрали следующий идентификатор пользователя:
    "Struchkov Mark (Key for git commit) <mark@struchkov.dev>"

Сменить (N)Имя, (C)Примечание, (E)Адрес; (O)Принять/(Q)Выход? O
```

Подтверждаем введеные данные. После чего необходимо придумать пароль для защиты GPG ключа.

### Создание дополнительного ключа
Дополнительный ключ позволяет увеличить безопасность использования мастер ключа. Дополнительный ключ привязывается к тому же email что и мастер ключ, но имеет свой срок жизни. К сожалению, нельзя добавить подпись к дополнительному ключу.

```bash
gpg --expert --edit-key <KEY_ID>
```

Далее вы увидите консоль `gpg>`. Вводим туда команду `addkey` и выбираем тип ключа. Нам нужен ключ для подписи (10).

```bash
gpg> addkey

Выберите тип ключа:
   (3) DSA (sign only)
   (4) RSA (sign only)
   (5) Elgamal (encrypt only)
   (6) RSA (encrypt only)
   (7) DSA (set your own capabilities)
   (8) RSA (set your own capabilities)
  (10) ECC (только для подписи)
  (11) ECC (set your own capabilities)
  (12) ECC (encrypt only)
  (13) Existing key
  (14) Existing key from card
Ваш выбор? 10
```

Далее снова выбор элиптической кривой. Оставляем значение по умолчанию:

```bash
Выберите эллиптическую кривую:
   (1) Curve 25519 *default*
   (2) Curve 448
   (3) NIST P-256
   (4) NIST P-384
   (5) NIST P-521
   (6) Brainpool P-256
   (7) Brainpool P-384
   (8) Brainpool P-512
   (9) secp256k1
Ваш выбор? 
```

Указываем срок действия для дополнительного ключа и подтверждаем данные.

После этого важно вызывать команду save, чтобы сохранить новый ключ.

```bash
gpg> save
$
```

### Публикация публичного ключа
```shell
gpg --send-keys <KEY_ID>
```

> [!WARNING]
> Однако, эта команда по какой-то причине работает не всегда. Тогда можно загрузить ключ вручную на один из сайтов, например на [http://keyserver.ubuntu.com](http://keyserver.ubuntu.com/).
> 
> Предварительно экспортировав публичный ключ командой 
> 
> ```
> gpg --armor --export
> ```
> 


## Полезные материалы
- [How to Configure Yubikey with GPG – Generate and Import Keys - ICT Fella](https://ictfella.com/how-to-configure-yubikey-with-gpg-generate-and-import-keys/)
- [SSH, PGP, TOTP в Yubikey 5 / Хабр](https://habr.com/ru/articles/574760/)
- [The OpenNET Project: Использование USB-брелоков Yubikey для ключей GPG и SSH](https://www.opennet.ru/tips/3048_yubikey_crypt_ssh_gpg_auth.shtml)