---
aliases: 
tags:
  - зрелость/🌱
date:
  - - 2024-06-02
zero-link:
  - "[[00 MySQL]]"
parents:
  - "[[Репликация в MySQL]]"
linked:
  - "[[Row Based Replication (RBR)]]"
  - "[[Statement Based Replication (SBR)]]"
---
Пытается взять лучшее от [SBR](Statement%20Based%20Replication%20(SBR).md) и [RBR](Row%20Based%20Replication%20(RBR).md), но получается не очень хорошо. По умолчанию был дефолтным вариантом в MySQL 5.1.

Множество условий при которых работает то как SBR, то как RBR: uuid(), user(), autoincrement.