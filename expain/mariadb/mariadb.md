# what is mariadb ?
maraidb is an aql relational database.

# why maraidb ?
wordpress needs an sql database to store users, posts, ...

# you can connect with mariadb at container_ip:3306

# 1- initialize mariadb.
```ini
maraidb-install-db --user=mysql --datadir=/var/lib/mysql
```

'mysql' is the user who owns mariadb files, so mariadb will have limited permissions.
'/var/lib/mysql' is where mariadb will be located.

# 2- run mariadb server in the background
```ini
maraidbd --user=mysql &
```

it's 'mariadbd' not 'mariadb' 
'&' is a shell argument that run a process in the backgound

# 3- wait for the server to start
```ini
    until mariadb-admin ping --silent ; do
        sleep 1
    done
```

mariadb-admin ping: checks if maraidbd is listening and can be accessed
silent: makes it print nothing

# 4- create the database and a user
```ini
mariadb -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME} ; "
mariadb -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}' ;"
mariadb -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* to '${DB_USER}'@'%' ;"
mariadb -e "FLUSH PRIVILEGES ;"
```

database: to store wordpress data
user: we make a user and grant it all privilegs of that database, bcs now we only have the root, and we cant access mariadb from outside with the root, and it's not properly secured to access with root directly


# 5- shutdown the background mariadbd
```sh
maraidb-admin shurdown
```

# 6- disable skip-networking

skip-networking by default is enabled, it blocks mariadb from listening to tcp networks
and only uses unix socket for comunication
so we can't access maraidb from outside like:
```sh
    maraidb -u myuser -p'pass' -h mariadb
```

this is to disable it
```sh
    sed -i "s/^skip-networking/#skip-networking/" /etc/my.cnf.d/mariadb-server.cnf
```


# 7- final start of maraidbd

```sh
exec mariadbd --user=mysql --bind-address=0.0.0.0
```

exec replace pid 1 which is the init.sh script to maraidbd, so when the script exits the container wont.
bind-address: 0.0.0.0 makes mariadb server listen to all connections, by default its 127.0.0.1 only localhost.


