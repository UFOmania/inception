FROM alpine:3.23.4

RUN apk update && apk add php84-fpm php84 php84-mysqli php84-curl php84-mbstring php84-xml php84-phar curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp



COPY ./src/wordpress/* ./var/www/html/

COPY ./src/wordpress.conf ./etc/php84/php-fpm.d/www.conf
COPY ./src/init.sh ./init.sh


RUN chmod +x ./init.sh

ENTRYPOINT ["./init.sh"]

