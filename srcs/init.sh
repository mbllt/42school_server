#!/bin/bash

#NGINX
mv default /etc/nginx/sites-available/
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled

#My SQL
service mysql start
mysql -u root -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -u root -e "GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'password';"
mysql -u root -e "FLUSH PRIVILEGES;"

#CERTIFICAT SSL
mkdir -p /etc/nginx/ssl && chown -R $USER:$USER /etc/nginx/ssl && chmod -R 755 /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-out /etc/nginx/ssl/nginx-selfsigned.crt \
	-keyout /etc/nginx/ssl/nginx-selfsigned.key \
	-subj "/C=FR/ST=France/L=Lyon/O=inurass/OU=42lyon/CN=localhost"

#PHPMYADMIN
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.tar.gz
tar -zxvf phpMyAdmin-5.1.0-all-languages.tar.gz
mv phpMyAdmin-5.1.0-all-languages /var/www/html/phpmyadmin
mv ./config.inc.php /var/www/html/phpmyadmin/
chmod 660 /var/www/html/phpmyadmin/config.inc.php
chown -R www-data:www-data /var/www/html/phpmyadmin/
ln -s /var/www/html/phpmyadmin /usr/share/phpmyadmin
#service php7.3-fpm start
#mysql -u root < /var/www/html/phpmyadmin/sql/create_tables.sql
mysql -u root -e "CREATE USER 'mia'@'localhost' IDENTIFIED BY '123';"
mysql -u root -e "GRANT ALL ON phpmyadmin.* TO 'mia'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

#WORDPRESS
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
mv ./wp-config.php /wordpress
mv /wordpress /var/www/html
