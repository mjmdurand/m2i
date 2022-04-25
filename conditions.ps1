<#TD01
EX01
Entree :
Quel systeme d'exploitation vous utilisez ?

Sortie :
Linux = Linuxien
Windows = Windowsien
#>
Write-Host 'Exercice 1'
$os=Read-Host "Quel systeme d'exploitation vous utilisez ? (w)indows (l)inux"
if ($os -eq 'linux' -or $os -eq 'l') {
    Write-Host 'Vous etes Linuxien' -ForegroundColor Green -BackgroundColor Gray
}
elseif ($os -eq 'windows' -or $os -eq 'w'){
    Write-Host 'Vous etes Windowsien' -ForegroundColor Red -BackgroundColor Blue
}


<#
EX02
Entree :
La terre est ronde oui ou non ?

Sortie :
Oui = Vous etes incroyable
Non = Vous etes pas bon
#>

Write-Host 'Exercice 2'
$earthshape=Read-Host 'La terre est ronde ? oui(o) ou non(n)'
if ($earthshape -eq 'oui' -or $earthshape -eq 'o') {
    Write-Host 'Vous etes incroyable' -ForegroundColor Yellow -BackgroundColor Blue
}
else {
    Write-Host 'Mauvaise reponse' -ForegroundColor Magenta -BackgroundColor Green
}

<#
EX03
Entree
La terre est ronde oui ou non ?
La terre fait partie d'une galaxie qui a pour etoile le soleil oui(o) ou non(n) 

Sortie :
Si les deux reponses juste vous etes incroyable
Sinon vous etes pas bon
#>

Write-Host 'Exercice 3'
$earthshape=Read-Host 'Q1 : La terre est ronde ? oui(o) ou non(n)' 
$galaxy=Read-Host "Q2 : La terre fait partie d'une galaxie qui a pour etoile le soleil ? oui(o) ou non(n)" 
if (($earthshape -eq 'oui' -or $earthshape -eq 'o')-and ($galaxy -eq 'oui' -or $galaxy -eq 'o')) {
    Write-Host 'Vous etes incroyable' -ForegroundColor Yellow -BackgroundColor Blue
}
else{
    Write-Host 'Allez donc reviser !' -ForegroundColor Magenta -BackgroundColor Green
}


<#
EX04
Entree
La terre est ronde oui ou non ?
La terre fait partie d'une galaxie qui a pour etoile le soleil oui(o) ou non(n) 

Sortie :
Si les deux reponses juste vous etes incroyable
Si une sur deux alors à moitie incroyable
Sinon vous etes totalement nul
#>

Write-Host 'Exercice 4' 
$earthshape=Read-Host 'La terre est ronde ? oui(o) ou non(n)' 
$galaxy=Read-Host "La terre fait partie d'une galaxie qui a pour etoile le soleil ? oui(o) ou non(n)" 
if (($earthshape -eq 'oui' -or $earthshape -eq 'o') -and ($galaxy -eq 'oui' -or $galaxy )) {
    Write-Host 'Vous etes incroyable' -ForegroundColor Yellow -BackgroundColor Blue
}
elseif (($earthshape -eq 'oui' -or $earthshape -eq 'o') -or ($galaxy -eq 'oui' -or $galaxy -eq 'o')) {
    Write-Host 'Vous etes incroyable (mais a moitie seulement)' -ForegroundColor Red -BackgroundColor Blue
}
else{
    Write-Host 'Allez donc reviser !' -ForegroundColor Magenta -BackgroundColor Green
}


#la meme mais en boulant si les 2 reponses ne sont pas justes

Write-Host 'Exercice 5'
do {
    $earthshape=Read-Host 'La terre est ronde ? oui(o) ou non(n)'
    $galaxy=Read-Host "La terre fait partie d'une galaxie qui a pour etoile le soleil ? oui(o) ou non(n)" 
    if (($earthshape -eq 'oui' -or $earthshape -eq 'o') -and ($galaxy -eq 'oui' -or $galaxy -eq 'o')) {
        Write-Host 'Vous etes incroyable' -ForegroundColor Yellow -BackgroundColor Blue
    }
    elseif (($earthshape -eq 'oui' -or $earthshape -eq 'o') -or ($galaxy -eq 'oui' -or $galaxy -eq 'o')) {
        Write-Host 'Vous etes incroyable (mais a moitie seulement)' -ForegroundColor Red -BackgroundColor Blue
    }
    else{
        Write-Host 'Allez donc reviser !' -ForegroundColor Magenta -BackgroundColor Green
    }
} until (($earthshape -eq 'oui' -or $earthshape -eq 'o') -and ($galaxy -eq 'oui' -or $galaxy -eq 'o'))
