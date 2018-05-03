#!/bin/sh
Entorno=$(/usr/bin/aws ssm get-parameters --names $(echo $TYPE).Entorno --no-with-decryption --region eu-west-1 --query "Parameters[*].{Name:Value}" --output text)
echo $Entorno > /var/www/info.php
#/usr/sbin/apache2 -DFOREGROUND
exec "$@";
