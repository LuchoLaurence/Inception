# Utiliser l'image de base Debian ou Alpine
FROM debian:bullseye

# Mettre à jour le système et installer les dépendances
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget curl mariadb-client unzip
RUN apt-get install -y lsb-release apt-transport-https ca-certificates
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get install -y php8.1
RUN apt-get install -y php8.1-fpm 
RUN apt-get install -y php8.1-mysqli 
RUN apt-get install -y php8.1-iconv 
RUN apt-get install -y php8.1-phar
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
# Créer le répertoire où WordPress sera installé
RUN mkdir -p /var/www/html && mkdir -p /run/php
RUN chmod -R 755 /var/www/html
# Copier le script d'initialisation
COPY tools/script.sh /tmp/script.sh
COPY ./conf/www.conf /etc/php/8.1/fpm/pool.d/www.conf
# Donner les permissions nécessaires au script
RUN chmod +x /tmp/script.sh
EXPOSE 9000
# Exécuter le script d'initialisation
CMD ["/tmp/script.sh"]