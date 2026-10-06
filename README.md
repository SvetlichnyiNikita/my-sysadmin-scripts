# my-sysadmin-scripts

script.sh раз в 5 секунд записывает в monitor.log состояние сервера (free -h, df -h, uptime) с отметкой времени.

Запуск: `./script.sh`, остановка: Ctrl+C. Пример лога лежит в sample_output.txt.

## Docker

Сборка и запуск:

    docker build -t my-script .
    docker run -d -p 8080:8080 --name my-app my-script

Лог отдаётся по http://localhost:8080/monitor.log. Снаружи контейнер закрыт nginx с https, конфиги nginx и systemd лежат в deploy/.
