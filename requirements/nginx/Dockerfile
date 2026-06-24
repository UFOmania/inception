FROM alpine:3.23.4

RUN  apk update &&  apk add nginx openssl

COPY ./tools/nginx_init.sh .

COPY ./src/nginx_config.conf ./etc/nginx/http.d/myConf.conf 

RUN mkdir -p /etc/nginx/ssl/

CMD ["sh", "./nginx_init.sh"]
