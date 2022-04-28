[int]$try = 5

Write-host "THE MENTALIST"
Write-host "Vous avez $try essais pour trouver le nombre aléatoire"

$random_number = Get-Random -Minimum 0 -Maximum 100

do{
Write-host "$try essais restants"
$prompt = read-host "Veuillez saisir un nombre entre 0 et 100 (réponse $random_number)"
$try--
} until ($prompt -eq $random_number -or $try -eq 0)

if ($prompt -eq $random_number){
Write-host "Félicitation, vous êtes un champion de mentalisme !" -ForegroundColor Green
}
else{
Write-host "Dommage ! Vous ferez mieux la prochaine fois." -ForegroundColor Red
}
