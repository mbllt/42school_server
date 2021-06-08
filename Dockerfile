FROM debian:buster

RUN apt-get update -y && apt-get install -y \
	nginx \
	wget \
	openssl \
	php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli \
	php7.3-common php7.3-json php7.3-opcache php7.3-readline \
	php-json php-mbstring \
	mariadb-server mariadb-client

COPY srcs/default /etc/nginx/sites-available/
COPY srcs/config.inc.php /usr/share/phpmyadmin
COPY srcs/init.sh ./
RUN bash init.sh

EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]