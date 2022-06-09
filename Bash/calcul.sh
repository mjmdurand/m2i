#!/usr/bin/env bash

read -p "Saisir un nombre entre 0 et 10 ou 20 et 30 : " nombre

if [ "$nombre" -ge "0" ] && [ "$nombre" -le "10" ]
then
    echo "le nombre est entre 0 et 10"
################
elif [ "$nombre" -ge "20" ] && [ "$nombre" -le "30" ]
then
    echo "le nombre est entre 20 et 30"
################
else
    echo "le nombre est incorrect"
fi
