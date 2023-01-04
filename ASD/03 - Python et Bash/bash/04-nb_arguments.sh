#!/usr/bin/env bash

#Exo 04 : 
if [ "$#" -eq "2" ]
then
    nom_script='Ok pour fonctionner'
else
    nom_script='il faut deux arguments'
    exit 1
fi
echo $nom_script
