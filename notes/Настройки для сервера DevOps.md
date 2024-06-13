---
tags:
  - зрелость/🌱
date: "2023-09-05"
linked:
---
```
#!/bin/bash

SITE_PATH=/opt
SITE_FOLDER=devops
USERNAME=patois
ARCHIVE_NAME=$1

tar -cvzf /home/$USERNAME/$ARCHIVE_NAME $SITE_PATH/$SITE_FOLDER
```

```
0 0 * * 6 /opt/devops/ssl_renew.sh >> /opt/devops/cron/ssl.log
```