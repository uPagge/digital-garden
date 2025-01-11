---
aliases: 
tags:
  - maturity/🌱
date: 2024-11-03
---

**Проверка правил**
- `iptables -L` — Показать все правила.
- `iptables -L -v -n` — Показать правила с подробной информацией и числовыми адресами.
- `iptables -S` — Показать все правила в формате, который можно использовать повторно.

**Очистка правил**
- `iptables -F` — Очистить все правила во всех цепочках.
- `iptables -X` — Удалить все пользовательские цепочки.
- `iptables -Z` — Обнулить счетчики пакетов и байтов.

**Установка политики по умолчанию**
- `iptables -P INPUT ACCEPT` — Установить политику по умолчанию для цепочки INPUT.
- `iptables -P FORWARD ACCEPT` — Установить политику по умолчанию для цепочки FORWARD.
- `iptables -P OUTPUT ACCEPT` — Установить политику по умолчанию для цепочки OUTPUT.

**Разрешение и запрет трафика**
- `iptables -A INPUT -p tcp --dport <порт> -j ACCEPT` — Разрешить входящий трафик на определенный порт.
- `iptables -A INPUT -s <IP> -j ACCEPT` — Разрешить трафик с определенного IP-адреса
- `iptables -A INPUT -p tcp --dport <порт> -j DROP` — Запретить входящий трафик на определенный порт.
- `iptables -A INPUT -s <IP> -j DROP` — Запретить трафик с определенного IP-адреса.

**Условные разрешения и запреты трафика**
- `iptables -A INPUT -p tcp -s <IP> --dport <порт> -j ACCEPT` — Разрешить трафик с IP на конкретный порт.
- `iptables -A INPUT -p tcp -s <IP> --dport <порт> -j DROP` — Запретить трафик с IP на конкретный порт.

**Удаление правил**
- `iptables -D INPUT <номер-правила>` — Удалить правило по его номеру.
- `iptables -D INPUT -p tcp --dport <порт> -j ACCEPT` — Удалить конкретное правило.
  
**Работа с цепочками**
- `iptables -N <имя-цепочки>` — Создать новую цепочку.
- `iptables -X <имя-цепочки>` — Удалить пользовательскую цепочку.
- `iptables -A INPUT -j <имя-цепочки>` — Переход к пользовательской цепочке.

**NAT и перенаправление портов**
- `iptables -t nat -A POSTROUTING -o <интерфейс> -j MASQUERADE` — Включить NAT на интерфейсе.
- `iptables -t nat -A PREROUTING -p tcp --dport <порт> -j DNAT --to-destination <IP>:<порт>` — Перенаправление трафика с одного порта на другой.

**Сохранение и восстановление правил**
- `iptables-save > /etc/iptables/rules.v4` — Сохранить правила IPv4 в файл.
- `iptables-restore < /etc/iptables/rules.v4` — Восстановить правила IPv4 из файла.

**Логирование**
- `iptables -A INPUT -p tcp --dport <порт> -j LOG --log-prefix "IPTables-Dropped: " --log-level 4` — Логировать сброшенные пакеты.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Linux|00 Linux]]
**Родитель**:: 
**Источник**:: 
**Создана**:: [[2024-11-03]]
**Автор**:: 
### Дополнительные материалы
- 

### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->

