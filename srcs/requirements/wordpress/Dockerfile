FROM debian:bullseye

# Mise à jour et installation des paquets
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

# Copier le script de configuration
COPY ./tools/wp_conf.sh /wp_conf.sh
RUN chmod +x /wp_conf.sh

# Créer les dossiers nécessaires
RUN mkdir -p /var/www/wordpress
RUN mkdir -p /run/php

# Exposer le port 9000 pour PHP-FPM
EXPOSE 9000

# Lancer le script de configuration
ENTRYPOINT ["./wp_conf.sh"]
