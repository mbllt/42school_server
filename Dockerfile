FROM debian:buster

RUN apt-get update -y && apt-get install -y \
	nginx \
	wget \
	openssl \
	php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli \
	php7.3-common php7.3-json php7.3-opcache php7.3-readline \
	php-json php-mbstring \
	mariadb-server mariadb-client \
	php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip

COPY srcs/wp-config.php ./
COPY srcs/config.inc.php ./
COPY srcs/default ./
COPY srcs/launch.sh ./
COPY srcs/init.sh ./
RUN bash init.sh

CMD bash launch.sh
EXPOSE 80 443
#CMD ["nginx", "-g", "daemon off;"]
