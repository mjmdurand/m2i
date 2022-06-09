#!/usr/bin/env bash

##################################
## Executer ce script avec sudo ##
##################################

#Creation des groupes
echo -e "\e[1;41mCreation de 2 groupes.\e[0m"
read -p "Saisir le nom du premier groupe : " group1
read -p "Saisir le nom du second groupe : " group2
groupadd $group1
groupadd $group2
echo -e "\e[1;32mCreation terminee.\e[0m"

#Creation des utilisateurs + affectation des groupes.
echo -e "\e[1;41mCreation de 2 utilisateurs + affectation des groupes.\e[0m"
read -p "Saisir le nom du premier utilisateur : " user1
read -p "Saisir le nom du second utilisateur : " user2
groupadd $user1
groupadd $user2
useradd $user1 -m -g $user1 -G $group1 -s /bin/bash 
useradd $user2 -m -g $user2 -G $group2 -s /bin/bash 
echo -e "\e[1;32mCreation terminee.\e[0m"

#Actions sur le premier dossier.
echo -e "\e[1;41mActions sur le premier dossier.\e[0m"
read -p "Saisir le nom du premier dossier : " folder1
read -p "Saisir le nom du premier fichier : " file1
read -p "Saisir le nouveau nom du premier fichier : " rename1

cd "/home/$user1"
mkdir "$folder1"
cd "$folder1"
touch "$file1"
mv "$file1" "$rename1"
echo -e "\e[1;32mActions terminee.\e[0m"

#Actions sur le second dossier.
echo -e "\e[1;41mActions sur le second dossier.\e[0m"
read -p "Saisir le nom du second dossier : " folder2
read -p "Saisir le nom du premier fichier : " file2_1
read -p "Saisir le nom du second fichier : " file2_2

cd "/home/$user1"
mkdir "$folder2"
cd "$folder2"
echo "coucou" >> "$file2_1"
echo "bonjour" >> "$file2_2"
echo -e "\e[1;32mActions terminee.\e[0m"

#Changement de propriétaire des elements crées.
echo -e "\e[1;41mChangement de propriétaire des elements crées.\e[0m"
chown -R $user1:$user1 "/home/$user1/$folder1"
chown -R $user1:$user1 "/home/$user1/$folder2"

#Actions diverses.
echo -e "\e[1;41mActions diverses.\e[0m"
cd "/home/$user1/$folder1"
cd "/home/$user1/$folder2"

#Copie des fichiers
echo -e "\e[1;41mCopie des fichiers de $folder2 dans $folder1.\e[0m"
cp -r /home/$user1/$folder2/* /home/$user1/$folder1/

#Changement de propriétaire des elements copies.
echo -e "\e[1;41mChangement de propriétaire des elements copies.\e[0m"
chown -R $user1:$user1 "/home/$user1/$folder1"

cd "/home/$user1/$folder1"

#Affichage du contenu du fichier
echo -e "\e[1;41mcontenu du fichier $file2_2 dans $rename1\e[0m"
cat "/home/$user1/$folder1/$file2_2"

#Ecriture du contenu
echo -e "\e[1;41mEcriture du contenu de $file2_2 :\e[0m"
cat "/home/$user1/$folder1/$file2_2" >> "/home/$user1/$folder1/$rename1"

#Copie des fichiers
echo -e "\e[1;41mCopie du dossier $folder1 dans /home/$user2.\e[0m"
cp -r "/home/$user1/$folder1/" "/home/$user2/$folder1/"

#Changement de propriétaire des elements copies.
echo -e "\e[1;41mChangement de propriétaire des elements copies.\e[0m"
chown -R $user2:$user2 "/home/$user2/$folder1"

echo -e "\e[1;41mReglage des droits de $file2_1 (740, aucun droit pour les autres)\e[0m"
chmod 740 "/home/$user2/$folder1/$file2_1"

echo -e "\e[1;41mReglage des droits de $file2_2 (744, lecture seule pour les autres)\e[0m"
chmod 744 "/home/$user2/$folder1/$file2_2"
chmod o+r "/home/$user2/$folder1/$file2_2"
echo -e "\e[1;32mActions terminee.\e[0m"

#Actions pour le second utilisateur.
cd "/home/$user2/"
echo -e "\e[1;41mAffichage des droits attribués dans /home/$user2/$folder1/\e[0m"
ls -al "/home/$user2/$folder1/"

#Creation de l'archive .taz.gz
echo -e "\e[1;41mCreation de l'archive $folder1.taz.gz\e[0m"
tar -czvf "/home/$user2/$folder1.taz.gz" "/home/$user2/$folder1/"

#Affichage des processus pour l'utilisateur en cours
echo -e "\e[1;41mAffichage des processus pour l'utilisateur en cours\e[0m"
ps -u "$SUDO_USER"

#Log des processus pour l'utilisateur en cours dans ~/ps_root.txt
echo -e "\e[1;41mLog des processus pour l'utilisateur en cours dans ~/ps.txt\e[0m"
ps -u "$SUDO_USER" >> "/home/$SUDO_USER/ps.txt"

#Creation du lien symbolique
echo -e "\e[1;41mCreation du lien symbolique\e[0m"
ln -s "/home/$user2/$folder1" "/home/$SUDO_USER/$folder1"
echo -e "\e[1;41mActions diverses.\e[0m"