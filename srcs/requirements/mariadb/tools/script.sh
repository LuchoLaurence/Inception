#!/bin/sh

# #init database
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# #start mysql server in background
 #mysqld_safe --user=root --datadir=/var/lib/mysql &


#mysql_install_db --user=mysql --datadir=/var/lib/mysql

chown -R mysql:mysql /var/lib/mysql

/usr/bin/mysqld_safe --datadir=/var/lib/mysql &


#wait for mysql server to start
until /usr/bin/mysqladmin ping >/dev/null 2>&1; do
	sleep 1
done
echo "HELLO"
#create table
mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
#create user 
mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
#grant user
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
#change root password
#dmysql -e "UPDATE mysql.user SET Password=PASSWORD('$SQL_ROOT_PASSWORD');"
#refresh
mysql -e "FLUSH PRIVILEGES;"

/usr/bin/mysqladmin shutdown

/usr/bin/mysqld_safe --datadir=/var/lib/mysql
