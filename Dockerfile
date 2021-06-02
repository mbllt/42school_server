FROM debian:buster

ENV PORT 80

#start
RUN apt-get update -y && apt-get install -y \
	nginx \
	openssl \
	php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline \
	fariadb-server mariadb-client \
	vim

#ssl config
RUN  mkdir -p /etc/nginx/ssl/ \
	&& openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost.key -subj "/C=FR/ST=Lyon/L=Lyon/O=42 School/OU=mia/CN=localhost"

#php config
RUN service php7.3-fpm start
COPY /srcs/index.php /var/www/html

#mariadb config
RUN service mysql start

#end
ENTRYPOINT /bin/bash

CMD service nginx start
