FROM debian:buster

COPY srcs/run.sh ./root/

RUN apt-get update
RUN apt-get upgrade -y 
RUN apt-get install -q -y nginx
RUN apt-get -y install wget
RUN apt-get -y install default-mysql-server
RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring php-zip php-gd

COPY srcs/localhost.conf /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default 

RUN openssl req -x509 -nodes -days 1024 -newkey rsa:2048 -keyout /etc/ssl/private/localhost.key -out /etc/ssl/private/localhost.crt -subj "/C=FR/ST=IDF/L=Paris/O=Ecole42/OU=Stud/CN=localhost"

COPY srcs/phpMyAdmin-5.0.2-all-languages.tar.gz ./root/
RUN mkdir /var/www/html/phpmyadmin
RUN tar -xzvf root/phpMyAdmin-5.0.2-all-languages.tar.gz --strip-components 1 -C /var/www/html/phpmyadmin && rm -rf phpMyAdmin-5.0.2-all-languages.tar.gz
COPY srcs/config.inc.php /var/www/html/phpmyadmin

COPY srcs/wordpress-5.4.tar.gz ./root/
RUN tar xf root/wordpress-5.4.tar.gz --strip-components 1 -C /var/www/html/ && rm -rf wordpress-5.4.tar.gz
COPY /srcs/wp-config.php /var/www/html/

RUN	service mysql start \
	&& echo "GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'password' WITH GRANT OPTION;" | mysql -u root \
	&& echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root \
	&& echo "GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';" | mysql -u root \
	&& echo "FLUSH PRIVILEGES;" | mysql -u root

RUN chmod 755 -R /var/www/html/
RUN chmod 660 /var/www/html/phpmyadmin/config.inc.php
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80 443

CMD bash root/run.sh
