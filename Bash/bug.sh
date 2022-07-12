#!/usr/bin/env bash

#################
######Cas 1######
#################
echo -e "\e[1;41mCas 1.\e[0m"
read -p "Saisir un nombre : " Nonbre
while [ "$NumeroBoucle" != "$Nombre" ]
    do
    echo "Boucle n° :$NumeroBoucle"
    NumeroBoucle=$(($NumeroBoucle+1))
    done
echo -e "\e[1;32mCas 1 terminé.\e[0m"

#################
######Cas 2######
#################
echo -e "\e[1;41mCas 2.\e[0m"
read -p "Saisir un nombre : " Nombre
#si entre 0 et 10
if ["$Nombre" -ge "0"] && ["$Nombre" -le "10"]
    then
    echo "Le nombre saisi est entre 0 et 10"
#si entre 11 et 20
elif ["$Nombre" -gt "10"] && ["$Nombre" -le "20"]
    then
    echo "Le nombre saisi est entre 11 et 20"
#si entre 21 et 30
elif ["$Nombre" -gt "20"] && ["$Nombre" -le "30"]
    then
    echo "Le nombre saisi est entre 21 et 30"
#si entre 31 et 40
elif ["$Nombre" -gt "30"] && ["$Nombre" -le "40"]
    then
    echo "Le nombre saisi est entre 31 et 40"
#si entre 41 et 50
elif ["$Nombre" -gt "40"] && ["$Nombre" -le "50"]
    then
    echo "Le nombre saisi est entre 41 et 50"
#autres cas
else
    echo "Le nombre saisi n'est pas géré"
echo -e "\e[1;32mCas 2 terminé.\e[0m"

#################
######Cas 3######
#################
echo -e "\e[1;41mCas 3.\e[0m"
#Verification si le script est bien executé avec sudo/root
if [  "$USER" != "root" ]
then
echo -e "\e[1;41mCe script doit être executé en tant que root/sudo.\e[0m"
exit
fi
read -p "Saisir un nom de fichier : " NomFichier
echo "Creation du fichier dans le dossier home de l'utilisateur courant ($SUDO_USER)"
echo "Le code secret est FD-TSSR-0322-LYON" >> "~/$NomFichier.txt"
echo -e "\e[1;32mCas 3 terminé.\e[0m"

#################
######Cas 4######
#################
echo -e "\e[1;41mCas 4.\e[0m"
read -p "Saisir un nombre : " Nombre2
while [ "$NumeroBoucle2" != "$Nombre2" ]
    do
    echo "Boucle n° :$NumeroBoucle2"
    done
echo -e "\e[1;32mCas 4 terminé.\e[0m"

#################
######Cas 5######
#################
echo -e "\e[1;41mCas 5.\e[0m"
echo "Modification des droits recursivement d'un dossier (/home/$SUDO_USER/droits.txt)"
mkdir "/home/$SUDO_USER/dossiertest"
touch "/home/$SUDO_USER/dossiertest/droits.txt"
chmod -r 777 "/home/$SUDO_USER/dossiertest"
echo -e "\e[1;32mCas 5 terminé.\e[0m"