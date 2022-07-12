#!/bin/bash

#Define conf files path
SIP=/etc/asterisk/sip.conf
EXTENSIONS=/etc/asterisk/extensions.conf

echo "###################################################"
echo "### Script d'ajout d'utilisateurs pour Asterisk ###"
echo "###################################################"

echo -e "\n\e[1;44mVerifications.\e[0m"
#Checking if script is launched with sudo/root
if [  "$USER" != "root" ]
then
echo -e "\e[1;31mCe script doit être executé en tant que root/sudo, arrêt du script.\e[0m"
exit
fi

#test if conf file exists
if [ ! -f "$SIP" ]; then
    echo -e "\e[1;31mfichier $SIP manquant, arrêt du script.\e[0m"
    exit
fi

if [ ! -f "$EXTENSIONS" ]; then
    echo -e "\e[1;31mfichier $EXTENSIONS manquant, arrêt du script..\e[0m"
    exit
fi
echo -e "\n\e[1;32m### OK ###\e[0m" 

#Prompt user for informations
echo -e "\n\e[1;44msaisie des informations requises.\e[0m"
read -p "Nom de l'utilisateur a créer : " username
read -s -p "Mot de passe de l'utilisateur : " password
echo ""
read -p "Numero de l'utilisateur a creer : " number
read -p "Priorite l'utilisateur a creer (1-4) : " priority
echo "" 
echo -e "\n\e[1;32m### OK ###\e[0m"
echo -e "\e[1;33m### L'utilisateur crée héritera des proprietes de \"tssr\" ###\e[0m" 
sleep 5

#Adding informations in conf files
echo -e "\n\e[1;44mAjout dans le fichier $SIP \e[0m"
echo "[$number](tssr)
secret=$password
callerid=\"$username\" <$number>" >> $SIP
echo -e "\n\e[1;32m### OK ###\e[0m" 

echo -e "\n\e[1;44mAjout dans le fichier $EXTENSIONS \e[0m"
echo "exten => $number,$priority,Dial(SIP/$number)" >> $EXTENSIONS
echo -e "\n\e[1;32m### OK ###\e[0m" 

echo -e "\e[1;33m### Redémarrage du serveur Asterisk ###\e[0m" 
systemctl restart asterisk
echo -e "\n\e[1;32m### OK ###\e[0m"

echo -e "\n\e[1;41mUser successfully added.\e[0m"
