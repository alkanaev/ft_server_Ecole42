## Ft_server

The goal of this project is to create a HTTP web server with Nginx in only one docker container. The
container OS is Debian Buster.<br> 
The web server is able to run several services at the same time: WordPress website, phpMyAdmin and MariaDB (I prefet it to MySQL).<br>
The scripting language is PHP.

### to build
docker build -t name .
### to run
docker run -p 80:80 -p 443:443 -d name
