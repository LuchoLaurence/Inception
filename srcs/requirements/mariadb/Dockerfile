FROM debian:bullseye 

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server
#copy the mariadb configuration file into the container;
COPY conf/mariadb.conf etc/mysql/mariadb.conf.d/50-server.cnf
#copy the script that will create the database and the user;
COPY tools/script.sh /tmp/script.sh

#give the script the right permissions;
RUN chmod +x /tmp/script.sh
#run the script that will create the database and the user;

EXPOSE 3306

CMD ["sh", "/tmp/script.sh"]
