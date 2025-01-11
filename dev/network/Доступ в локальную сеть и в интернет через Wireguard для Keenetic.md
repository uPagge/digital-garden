---
aliases: 
tags:
  - maturity/🌱
date: 2024-09-08
zero-link:
  - "[[../../meta/zero/00 Сети|00 Сети]]"
parents: 
linked:
---
В данной заметке я расскажу, как организовать соединение с вашей локальной сетью за роутером Keenetic, если у вас уже настроен выход в интернет через WG сервер с роутера и телефона.

Благодаря VPN файлы из моей домашней сети всегда доступны, где бы я не был.

Как я уже говорил у вас уже должен быть настроен Wireguard сервер, роутер и телефон должны выходить через этот сервер в интернет. Я же расскажу, как с телефона попасть в локальную сеть за роутером с использованием Wireguard, и при этом не потерять VPN выход в интернет. Для этого нужно будет использовать консоль роутера Keenetic.
## Настройка Keenetic
Если доступа в консоль нет, то его надо включить. Для этого перейдите в раздел “Управление” -> “Пользователи и доступ”. Проверьте что установлен порт управления по SSH и активирован пункт “Подключения к командной строке по SSH”.

![](../../meta/files/images/Pasted%20image%2020240908111536.png)

Также убедитесь, что у вас есть пользователь, у которого есть права входа через SSH. На той же странице у вас есть список пользователей. Зайдите в редактор прав пользователя, и убедитесь что у него активирован пункт “Доступ к командной строке (TELNET и SSH)”.

![](../../meta/files/images/Pasted%20image%2020240908111551.png)

Теперь заходим в консоль управления роутером.

```shell
ssh username@192.168.0.1
(config)>
```

Первым делом нам надо узнать, какой интерфейс был присвоен нашему соединению на роутере. Если это ваше первое соединение с Wireguard, то скорее всего это Wireguard0. Но давайте убедимся в этом.

Для этого необходимо ввести `interface Wire` и нажать `Tab`:

```shell
(config)> interface Wire

    Usage template:
        interface {name}

    Choose:
        Wireguard
        Wireguard0
```

Чтобы точно убедиться выведите информацию об интерфейса.

```shell {6,13}
(config)> show interface Wireguard0

    id: Wireguard0
    index: 1
    type: Wireguard
    description: vpn-example
    interface-name: Wireguard0
    link: up
    connected: yes
    state: up
    mtu: 1324
    tx-queue-length: 50
    address: 10.66.67.2
    mask: 255.255.255.255
    uptime: 5
    global: no
    security-level: public

        wireguard:
           public-key: PUBLIC_KEY
          listen-port: 48951
               status: up

                 peer:
               public-key: PUBLIC_KEY
                    local: 37.112.97.194
               local-port: 48951
                      via: PPPoE0
                   remote: 3.64.232.61
              remote-port: 54161
                  rxbytes: 92
                  txbytes: 180
           last-handshake: 5
                   online: yes
```

По названию и адресу понимаем, что это нужное соединение.

![](../../meta/files/images/Pasted%20image%2020240908112035.png)

Нужно добавить правило на IN, иначе запросы в локальную сеть будут дропаться. Не забудьте заменить `Wireguard0` на другое значение, если у вас задействован другой интерфейс.

```shell
(config)> interface Wireguard0
Core::Configurator: Done.
(config-if)> ip access-group _WEBADMIN_Wireguard0 in
Network::Acl: Input "_WEBADMIN_Wireguard0" access list added to "Wireguard0".
(config-if)> system configuration save
Core::ConfigurationSaver: Saving configuration...
```

Теперь надо добавить статический маршрут до сети Wireguard.

```shell
(config)> ip route 10.66.67.0 255.255.255.0 Wireguard0 auto
Network::RoutingTable: Added static route: 10.66.67.0/24 via Wireguard0.
```

> [!DANGER]
> Не забудьте заменить значения на свои. `10.66.67.0` на свою подсеть Wireguard, а `Wireguard0` на свой интерфейс.
## Настройка сервера WG
Теперь нужно настроить сервер Wireguard. Для этого нужно отредактировать файл конфигурации, обычно он лежит в папке `/etc/wireguard/wg0.conf`. Зайдите под root.

```shell
su
nano /etc/wireguard/wg0.conf
```

```toml
[Interface]
Address = 10.66.67.1/24,fd42:42:43::1/64
ListenPort = 54161
PrivateKey = PRIVATE_KEY
PostUp = iptables -A FORWARD -i eth0 -o wg0 -j ACCEPT; iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE; ip6tables $
PostDown = iptables -D FORWARD -i eth0 -o wg0 -j ACCEPT; iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE; ip6table$

### Client router
[Peer]
PublicKey = PUBLIC_KEY
PresharedKey = PRESHARED_KEY
AllowedIPs = 10.66.67.2/32,fd42:42:43::2/128,192.168.1.0/24

### Client phone
[Peer]
PublicKey = PUBLIC_KEY
PresharedKey = PRESHARED_KEY
AllowedIPs = 10.66.67.3/32,fd42:42:43::3/128
```

У нас тут все стандартно. Два пира, один из них роутер, второй телефон. Для роутера необходимо указать в `AllowedIPs` вашу локальную сеть, в данном случае `192.168.1.0/24`.

После этого отключим и включим WG соединение.

```shell
wg-quick down wg0
[#] ip link delete dev wg0
[#] iptables -D FORWARD -i eth0 -o wg0 -j ACCEPT; iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE; ip6tables -D FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
wg-quick up wg0
[#] ip link add wg0 type wireguard
[#] wg setconf wg0 /dev/fd/63
[#] ip -4 address add 10.66.67.1/24 dev wg0
[#] ip -6 address add fd42:42:43::1/64 dev wg0
[#] ip link set mtu 8921 up dev wg0
[#] ip -4 route add 192.168.0.0/24 dev wg0
[#] iptables -A FORWARD -i eth0 -o wg0 -j ACCEPT; iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE; ip6tables -A FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
```

После этого у вас должен появится доступ к локальной сети роутера с телефона через Wireguard VPN. По аналогии можно настроить доступ к локальной сети для остальных устройств.
***
## Мета информация
**Область**:: [[../../meta/zero/00 Сети|00 Сети]]
**Родитель**:: 
**Источник**:: 
**Автор**:: 
**Создана**:: [[2024-09-08]]
### Дополнительные материалы
- [Установка VPN с AmneziaWG на роутеры Keenetic | Amnezia Docs](https://docs.amnezia.org/ru/documentation/instructions/keenetic-os-awg/)
### Дочерние заметки
<!-- QueryToSerialize: LIST FROM [[]] WHERE contains(Родитель, this.file.link) or contains(parents, this.file.link) -->
