#!/bin/bash
newnextclouddbname='glpi'
newnextclouddbuser='glpi'
newnextclouddbpasswd='azerty@1'
sudo apt update
apt install -y mariadb-server software-properties-common apt-transport-https apache2 php php-curl php-fileinfo php-gd php-json php-mbstring php-mysqli php-simplexml php-xml php-intl php-cli php-ldap php-xmlrpc php-zip php-bz2
sed -i 's/session.cookie_httponly =/session.cookie_httponly=On/g' /etc/php/8.1/apache2/php.ini
systemctl restart apache2
sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${newnextclouddbname} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
mysql -u root -e "CREATE USER IF NOT EXISTS '${newnextclouddbuser}'@'%';"
mysql -u root -e "SET password FOR '${newnextclouddbuser}'@'%' = password('${newnextclouddbpasswd}');"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${newnextclouddbname}.* TO '${newnextclouddbuser}'@'%' IDENTIFIED BY '${newnextclouddbpasswd}';"
mysql -u root -e "FLUSH PRIVILEGES;"
wget -O /tmp/glpi.tgz https://github.com/glpi-project/glpi/releases/download/10.0.3/glpi-10.0.3.tgz
rm -rf /var/www/html/*
tar -zxvf  /tmp/glpi.tgz -C /var/www/html/ --strip-components 1
chown -R www-data:www-data /var/www/html/