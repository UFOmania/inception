FROM alpine:3.23.4

RUN apk update && apk add --no-cache  php84-fpm php84 php84-phar php84-curl php84-mysqli php84-mbstring curl

COPY ./tools/init.sh ./init.sh

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp


CMD ["sh", "init.sh"]