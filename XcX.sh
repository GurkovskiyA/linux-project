#!/bin/bash

LOG_FILE="/var/log/system_monitor.log"

# Функция логирования
log_info() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | sudo tee -a "$LOG_FILE"
}

# Проверяем использование диска
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -gt 80 ]; then
    log_info "WARNING: Disk usage is ${DISK_USAGE}%"
fi

# Проверяем использование памяти
MEMORY_USAGE=$(free | awk 'NR==2{printf "%.0f", $3*100/$2}')
if [ "$MEMORY_USAGE" -gt 80 ]; then
    log_info "WARNING: Memory usage is ${MEMORY_USAGE}%"
fi

# Проверяем загрузку системы
LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
log_info "Current load average: $LOAD_AVG"
