---
aliases:
  - firewalld
tags:
  - maturity/🌱
date:
  - - 2024-08-03
---
**Проверка статуса FirewallD**
- `firewall-cmd --state` – Проверить текущий статус FirewallD.
- `firewall-cmd --get-active-zones` – Показать активные зоны.
- `firewall-cmd --list-all` – Показать все правила для зоны по умолчанию.
    
**Включение/Отключение FirewallD**
- `systemctl start firewalld` – Включить FirewallD.
- `systemctl stop firewalld` – Отключить FirewallD.
- `systemctl enable firewalld` – Включить автозапуск FirewallD при загрузке системы.
- `systemctl disable firewalld` – Отключить автозапуск FirewallD при загрузке системы.

**Разрешение/Блокировка трафика**
- `firewall-cmd --add-port=<port>/tcp` – Разрешить трафик на определенный порт (например, 22/tcp для SSH).
- `firewall-cmd --remove-port=<port>/tcp` – Заблокировать трафик на определенный порт.
- `firewall-cmd --add-service=<service>` – Разрешить трафик для определенного сервиса (например, 'http', 'https').
- `firewall-cmd --remove-service=<service>` – Заблокировать трафик для определенного сервиса.

**Разрешение/Блокировка трафика с условиями**
- `firewall-cmd --add-rich-rule='rule family="ipv4" source address="<IP>" port port="<port>" protocol="tcp" accept'` – Разрешить трафик от определенного IP и порта.
- `firewall-cmd --add-rich-rule='rule family="ipv4" source address="<IP>" port port="<port>" protocol="tcp" reject'` – Заблокировать трафик от определенного IP и порта.

**Удаление правил**
- `firewall-cmd --remove-port=<port>/tcp` – Удалить правило разрешения для порта.
- `firewall-cmd --remove-service=<service>` – Удалить правило разрешения для сервиса.
- `firewall-cmd --remove-rich-rule='<rule>'` – Удалить rich-rule правило.

**Зоны и профили FirewallD**
- `firewall-cmd --get-zones` – Показать доступные зоны.
- `firewall-cmd --zone=<zone> --list-all` – Показать все правила для указанной зоны.
- `firewall-cmd --zone=<zone> --add-port=<port>/tcp` – Добавить правило для конкретной зоны.

**Логирование и мониторинг**
- `firewall-cmd --set-log-denied=all` – Включить логирование всех отклоненных подключений.
- `firewall-cmd --query-log-denied` – Проверить текущее состояние логирования отклоненных подключений.

**Настройки по умолчанию**
- `firewall-cmd --set-default-zone=<zone>` – Установить зону по умолчанию для новых подключений.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Linux|00 Linux]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-08-03]]
### Дополнительные материалы
- 
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
