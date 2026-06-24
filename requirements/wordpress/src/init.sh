#!/bin/sh

set -e

sleep 15

# rm /etc/php84/php-fpm.d/www.conf

mkdir -p /var/www/html
cd /var/www/html

# wp-config.php
if [ ! -f "wp-config.php" ]; then
    echo "WordPress not found. Starting installation..."
    # php -d memory_limit=512M  /usr/local/bin/wp core download

    wp config create \
    --dbname=wordpress \
    --dbuser=wpuser \
    --dbpass=pass \
    --dbhost=maria:3306

    wp core install \
    --url=massrayb.42.fr \
    --title="prismo" \
    --admin_user=admin \
    --admin_password=pass \
    --admin_email=iman@iman.com

fi

find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

chmod -R 777 /var/www/html/wp-content

echo "php-fpm84. Starting..."
exec php-fpm84 -F