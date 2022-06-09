#!/usr/bin/env bash
numero=0
while [ "$numero" -eq "0" ]
do
  read -p "Voulez-vous continuer ? (oui/non)" rep
  if [ "$rep" = "oui" ]
  then
    continue
  elif [ "$rep" = "non" ]
  then
    break
  else
    continue
  fi
done



