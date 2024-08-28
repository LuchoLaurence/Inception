#!/bin/sh

#init database
mysql_install_db --user=mysql --datadir=/var/lib/mysql

chown -R mysql:mysql /var/lib/mysql

#start mysql server in background
/usr/bin/mysqld_safe --datadir=/var/lib/mysql &

#wait for mysql server to start
until /usr/bin/mysqladmin ping >/dev/null 2>&1; do
	sleep 1
done
#create table
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
#create user 
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
#grant user
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
#Apply changes
mysql -u root -e "FLUSH PRIVILEGES;"

#reboot mysql server without background
/usr/bin/mysqladmin shutdown
/usr/bin/mysqld_safe --datadir=/var/lib/mysql
