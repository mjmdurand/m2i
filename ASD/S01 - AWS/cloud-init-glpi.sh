#!/bin/bash
sudo apt update
apt install -y software-properties-common apt-transport-https apache2 php php-curl php-fileinfo php-gd php-json php-mbstring php-mysqli php-simplexml php-xml php-intl php-cli php-ldap php-xmlrpc php-zip php-bz2
sed -i 's/session.cookie_httponly =/session.cookie_httponly=On/g' /etc/php/8.1/apache2/php.ini
systemctl restart apache2
wget -O /tmp/glpi.tgz https://github.com/glpi-project/glpi/releases/download/10.0.3/glpi-10.0.3.tgz
rm -rf /var/www/html/*
tar -zxvf  /tmp/glpi.tgz -C /var/www/html/ --strip-components 1
chown -R www-data:www-data /var/www/html/


#cloud-config
package_update: true
package_upgrade: true
runcmd:
- yum install -y amazon-efs-utils
- apt-get -y install amazon-efs-utils
- yum install -y nfs-utils
- apt-get -y install nfs-common
- file_system_id_1=fs-0ac3ebef6405d682b
- efs_mount_point_1=/var/www/html
- mkdir -p "${efs_mount_point_1}"
- test -f "/sbin/mount.efs" && printf "\n${file_system_id_1}:/ ${efs_mount_point_1} efs tls,_netdev\n" >> /etc/fstab || printf "\n${file_system_id_1}.efs.us-east-1.amazonaws.com:/ ${efs_mount_point_1} nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport,_netdev 0 0\n" >> /etc/fstab
- test -f "/sbin/mount.efs" && grep -ozP 'client-info]\nsource' '/etc/amazon/efs/efs-utils.conf'; if [[ $? == 1 ]]; then printf "\n[client-info]\nsource=liw\n" >> /etc/amazon/efs/efs-utils.conf; fi;
- retryCnt=15; waitTime=30; while true; do mount -a -t efs,nfs4 defaults; if [ $? = 0 ] || [ $retryCnt -lt 1 ]; then echo File system mounted successfully; break; fi; echo File system not available, retrying to mount.; ((retryCnt--)); sleep $waitTime; done;
- apt install -y software-properties-common apt-transport-https apache2 php php-curl php-fileinfo php-gd php-json php-mbstring php-mysqli php-simplexml php-xml php-intl php-cli php-ldap php-xmlrpc php-zip php-bz2
- sed -i 's/session.cookie_httponly =/session.cookie_httponly=On/g' /etc/php/8.1/apache2/php.ini
- systemctl restart apache2
- wget -O /tmp/glpi.tgz https://github.com/glpi-project/glpi/releases/download/10.0.3/glpi-10.0.3.tgz
- rm -rf /var/www/html/*
- tar -zxvf  /tmp/glpi.tgz -C /var/www/html/ --strip-components 1
- chown -R www-data:www-data /var/www/html
