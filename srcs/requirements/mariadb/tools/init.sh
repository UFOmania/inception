#!/bin/sh

set -e

DB_USER_PASS=$(cat /run/secrets/DB_USER_PASS)

if [ ! -d "/var/lib/mysql/.init" ] ; then 
    
    echo "init the databse"
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    mariadbd --user=mysql &

    until mariadb-admin ping --silent ; do
        sleep 1
    done

    mariadb -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME} ; "
    mariadb -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}' ;"
    mariadb -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* to '${DB_USER}'@'%' ;"
    mariadb -e "FLUSH PRIVILEGES ;"

    mariadb-admin shutdown

    sed -i "s/^skip-networking/#skip-networking/" /etc/my.cnf.d/mariadb-server.cnf

    touch /var/lib/mysql/.init
fi

exec mariadbd --user=mysql --bind-address=0.0.0.0
