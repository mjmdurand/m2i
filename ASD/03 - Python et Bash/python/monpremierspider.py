#!/usr/bin/env python3

# Pour installer desa modules python, on utilise "pip". 
# Installer pip sur debian : sudo apt install python3-pip
# Installation de module avec pip:
# pip install <nomdumodule>.
# Ici: pip install bs4 requests
# Ici on importe le module BeautifulSoup, parser HTML
from bs4 import BeautifulSoup
# Ici on importe le module requests, qui permet d'interroger des serveur HTTP
import requests

website="https://tomcoaching.net"
# On interroge le site pour recupere la page web
r=requests.get(website)
# On recupere le code HTML de la page
page=r.text
# On declare une variable beautifulsoup avec le parser HTML
soup = BeautifulSoup(page, "html.parser")
# Recuperation du titre de la page
title=soup.title
print("titre de la page: ",title)
# Pour recuperer tous les liens de la page :
links=soup.find_all('a')
# On parcours tous les liens pour recuprer le 'href' (vers quoi il "pointe")

linkList=[]
for elem in links:
    check=str(elem.get('href'))
    if check[0:4] == "http": #Vérification qu'il s'agit bien d'un lien
        if check[-1] == "/": #Suppression des / en fin d'URL pour éviter les doublons
            linkList.append(check[0:-1])
        else:
            linkList.append(check)

#Vérification des doublons et écriture dans le fichier
seen = set()
uniq = []
file=open("liens.txt", "w")
for x in linkList:
    if x not in seen:
        uniq.append(x)
        print(x)
        file.write(x+"\n")
        seen.add(x)
file.close()
