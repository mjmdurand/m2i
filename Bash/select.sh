#!/usr/bin/env bash

PS3="Votre choix : "
select choix in biscuit thé chocolat quitter
do
  echo "Vous avez choisi le $REPLY : $choix"
  if [ "$REPLY" -eq "1" ]
  then
    echo "bravo !"
  elif [ "$REPLY" -eq "4" ]
  then
    echo "bye !"
    break
  fi
done
