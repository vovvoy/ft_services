FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add nginx openssl openrc supervisor openssh bash

COPY ./srcs/default /etc/nginx/conf.d/default.conf
RUN mkdir -p /run/nginx
RUN openssl req -x509 -nodes -days 365 -subj "/C=RU/ST=Moscow/L=Moscow/O=Unknown/OU=Unknown/CN=ljerrica" \
    -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt;

COPY ./srcs/init.sh /tmp/
RUN chmod +x /tmp/init.sh
EXPOSE 80 443
#CMD ["/tmp/init.sh"]
