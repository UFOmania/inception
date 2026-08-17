#!/bin/sh


echo load secrets ...
DB_PASS=$(cat /run/secrets/DB_USER_PASS)
WP_ADMIN_PASS=$(cat /run/secrets/WP_ADMIN_PASS)
WP_USER_PASS=$(cat /run/secrets/WP_USER_PASS)


if [ ! -f "./.init" ] ; then
    echo init wordpress with database ...
    
    wp config create \
        --dbname=${WP_DB_NAME} \
        --dbuser=${DB_USER} \
        --dbpass=${DB_PASS} \
        --dbhost=${DB_HOST}:${DB_PORT}


    wp core install \
    --url=${WP_URL} \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASS} \
    --admin_email=${WP_ADMIN_EMAIL}

    wp user create ${WP_USER_NAME} ${WP_USER_MAIL} --role=author --user_pass=${WP_USER_PASS}

    touch ./.init
fi

echo wordpress started OK ...
exec php-fpm84 -F