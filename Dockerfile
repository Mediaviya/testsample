FROM ubuntu:12.04

#Argumentos & ENV
ARG Entorno
ENV Entorno=$Entorno

# Install dependencies
RUN apt-get update -y
RUN apt-get install -y git curl apache2 php5 libapache2-mod-php5 php5-mcrypt php5-mysql

#Info Page
RUN echo $Entorno > /var/www/index.php

# Install app
RUN rm -rf /var/www/*
ADD src /var/www

#Info Page
RUN echo $Entorno > /var/www/src/index.php

# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
