FROM ubuntu:latest
MAINTAINER docker@ekito.fr

# 设置工作目录
WORKDIR /app
RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list

RUN apt-get update && apt-get -y install cron

# 设置环境变量
ENV MYSQL_HOST="192.168.0.2"
ENV MYSQL_PORT="3306"
ENV MYSQL_USER="root"
ENV MYSQL_PASSWORD="password"
ENV MYSQL_DATABASE="db_name"
ENV BACKUP_DIR="/backup"

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 将备份脚本复制到容器内
COPY backup_script.sh .
RUN chmod +x /app/backup_script.sh

# 添加crontab文件到镜像中
COPY crontab /etc/cron.d/db-cron
RUN chmod 0644 /etc/cron.d/db-cron
RUN crontab /etc/cron.d/db-cron
RUN touch /var/log/cron.log

CMD ["cron", "-f"]

