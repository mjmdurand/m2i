#!/usr/bin/env python3

from bs4 import BeautifulSoup
import requests

website="https://tomcoaching.net"
r=requests.get(website)
page=r.text
soup = BeautifulSoup(page, "html.parser")

# Pour recuperer tous les liens de la page :
links=soup.find_all('a')
# On parcours tous les liens pour recuprer le 'href' (vers quoi il "pointe")

linkList=[]
for elem in links:
    check=str(elem.get('href'))
    #if check[0:4] == "http": #Vérification qu'il s'agit bien d'un lien
    if check.startswith(website): #Vérification qu'il s'agit bien d'un lien du site
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
