#!/bin/sh
Entorno=$(/root/.local/bin/aws ssm get-parameters --names $(echo $TYPE).Entorno --no-with-decryption --region eu-west-1 --query "Parameters[*].{Name:Value}" --output text) && echo $Entorno > '/var/www/html/info.php' && service httpd start && ping localhost;
