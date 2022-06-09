#!/usr/bin/env bash
read -p "saisir le nom du site à créer : " NomSite

Emplacement="/etc/apache2/sites-available/$NomSite.conf" 


echo "<VirtualHost *:80>" >> $Emplacement
echo "ServerName $NomSite" >> $Emplacement
echo "DocumentRoot \"/home/www-data/$NomSite\"" >> $Emplacement
echo "<Directory />" >> $Emplacement
echo "Options Indexes FollowSymLinks" >> $Emplacement 
echo "AllowOverride All" >> $Emplacement
echo "Require all granted" >> $Emplacement
echo "</Directory>" >> $Emplacement
echo "</VirtualHost>" >> $Emplacement
