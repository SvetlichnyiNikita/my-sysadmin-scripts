#!/bin/bash
# Мониторинг ресурсов сервера.
# Раз в INTERVAL секунд дописывает в monitor.log вывод free -h, df -h и uptime
# с отметкой времени. Остановить: Ctrl+C.

INTERVAL=5
LOG_FILE="$(dirname "$0")/monitor.log"

# проверяем, что нужные команды есть в системе
for cmd in free df uptime; do
    if ! command -v "$cmd" > /dev/null; then
        echo "Ошибка: команда $cmd не найдена" >&2
        exit 1
    fi
done

# проверяем, что в лог можно писать
if ! { : >> "$LOG_FILE"; } 2> /dev/null; then
    echo "Ошибка: нет прав на запись в $LOG_FILE" >&2
    exit 1
fi

# при Ctrl+C или kill отмечаем в логе, что мониторинг остановлен
stop() {
    echo "--- $(date '+%Y-%m-%d %H:%M:%S') мониторинг остановлен ---" >> "$LOG_FILE"
    exit 0
}
trap stop INT TERM

echo "Мониторинг запущен, пишу в $LOG_FILE каждые $INTERVAL сек. Остановка: Ctrl+C"

while true; do
    {
        echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---"
        free -h
        df -h
        uptime
        echo
    } >> "$LOG_FILE"
    sleep "$INTERVAL"
done
