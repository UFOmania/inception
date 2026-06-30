#!/bin/sh


echo load secrets ...
DB_PASS=$(cat /run/secrets/DB_USER_PASS)
WP_ADMIN_PASS=$(cat /run/secrets/WP_ADMIN_PASS)

echo "dbname=${WP_DB_NAME} 
dbuser=${DB_USER} 
dbpass=${DB_PASS} 
dbhost=${DB_HOST}:${DB_PORT}\n\n\n"

sed -i "s|listen\s*=\s*127.0.0.1:9000|listen = 0.0.0.0:9000|" /etc/php84/php-fpm.d/www.conf

if [ ! -d "/var/www/html/.init" ] ; then
    echo init wordpress with database ...

    mkdir -p /var/www/html && cd /var/www/html

    php -d memory_limit=512M  /usr/local/bin/wp core download
    
    echo "1111111"
    wp config create \
        --dbname=${WP_DB_NAME} \
        --dbuser=${DB_USER} \
        --dbpass=${DB_PASS} \
        --dbhost=${DB_HOST}:${DB_PORT}

    echo "22222222"
    wp core install \
    --url=${WP_URL} \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASS} \
    --admin_email=${WP_ADMIN_EMAIL}

    touch /var/www/html/.init
fi

echo wordpress started OK ...
exec php-fpm84 -F