#!/usr/bin/env bash

#Exo 08 :
echo 'Continuer ? (O/N/Q) : '
read continuer

case $continuer in

  O)
    echo 'vous avez choisi oui'
    ;;

  N)
    echo 'vous avez choisi non'
    ;;

  Q)
    echo 'vous sortez du programme'
    exit 1
    ;;
esac
echo 'le programme continue'

