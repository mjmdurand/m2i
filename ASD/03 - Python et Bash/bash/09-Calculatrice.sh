#!/usr/bin/env bash

#Exo 09 :
read -p "Saisir le premier nombre : " nombre1
read -p "Saisir un operateur (+-/*) : " operateur
read -p "Saisir le second nombre : " nombre2


if [ "$operateur" == "+" ]
then
    nombre=$(($nombre1+$nombre2))
    echo "$nombre"
################
elif [ "$operateur" == "-" ]
then
    nombre=$(($nombre1-$nombre2))
    echo "$nombre"
################
elif [ "$operateur" == "*" ]
then
    nombre=$(($nombre1*$nombre2))
    echo "$nombre"
################
elif [ "$operateur" == "/" ]
then
    nombre=$(($nombre1/$nombre2))
    echo "$nombre"
################
else
    echo "l'opérateur "$operateur" est incorrect"
fi