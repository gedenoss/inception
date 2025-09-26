FROM debian:bullseye


RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    curl \
    php \
    php7.4-fpm \
    php-mysql \
    php-curl \
    php-gd \
    php-intl \
    php-mbstring \
    php-soap \
    php-xml \
    php-xmlrpc \
    php-zip \
    mariadb-client \
    netcat

COPY ./tools/wp_conf.sh /wp_conf.sh
RUN chmod +x /wp_conf.sh

RUN mkdir -p /var/www/wordpress
RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["./wp_conf.sh"]
