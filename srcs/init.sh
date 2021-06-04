cp /srcs/default /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

mkdir -p /etc/ssl && chown -R $USER:$USER /etc/ssl && chmod -R 755 /etc/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem \
	-keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Lyon/L=Lyon/O=42 School/OU=mia/CN=localhost"
