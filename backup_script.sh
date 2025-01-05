#!/bin/bash

# 获取环境变量
MYSQL_HOST=${MYSQL_HOST:-"192.168.0.2"}
MYSQL_PORT=${MYSQL_PORT:-"3306"}
MYSQL_USER=${MYSQL_USER:-"root"}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-"password"}
MYSQL_DATABASE="db_name"
BACKUP_DIR="${BACKUP_DIR:-"/backup"}"

# 创建备份目录（如果不存在）
mkdir -p "$BACKUP_DIR"

# 设置备份文件名称（包含时间戳）
BACKUP_FILENAME="$BACKUP_DIR/blog_$(date +'%Y%m%d%H%M%S').sql.gz"

# 执行mysqldump命令并压缩备份文件
mysqldump -h $MYSQL_HOST -P $MYSQL_PORT -u$MYSQL_USER -p$MYSQL_PASSWORD --single-transaction $MYSQL_DATABASE | gzip > $BACKUP_FILENAME

echo "Database backup of blog has been created at $BACKUP_FILENAME"

