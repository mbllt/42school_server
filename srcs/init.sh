#!/bin/bash
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

#CERTIFICAT SSL
mkdir -p /etc/nginx/ssl && chown -R $USER:$USER /etc/nginx/ssl && chmod -R 755 /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-out /etc/nginx/ssl/nginx-selfsigned.crt \
	-keyout /etc/nginx/ssl/nginx-selfsigned.key \
	-subj "/C=FR/ST=France/L=Lyon/O=inurass/OU=42lyon/CN=localhost"

#PHPMYADMIN
service php7.3-fpm start
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages /usr/share/phpMyAdmin

#My SQL
service mysql start
