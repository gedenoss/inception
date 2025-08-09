FROM debian:bullseye

# Mise à jour et installation de MariaDB
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server netcat

# Copier le script de configuration
COPY ./tools/mdb-conf.sh /mdb-conf.sh
RUN chmod +x /mdb-conf.sh

# Créer les dossiers nécessaires
RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld

# Exposer le port 3306
EXPOSE 3306

# Lancer le script de configuration
ENTRYPOINT ["./mdb-conf.sh"]
