---
aliases:
  - OSI
  - Модель OSI
tags:
  - зрелость/🌱
date:
  - - 2024-01-11
zero-link:
  - "[[00 Сети]]"
parents: 
linked:
---

> [!WARNING]
> Теоретическая модель, которая на практике не используется

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

| Physical | wire, radio, fiber optic |
| ---- | ---- |
| Data link | Ethernet, Token ring, PPP, HDLC, Frame relay, ISDN, ATM, Wi-Fi, FDDI |
| Network | IP/IPv6, ICMP, IGMP, X.25, CLNP, ARP, RARP, BGP, OSPF, RIP, IPX, DDP |
| Transport | TCP, UDP, RTP, SCTP, SPX, ATP |
| Session | TLS, SSH, ISO 8327 / CCITT X.255, RPC, NetBIOS, ASP |
| Presentation | XDR, ASN.1, SMB, AFP |
| Application | HTTP, SMTP, SNMP, FTP, Telnet, SSH, SCP, NFS, RTSP |