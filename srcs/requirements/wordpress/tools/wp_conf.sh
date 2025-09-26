#!/bin/bash


echo "Attente de MariaDB..."
while ! nc -z mariadb 3306; do
    sleep 1
done
echo "MariaDB est prêt !"


if [ ! -f /usr/local/bin/wp ]; then
    echo "Installation de WP-CLI..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

s
cd /var/www/wordpress


chmod -R 755 /var/www/wordpress/
chown -R www-data:www-data /var/www/wordpress


if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Téléchargement de WordPress..."
    wp core download --allow-root

    echo "Configuration de WordPress..."
    wp core config \
        --dbhost=mariadb:3306 \
        --dbname="$MYSQL_DB" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --allow-root

    echo "Installation de WordPress..."
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_N" \
        --admin_password="$WP_ADMIN_P" \
        --admin_email="$WP_ADMIN_E" \
        --allow-root

    echo "Création d'un utilisateur supplémentaire..."
    wp user create "$WP_U_NAME" "$WP_U_EMAIL" \
        --user_pass="$WP_U_PASS" \
        --role="$WP_U_ROLE" \
        --allow-root
fi


sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/;listen.owner = www-data/listen.owner = www-data/' /etc/php/7.4/fpm/pool.d/www.conf
sed -i 's/;listen.group = www-data/listen.group = www-data/' /etc/php/7.4/fpm/pool.d/www.conf

echo "Démarrage de PHP-FPM..."
exec /usr/sbin/php-fpm7.4 -F
