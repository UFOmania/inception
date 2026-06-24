#!/bin/sh
set -e
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=MA/ST=KH/L=Khouribga/O=42/OU=42/CN=ybassour.42.fr/UID=ybassour"
exec nginx  -g "daemon off;"