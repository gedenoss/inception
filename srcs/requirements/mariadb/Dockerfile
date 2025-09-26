FROM debian:bullseye


RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server netcat


COPY ./tools/mdb-conf.sh /mdb-conf.sh
RUN chmod +x /mdb-conf.sh


RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld


EXPOSE 3306


ENTRYPOINT ["./mdb-conf.sh"]
