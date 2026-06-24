#!/bin/sh

set -e

# Init database only once
if [ ! -d "/var/lib/mysql/mysql" ]; then
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Config
sed -i 's/^skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf
sed -i '/\[mysqld\]/a bind-address = 0.0.0.0' /etc/my.cnf.d/mariadb-server.cnf

# Start MariaDB in background
mariadbd --user=mysql --datadir=/var/lib/mysql &

# Wait for DB
until mariadb-admin ping --silent; do
    sleep 1
done

# Init SQL (IMPORTANT: use root socket auth)
mariadb -u root << EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;
EOF

# Stop background DB cleanly
mariadb-admin shutdown

# Final foreground process (PID 1)
exec mariadbd --user=mysql --bind-address=0.0.0.0