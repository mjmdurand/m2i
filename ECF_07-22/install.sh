#!/usr/bin/env bash

HOME_DIR=/home/$SUDO_USER/m2i/ECF_07-22/
IPCONF=$HOME_DIR/27072022.txt
PHPINI=/etc/php/7.4/cli/php.ini

echo -e "\n\e[1;44mVerifications.\e[0m"
#Checking if script is launched with sudo/root
if [  "$USER" != "root" ]
then
echo -e "\e[1;31mCe script doit être executé en tant que root/sudo, arrêt du script.\e[0m"
exit
fi

#moving to user's directory
cd ${HOME_DIR}

if [ ! -f "$IPCONF" ]; then

#Static IPv4
read -p "Type STATIC IPv4 with CIDR (xx.xx.xx.xx/yy): " staticip
read -p "Type GATEWAY ip : " gateway
read -p "Type Primary DNS ip   : " dnsservers1
read -p "Type Primary DNS ip   : " dnsservers2
sed -i 's/dhcp/static/g' /etc/network/interfaces
echo "address ${staticip}
gateway ${gateway}
dns-nameservers ${dnsservers}" >> /etc/network/interfaces

rm -r /etc/resolv.conf
echo "nameserver ${dnsservers1}
nameserver ${dnsservers2}" > /etc/resolv.conf

touch $IPCONF
echo "System is gonna reboot to apply new network configuration"
sleep 5
reboot
fi

#Asking for domain
read -p "saisir le domaine, le sous domaine sera crée automatiquement : " domain


# update system 
echo -e "\e[1;34mUpdating the system.\e[0m"
apt update -q && apt upgrade -y -q
echo -e "\e[1;32mSystem updated.\e[0m"
echo ""

# install apache2, php, mariaDB
echo -e "\e[1;34mInstalling web server.\e[0m"
apt-get -y -q install git apache2 php php-curl php-fileinfo php-gd php-json php-mbstring php-mysqli php-simplexml php-xml php-intl php-cli php-xmlrpc php-ldap php-zip php-bz2 mariadb-server
echo -e "\e[1;32mInstallation done.\e[0m"
echo ""

#Php.ini adjustements for GLPI
sed -i 's/memory_limit = -1/memory_limit = 64M/g' $PHPINI
sed -i 's/max_execution_time = 30/max_execution_time = 600/g' $PHPINI
systemctl restart apache2

#Mysql_secure_install
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param

#Create www-data home directory if not exists
if [ ! -d /home/www-data/ ]
then
    mkdir /home/www-data/
fi

#Install Wordpress
NomSite=infra.$domain
wget https://fr.wordpress.org/latest-fr_FR.tar.gz
tar -xf latest-fr_FR.tar.gz
rm latest-fr_FR.tar.gz
mv wordpress /home/www-data/$NomSite
source ${HOME_DIR}/apache2-VHost.sh
source ${HOME_DIR}/DB-creation.sh


#Install GLPI
NomSite=glpi.$domain
wget https://github.com/glpi-project/glpi/releases/download/10.0.2/glpi-10.0.2.tgz
tar -xf glpi-10.0.2.tgz
rm glpi-10.0.2.tgz
mv glpi /home/www-data/$NomSite
source ${HOME_DIR}/apache2-VHost.sh
source ${HOME_DIR}/DB-creation.sh

chown -R www-data:www-data /home/www-data/
