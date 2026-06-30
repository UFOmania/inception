FROM alpine:3.23.4

RUN apk update && apk add --no-cache mariadb mariadb-client netcat-openbsd

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./tools/init.sh ./src/init.sh

CMD [ "sh", "/src/init.sh" ]
