FROM ubuntu:12.04

#Argumentos & ENV
#ARG Entorno
#ENV Entorno=$Entorno

# Install dependencies
RUN apt-get update -y
RUN apt-get install -y git curl apache2 php5 libapache2-mod-php5 php5-mcrypt php5-mysql

#Install AWS CLI
RUN apt-get install -y \
    python \
    python-pip \
    python-virtualenv
    
RUN adduser --disabled-login --gecos '' aws
WORKDIR /home/aws

USER aws

RUN \
    mkdir aws && \
    virtualenv aws/env && \
    ./aws/env/bin/pip install awscli && \
    echo 'source $HOME/aws/env/bin/activate' >> .bashrc && \
    echo 'complete -C aws_completer aws' >> .bashrc

# Install app
RUN rm -rf /var/www/*
ADD src /var/www
COPY src/entrypoint.sh /usr/local/bin/
RUN chmod 777 /var/www/entrypoint.sh
RUN chmod 777 /usr/local/bin/entrypoint.sh

#Info Page
#RUN echo $Entorno > /var/www/info.php

# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
