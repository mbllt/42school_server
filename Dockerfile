FROM debian:buster

ENV PORT 80

RUN apt-get update -y && apt-get install -y \
	nginx \
	openssl \
	php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli \
	php7.3-common php7.3-json php7.3-opcache php7.3-readline
	#fariadb-server mariadb-client

COPY /srcs/init.sh ./

#php config
#RUN service php7.3-fpm start
#COPY /srcs/index.php /var/www/html

#mariadb config

CMD ["nginx", "-g", "daemon off;"]

#CMD ["service", "nginx", "start"]