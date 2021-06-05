#!/bin/bash
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

#CERTIFICAT SSL
mkdir -p /etc/nginx/ssl && chown -R $USER:$USER /etc/nginx/ssl && chmod -R 755 /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=emma/CN=localhost"
