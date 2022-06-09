#!/usr/bin/env bash

nombre=0
#tant que $nombre < 10
while [ "$nombre" -lt "10" ]
do
echo "Ilies la synthaxe !"
nombre=$(($nombre+1))
done


#########################################################
#########################################################
#########################################################

#jusqu'à ce que $nombre < 0
until [ "$nombre" -eq "0" ]
do
echo "Ilies la synthaxe bordel !"
nombre=$(($nombre-1))
done
