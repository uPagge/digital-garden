---
aliases:
  - юбикей
tags:
  - зрелость/🌱
date:
  - - 2024-01-09
zero-link:
  - "[[00 DevOps]]"
linked:
---

## Заметки
- 
## Первичная настройка
Вставляем юбикей и вводим команду
```
gpg --card-status
```

В новом юбикей вывод будет примерно такой
```
Reader ...........: Yubico YubiKey OTP FIDO CCID
Application ID ...: D2760001240100000006223209330000
Application type .: OpenPGP
Version ..........: 3.4
Manufacturer .....: Yubico
Serial number ....: 22320933
Name of cardholder: [не установлено]
Language prefs ...: [не установлено]
Salutation .......: 
URL of public key : [не установлено]
Login data .......: [не установлено]
Signature PIN ....: не требуется
Key attributes ...: rsa2048 rsa2048 rsa2048
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 0 3
Signature counter : 0
KDF setting ......: off
UIF setting ......: Sign=off Decrypt=off Auth=off
Signature key ....: [none]
Encryption key....: [none]
Authentication key: [none]
```
### Смена пинкодов
- Сменить pin.
	- По умолчанию pin: 123456
- Сменить puk.
	- По умолчанию puk: 12345678
- Сменить managment key
  
Сменить pin для gpg
```
ubuntu@ubuntu:~/Desktop$ gpg --edit-card

Reader ...........: 1050:04cccccccccccdf:0
Application ID ...: D2ccccccccc00
Application type .: OpenPGP
Version ..........: 3.4
Manufacturer .....: Yubico
Serial number ....: 2057xxxxx
Name of cardholder: [not set]
Language prefs ...: [not set]
Salutation .......: 
URL of public key : [not set]
Login data .......: [not set]
Signature PIN ....: not forced
Key attributes ...: rsa2048 rsa2048 rsa2048
Max. PIN lengths .: 127 127 127
PIN retry counter : 3 0 3
Signature counter : 0
KDF setting ......: off
Signature key ....: [none]
Encryption key....: [none]
Authentication key: [none]
General key info..: [none]

gpg/card> admin   (go to admin mode)
Admin commands are allowed

gpg/card> passwd 
gpg: OpenPGP card no. D2xxxxxxxxxxxxxxxxxxxxxxxx000 detected

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? 1
Error changing the PIN: Bad PIN

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? 1  (the default PIN is 123456)
PIN changed.

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? 3 (the default admin PIN is 12345678)
PIN changed.

1 - change PIN
2 - unblock PIN
3 - change Admin PIN
4 - set the Reset Code
Q - quit

Your selection? q

gpg/card> quit
```


### Перенос gpg ключа
Сначала генерируем gpg ключ

Для переноса существующего ключа используем команду
```shell
gpg --edit-key <KEY_ID>
```

После входа в режим редактирования можно использовать команду
```shell
keytocard
```

## Полезные материалы
- [Полный обзор Yubikey - YouTube](https://www.youtube.com/watch?v=fv2ZY7aXWv0)