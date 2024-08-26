#!/bin/sh

# Attendre que la base de données MariaDB soit prête
while ! mariadb -h $DB_HOST -u $DB_USER -p$DB_PASSWORD -e "show databases;"; do
    echo "Waiting for database connection..."
    sleep 1
done

# Configurer wp-config.php avec les variables d'environnement

# cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
# sed -i "s/database_name_here/$DB_NAME/" /var/www/html/wp-config.php
# sed -i "s/username_here/$DB_USER/" /var/www/html/wp-config.php
# sed -i "s/password_here/$DB_PASSWORD/" /var/www/html/wp-config.php
# sed -i "s/localhost/$DB_NAME/" /var/www/html/wp-config.php

if [ ! -f "$WP_PATH/wp-config.php" ]; then
    wp core download --path=$WP_PATH --allow-root

    chown -R www-data:www-data /var/www/html
    find /var/www/html -type d -exec chmod 755 {} \;
    find /var/www/html -type f -exec chmod 644 {} \;

    cd /var/www/html

    wp config create --path=$WP_PATH --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --dbprefix="br_" --allow-root
    wp core install --path=$WP_PATH --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_USERADMIN --admin_password=$WP_PASSWORDADMIN --admin_email=$WP_EMAILADMIN --allow-root
    wp user create --path=$WP_PATH $WP_USERDUMMY $WP_EMAILDUMMY --role=editor --user_pass=$WP_PASSWORDDUMMY --allow-root

    chown -R www-data:www-data /var/www/html
    find /var/www/html -type d -exec chmod 755 {} \;
    find /var/www/html -type f -exec chmod 644 {} \;

fi

# Fixer les permissions pour WordPress
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Lancer php-fpm
php-fpm8.1 -F -R

