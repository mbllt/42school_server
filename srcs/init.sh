#NGINX
mv ./default /etc/nginx/sites-available/
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled
#service nginx start

#My SQL
service mysql start

#CERTIFICAT SSL
mkdir -p /etc/nginx/ssl && chown -R $USER:$USER /etc/nginx/ssl && chmod -R 755 /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-out /etc/nginx/ssl/nginx-selfsigned.crt \
	-keyout /etc/nginx/ssl/nginx-selfsigned.key \
	-subj "/C=FR/ST=France/L=Lyon/O=inurass/OU=42lyon/CN=localhost"

#PHPMYADMIN
#mkdir -p /var/www/localhost && chown -R $USER:$USER /var/www/localhost && chmod -R 755 /var/www/localhost
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.tar.gz
tar -zxvf phpMyAdmin-5.1.0-all-languages.tar.gz
mv phpMyAdmin-5.1.0-all-languages /var/www/html/phpmyadmin
mv ./config.inc.php /var/www/html/phpmyadmin/
chmod 660 /var/www/html/phpmyadmin/config.inc.php
chown -R www-data:www-data /var/www/html/phpmyadmin/
service php7.3-fpm start
mysql < /var/www/html/phpmyadmin/sql/create_tables.sql -u root
echo "GRANT ALL ON *.* TO 'mia'@'localhost' IDENTIFIED BY '123';" | mysql -u root
echo "FLUSH PRIVILEGES;"| mysql -u root

#WORDPRESS
#echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
#echo "GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'password';" | mysql -u root
#echo "FLUSH PRIVILEGES;" | mysql -u root
#wget https://wordpress.org/latest.tar.gz
#tar -zxvf latest.tar.gz
