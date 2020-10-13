service php7.3-fpm start
service nginx start
service mysql start

tail -f /var/log/nginx/access.log /var/log/nginx/error.log