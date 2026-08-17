#!/bin/sh
set -e

DB_USER_PASS=$(cat /run/secrets/DB_USER_PASS)

if [ ! -f "/var/lib/mysql/.init" ]; then
    echo "init the database :)"
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    mariadbd --user=mysql &
    pid="$!"

    until mariadb-admin ping --silent ; do
        sleep 1
    done


    mariadb -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
    mariadb -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}';"
    mariadb -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"
    mariadb -e "FLUSH PRIVILEGES;"

    mariadb-admin shutdown
    wait "$pid"

    touch /var/lib/mysql/.init
fi

echo "runing mariadb container :)"
exec mariadbd --user=mysql --bind-address=0.0.0.0
