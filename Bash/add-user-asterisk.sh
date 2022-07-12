#!/bin/bash
echo "###################################################"
echo "### Script d'ajout d'utilisateurs pour Asterisk ###"
echo "###################################################"

#Checking if script is launched with sudo/root
if [  "$USER" != "root" ]
then
echo -e "\e[1;31mCe script doit être executé en tant que root/sudo, arrêt du script.\e[0m"
exit
fi

#Define conf files path
SIP=/etc/asterisk/sip.conf
EXTENSIONS=/etc/asterisk/extensions.conf

#test if conf file exists
if [ ! -f "$SIP" ]; then
    echo -e "\e[1;31mfichier $SIP manquant, arrêt du script.\e[0m"
    exit
fi
if [ ! -f "$EXTENSIONS" ]; then
    echo -e "\e[1;31mfichier $EXTENSIONS manquant, arrêt du script..\e[0m"
    exit
fi

#Prompt user for informations
read -p "Nom de l'utilisateur a créer : " username
read -s -p "Mot de passe de l'utilisateur : " password
read -p "Numero de l'utililsateur a creer : " number
read -p "Priorite l'utililsateur a creer (1-4) : " priority
echo "" 
echo -e "\e[1;33m### L'utilisateur crée héritera des proprietes de \"tssr\" ###\e[0m" 
echo ""

#Adding informations in conf files
echo "[$number](tssr)
secret=$password
callerid=\"$username\" <$number>" >> $SIP
echo -e "\n\e[1;32m### Ajouté dans le fichier $SIP ###\e[0m" 

echo "exten => $number,$priority,Dial(SIP/$number)" >> $EXTENSIONS
echo -e "\n\e[1;32m### Ajouté dans le fichier $EXTENSIONS ###\e[0m" 

echo "### Redemarrage du serveur ###" 
systemctl restart asterisk
