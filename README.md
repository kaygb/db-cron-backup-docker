```
docker build -t kezez.com/db-cron-backup-docker .
docker run -it -v /path/backup:/backup
docker run -v /path/backup:/backup -d --name db-cron-backup-docker kezez.com/db-cron-backup-docke
```

