<# 
1. Calcul Tva avec IF
Entrée : prix hors taxes (réel)
Code TVA (entier)
Sortie : prix TTC (réel)
Calcul :
Code = 1 → appliquer la TVA à 33%
Code = tout autre valeur → appliquer la TVA à 20.0 %
#>
Write-Host "Exercice 1 : calcul de TVA"
[int16]$price = Read-Host -Prompt "Veuillez saisir le prix HT"
[int16]$TVA = Read-Host -Prompt "Veuillez rentrer le code TVA (1) 33%, (autre) 20%"

if ($TVA -eq 1)
{
    $TTC = $price * 1.33
}
else {
    $TTC = $price * 1.2
}
Write-Host "Le prix TTC est de $TTC"



<#
2. Calcul de location de véhicules
Entrée : jour (entier)
Km (entier)
Code (entier)
Sortie : prix de la location de véhicules
Calcul : 
Jour > 30 : prix = 0.5 * km + 60 * jour
Jour <= 30 : 
Code = 0 → prix = 0.5 * km + 60 * jour
Code = 1 → prix = 0.8 * km + 50 * jour
Code = autre valeur → prix = 0.9 * km
#>

Write-Host "Exercice 2 : Calcul de location"
[int16]$days = Read-Host -Prompt "Veuillez saisir le nombre de jours de location"
[int16]$km = Read-Host -Prompt "Veuillez saisir le nombre de km prevus"

if ($days -gt 30){
    $price = 0.5 * $km + 60 * $days
} 
else {
    [int16]$code = Read-Host  -prompt "Code de vente (0) (1) (autre)"
    if ($code -eq 0){
        $price = 0.5 * $km + 60 * $days
    }
    elseif ($code -eq 1) {
        $price = 0.8 * $km + 50 * $days        
    }
    else {
        $price = 0.9 * $km
    }
    
}
Write-Host "Le total a regler est de $price"

<#
3. Le plus petit nombre
Entrée : A, B et C (numériques)
Sortie : Afficher la plus petite valeur parmi les trois
Calcul : A vous de voir…
#>

Write-Host "Exercice 3 : Le plus petit nombre"
[int16]$nb1 = Read-Host -Prompt "Saisir le premier nombre"
[int16]$nb2 = Read-Host -Prompt "Saisir le second nombre"
[int16]$nb3 = Read-Host -Prompt "Saisir le troisième nombre"
$array = ($nb1,$nb2,$nb3)
$lower = $array | Sort-Object | select -First 1
Write-Host "La valeur la plus basse est $lower"

$lower2 = $array | Sort
Write-Host "V2 : La valeur la plus basse est" $lower2[0]


<#
4. Calculette
Entrée : a, b (réels)
operateur (chaîne comprise dans {‘+’, ’-‘, ’*’, ’/’}, attention pas de contrôle à la saisie, mais 
contrôle à l’exécution)
Sortie : Affichage du type « a opérateur b = résultat »
Calcul : Attention : (1) Message d’erreur approprié si opérateur inconnu ; (2) Si ‘/’, vérifier que b est 
différent de zéro, erreur sinon.
#>

Write-Host "Exercice 4 : Calculette"
[int16]$nb1 = Read-Host -Prompt "Saisir le premier nombre"
[string]$operator = Read-Host -Prompt "Saisir l'operateur (+) Addition (-) Soustraction (*) Multiplication (/) Division"
[int16]$nb2 = Read-Host -Prompt "Saisir le second nombre"
[int16]$erreur = 0
switch ($operator){
    '+' {$total = $nb1 + $nb2
        break}
    '-' {$total = $nb1 - $nb2
        break}
    '*' {$total = $nb1 * $nb2
        break}
    '/' {
        switch ($nb2){
            0 { $erreur = 2
            break}
            default {$total = $nb1 / $nb2}
        }
        break}
    default {$erreur = 1}
}

if ($erreur -eq 1){
    Write-Host "Operateur inconnu"    
}

elseif ($erreur -eq 2) {
    Write-Host "Division par zero impossible" 
}

else {
    Write-Host "Resultat : $total"
}