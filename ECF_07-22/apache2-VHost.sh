#!/usr/bin/env bash
echo -e "\e[1;34mCreating $NomSite apache2 config file\e[0m"

Emplacement="/etc/apache2/sites-available/$NomSite.conf" 


echo "<VirtualHost *:80>
ServerName $NomSite
DocumentRoot \"/home/www-data/$NomSite\"
<Directory />
Options Indexes FollowSymLinks
AllowOverride All
Require all granted
</Directory>
</VirtualHost>" >> $Emplacement
echo -e "\e[1;32m$NomSite apache2 config file created.\e[0m"

a2ensite $NomSite
systemctl reload apache2