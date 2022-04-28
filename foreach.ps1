$userlist = Get-LocalUser
foreach ($user in $userlist){
    if ($user.Enabled -eq "True"){
        Write-Host "l'utilisateur"$user.Name"est activé. ( SID : "$user.SID")" -ForegroundColor Green
    }
    else{
        Write-Host "l'utilisateur"$user.Name"n'est pas activé. ( SID : "$user.SID")" -ForegroundColor Red
    }

    
}



$data = Get-Service
$tri = $data | sort-object -Property status
foreach ($status in $tri){
switch($status.Status){
    "Running" { Write-Host "Le service "$status.Name" est en cours d'execution" -ForegroundColor Green
    Start-Sleep -Seconds 1}
    "Stopped" { Write-Host "Le service "$status.Name" n'est pas en cours d'execution" -ForegroundColor Red
    Start-Sleep -Seconds 1}
    default { Write-Host "Erreur : impossible d'obtenir des informations sur le service "$status.Name -ForegroundColor Yellow
    Start-Sleep -Seconds 1}
}
}


#avec variables
$data=Get-Service;$tri=$data | Sort-Object -Property Status; foreach ($status in $tri){ switch ($status.Status){"Running" {Write-Host "Le service"$status.Name"est en cours d'execution" -ForegroundColor Green} "Stopped" {Write-Host "Le service"$status.Name"n'est pas en cours d'execution" -ForegroundColor Red} default {Write-Host "Erreur : impossible d'obtenir des informations sur le service"$status.Name -ForegroundColor Yellow}}}

#sans variable
Get-Service | Sort-Object -Property Status | foreach{if ($_.Status -eq "Running") {Write-Host "Le service"$_.Name"est en cours d'execution" -ForegroundColor Green} elseif ($_.Status -eq "Stopped") {Write-Host "Le service"$_.Name"n'est pas en cours d'execution" -ForegroundColor Red} else {Write-Host "Erreur : impossible d'obtenir des informations sur le service"$_.Name -ForegroundColor Yellow}}

Get-Service | Sort-Object -Property Status | foreach{switch ($_.Status){ "Running"{Write-Host "Le service"$_.Name"est en cours d'execution" -ForegroundColor Green} "Stopped"{Write-Host "Le service"$_.Name"n'est pas en cours d'execution" -ForegroundColor Red} default{Write-Host "Erreur : impossible d'obtenir des informations sur le service"$_.Name -ForegroundColor Yellow}}}

(Get-Service | Where-Object {$_.Status -eq "Stopped"} | Sort-Object -Property Name | foreach{Write-Host "Le service"$_.Name"n'est pas en cours d'execution" -ForegroundColor Red});(Get-Service | Where-Object {$_.Status -eq "Running"} | Sort-Object -Property Name | foreach{Write-Host "Le service"$_.Name"est en cours d'execution" -ForegroundColor Green})


Get-Service | Where-Object {$_.Status -eq "Running"} | Sort-Object -Property Name | foreach{Write-Host "Le service"$_.Name"est en cours d'execution" -ForegroundColor Green}

