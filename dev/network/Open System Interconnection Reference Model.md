---
aliases:
  - OSI
  - Модель OSI
tags:
  - maturity/🌱
date:
  - - 2024-01-11
---

> [!WARNING]
> Теоретическая модель, которая на практике не используется

![[../../meta/files/images/Pasted image 20241103020737.png]]
- **Шаг 1**: Когда Устройство A отправляет данные на Устройство B по сети через протокол [[HTTP]], к данным сначала добавляется HTTP-заголовок на уровне приложения.
- **Шаг 2**: Затем к данным добавляется заголовок [[../../../../knowledge/dev/network/TCP|TCP]] или [[../../../../knowledge/dev/network/UDP|UDP]]. На транспортном уровне данные инкапсулируются в TCP-сегменты, содержащие информацию о портах отправителя и получателя, а также номер последовательности.
- **Шаг 3**: Сегменты инкапсулируются с IP-заголовком на сетевом уровне. IP-заголовок содержит IP-адреса отправителя и получателя.
- **Шаг 4**: На канальном уровне к IP-датаграмме добавляется MAC-заголовок с MAC-адресами отправителя и получателя.
- **Шаг 5**: Инкапсулированные кадры передаются на физический уровень и отправляются по сети в виде бинарных данных.
- **Шаги 6-10**: Когда Устройство B получает биты из сети, оно выполняет процесс деинкапсуляции, то есть обратный процесс инкапсуляции. Заголовки удаляются слой за слоем, и в итоге Устройство B может прочитать полученные данные.


| Уровень | DataUnit | Описание |
| ---- | ---- | ---- |
| Physical | Bit | Сигналы |
| Data link | Frame |  |
| Network | Packet |  |
| Transport | Segment |  |
| Session | Data |  |
| Presentation | Data |  |
| Application | Data |  |

Модель OSI в применение к TCP/IP

| Physical     | wire, radio, fiber optic                                             |
| ------------ | -------------------------------------------------------------------- |
| Data link    | Ethernet, Token ring, PPP, HDLC, Frame relay, ISDN, ATM, Wi-Fi, FDDI |
| Network      | IP/IPv6, ICMP, IGMP, X.25, CLNP, [[Address Resolution Protocol\|ARP]], RARP, BGP, OSPF, RIP, IPX, DDP |
| Transport    | [[TCP]], [[UDP]], RTP, SCTP, SPX, ATP                                        |
| Session      | TLS, [[SSH]], ISO 8327 / CCITT X.255, RPC, NetBIOS, ASP                  |
| Presentation | XDR, ASN.1, SMB, AFP                                                 |
| Application  | HTTP, SMTP, SNMP, FTP, Telnet, [[SSH]], SCP, NFS, RTSP                   |