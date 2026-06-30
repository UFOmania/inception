FROM alpine:3.23.4

RUN apk update && apk add --no-cache  nginx openssl

RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/key.pem -out /etc/nginx/cert.pem -sha256 -days 3650 -nodes -subj "/C=XX/ST=StateName/L=CityName/O=CompanyName/OU=CompanySectionName/CN=CommonNameOrHostname"

RUN sed -i '/http {/a \    include mime.types;' "/etc/nginx/nginx.conf"

COPY ./src/config.conf ./etc/nginx/http.d/config.conf

CMD ["nginx",  "-g", "daemon off;"]