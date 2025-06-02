#!/bin/bash
# backup.sh - простая система бэкапа

SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/backup"
DATE=$(date +%Y%m%d_%H%M%S)

# Создаем папку для бэкапов
mkdir -p "$BACKUP_DIR"

# Создаем архив
tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" "$SOURCE_DIR"

echo "Backup created: $BACKUP_DIR/backup_$DATE.tar.gz"

# Удаляем старые бэкапы (старше 7 дней)
find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +7 -delete
