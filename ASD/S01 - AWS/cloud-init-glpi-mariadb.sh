#!/bin/bash
newnextclouddbname='glpi'
newnextclouddbuser='glpi'
newnextclouddbpasswd='azerty@1'
apt update
apt install -y mariadb-server
sed -i 's/bind-address            = 127.0.0.1/bind-address            = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${newnextclouddbname} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
mysql -u root -e "CREATE USER IF NOT EXISTS '${newnextclouddbuser}'@'%';"
mysql -u root -e "SET password FOR '${newnextclouddbuser}'@'%' = password('${newnextclouddbpasswd}');"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${newnextclouddbname}.* TO '${newnextclouddbuser}'@'%' IDENTIFIED BY '${newnextclouddbpasswd}';"
mysql -u root -e "FLUSH PRIVILEGES;"