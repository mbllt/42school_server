FROM debian:buster

ENV PORT 80

#start
RUN apt-get update -y && apt-get install -y \
	nginx \
	openssl \
	php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline \
	mariadb-server mariadb-client

#ssl config


#php config
RUN service php7.3-fpm start

#mariadb config
RUN service mysql start

#end
RUN service nginx start

CMD /bin/bash
