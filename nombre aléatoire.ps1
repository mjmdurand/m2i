#Clear all old variables
Clear-Variable -Name "history"
Clear-Variable -Name "random_number_min"
Clear-Variable -Name "random_number_max"
Clear-Variable -Name "random_number"
Clear-Variable -Name "mode"
Clear-Variable -Name "try"
Clear-Variable -Name "prompt"

Write-host '~~~~ THE MENTALIST ~~~~' -BackgroundColor Cyan -ForegroundColor white

#Ask for game mode
do {
[string]$mode = Read-host 'Veuillez choisir un mode de jeu : (F)acile, (M)oyen, (D)ifficile'
} until ($mode -eq 'F' -or $mode -eq 'Facile' -or $mode -eq 'M' -or $mode -eq 'Moyen' -or $mode -eq 'D' -or $mode -eq 'Difficile')

#setting variable 
switch ($mode){
    {($_ -eq 'F') -or  ($_ -eq 'Facile')} {
    [int]$random_number_min = 0
    [int]$random_number_max = 10
    [int]$try = 20
    Write-host "Mode Facile selectionné" -ForegroundColor blue
    break     
    }

    {($_ -eq 'M') -or ($_ -eq 'moyen')} {
    [int]$random_number_min = 0
    [int]$random_number_max = 100
    [int]$try = 10
    Write-host "Mode Moyen selectionné" -ForegroundColor blue
    break
    }

    {($_ -eq 'D') -or  ($_ -eq 'Difficile')} {
    [int]$random_number_min = 0
    [int]$random_number_max = 1000
    [int]$try = 5
    Write-host "Mode Difficile selectionné" -ForegroundColor blue
    break    
    }

    default {
    [int]$random_number_min = 0
    [int]$random_number_max = 10
    [int]$try = 20
    Write-host "Mode Facile selectionné (par défaut)" -ForegroundColor blue
    }
}

#generate RNG
[int]$random_number = Get-Random -Minimum $random_number_min -Maximum $random_number_max

#instructions
Write-host "Vous avez $try essais pour trouver le nombre aléatoire"

#game loop
do{
Write-host "$try essais restants" -ForegroundColor yellow
[int]$prompt = read-host "Veuillez saisir un nombre entre $random_number_min et $random_number_max (réponse $random_number)"

    # check if input number is between the max and min values
    while ($prompt -lt $random_number_min -or $prompt -gt $random_number_max){
    Write-host "Un nombre entre $random_number_min et $random_number_max on a dit !" -ForegroundColor Red
    $prompt = read-host "Veuillez saisir un nombre entre $random_number_min et $random_number_max (réponse $random_number)"
    }

$try--
$history = @($history + $prompt)
Write-host "Valeurs déjà saisies : $history" -ForegroundColor Cyan

} until ($prompt -eq $random_number -or $try -eq 0)

if ($prompt -eq $random_number){
Write-host "Félicitation, vous êtes un champion de mentalisme !" -ForegroundColor Green
}

else{
Write-host "Dommage ! Vous ferez mieux la prochaine fois." -ForegroundColor Red
}
