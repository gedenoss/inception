FROM debian:bullseye

# Mise à jour et installation des paquets
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nginx openssl

# Création du dossier SSL
RUN mkdir -p /etc/nginx/ssl

# Génération du certificat SSL auto-signé
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=tonlogin.42.fr/UID=tonlogin"

# Copier la configuration NGINX
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Créer le dossier WordPress
RUN mkdir -p /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

# Exposer le port 443
EXPOSE 443

# Démarrer NGINX en premier plan
CMD ["nginx", "-g", "daemon off;"]
