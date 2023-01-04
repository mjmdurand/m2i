import sys

def GetInputs(file):
    data=open(file, "w")
    nom=""
    while nom != "fin":
        nom=input("Nom : ")
        nom=nom.lower()
        if nom != "fin":
            prenom=input("Prenom : ")
            math=input("Math : ")
            anglais=input("Anglais : ")
            omgl=input("OMGL : ")
            ap2=input("AP2 : ")
            tableData=[nom, prenom, math, anglais, omgl, ap2]
            toAppend=join="!".join(tableData)
            data.write(toAppend+"\n")
    data.close()
GetInputs("test.txt")
