FROM debian:buster

RUN apt-get update -y && apt-get install -y \
	nginx \
	vim \
	openssl \
	php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli \
	php7.3-common php7.3-json php7.3-opcache php7.3-readline
	#fariadb-server mariadb-client

COPY srcs/default /etc/nginx/sites-available/

COPY srcs/init.sh ./
RUN bash init.sh

EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]