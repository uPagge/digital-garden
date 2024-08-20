---
aliases: 
tags:
  - зрелость/🌱
date: [[2024-07-03]]
zero-link: 
parents: 
linked:
---
![](Pasted%20image%2020240820133224.png)

Синхронизировать через файл `/var/lib/rabbitmq/.erlang.cookie`
```
rabbitmqctl stop_app
rabbitmqetl join_cluster -ram rabbit@master
rabbitmqctl start_app
```

По умолчанию [Queue](Queue.md) не синхронизированы. Включение зеркалирования очередей:
```
rabbitmqctl set_policy ha-all ".*" {"ha-mode":"all","ha-sync-mode": "automatic"}'
```