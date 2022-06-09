#!/usr/bin/env bash

read -p "Veuillez saisir votre nom : " nom
read -p "Veuillez saisir votre prenom : " prenom

nomcomplet="Mr $prenom $nom"

#cd /var/
dossier=$(pwd)
machine=$HOSTNAME

echo "Nom de la machine : $machine"

echo "Hello $nomcomplet !"
echo "dossier actuel : $dossier"

exit

unset prenom
prenom="Yacine"
echo "Bye $prenom !"
