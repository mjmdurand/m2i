#!/usr/bin/env bash

#Creating new database
echo -e "\e[1;34m Create database for $NomSite.\e[0m"
read -p "Database name : " dbname
read -p "Database user : " user
echo -e "\e[1;41mPlease do not use the same password for UNIX user and SQL user\e[0m"
read -s -p "Nextcloud database user password : " dbpasswd

sudo mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${dbname} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;"
echo -e "\e[1;32m${dbname} database created.\e[0m"

sudo mysql -u root -e "CREATE USER IF NOT EXISTS "${dbuser}"@"localhost";"
echo -e "\e[1;32m${dbuser} user created.\e[0m"

sudo mysql -u root -e "SET password FOR "${dbuser}"@"localhost" = password('${dbpasswd}');"
echo -e "\e[1;32mPassword set.\e[0m"

sudo mysql -u root -e "GRANT ALL PRIVILEGES ON ${dbname}.* TO "${dbuser}"@"localhost" IDENTIFIED BY '${dbpasswd}';"
echo -e "\e[1;32mPermissions set.\e[0m"

sudo mysql -u root -e "FLUSH PRIVILEGES;" 

echo -e "\e[1;32m Database for $NomSite created.\e[0m"