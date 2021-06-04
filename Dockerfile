FROM debian:buster

ENV PORT 80

#start
RUN apt-get update -y && apt-get install -y \
	nginx \
	openssl \
	vim #
#	php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli \
#	php7.3-common php7.3-json php7.3-opcache php7.3-readline
	#fariadb-server mariadb-client \

#ssl config
RUN mkdir -p /etc/ssl && rm /etc/nginx/sites-available/default \
	&& rm /etc/nginx/sites-enabled/default \
	&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/nginx-selfsigned.key \
	-out /etc/ssl/nginx-selfsigned.c \
	-subj "/C=FR/ST=France/L=Paris/O=inurass/OU=42paris/CN=hga"
RUN echo "ssl_certificate /etc/ssl/nginx-selfsigned.crt;" \
	>> /etc/nginx/snippets/self-signed.conf \
	&& echo "ssl_certificate_key /etc/ssl/nginx-selfsigned.key;" \
	>> /etc/nginx/snippets/self-signed.conf
COPY /srcs/default /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
COPY /srcs/default-ssl /etc/nginx/sites-available/

#php config
#RUN service php7.3-fpm start
#COPY /srcs/index.php /var/www/html

#mariadb config
#RUN service mysql start

CMD service nginx start

ENTRYPOINT /bin/bash
