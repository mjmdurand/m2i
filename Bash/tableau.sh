#!/usr/bin/env bash
read -p "Choisir une couleur : " choix

couleurs=( "bleu" "rouge" "jaune" "vert" )

for  couleurencours in ${couleurs[@]}
do
	if [ "$choix" = "$couleurencours"  ]
	then
	echo "couleur correcte"
	break
	else
	echo "couleur incorrecte"
	continue
	fi

done



