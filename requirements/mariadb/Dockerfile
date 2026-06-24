FROM alpine:3.23.4

RUN apk update && apk add mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./tools/init_mariadb.sh ./init_mariadb.sh

CMD ["sh", "/init_mariadb.sh"]