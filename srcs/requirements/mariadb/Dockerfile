FROM alpine:3.23.4

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN sed -i "s/^skip-networking/#skip-networking/" /etc/my.cnf.d/mariadb-server.cnf

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./tools/init.sh ./src/init.sh

CMD [ "sh", "/src/init.sh" ]
