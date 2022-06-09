do{
    [int]$nbre = Read-Host "(1) Saisissez un nombre entre 0 et 10"
    } until ($nbre -ge 0 -and $nbre -lt 10)
    
    
    do{
    [int]$nbre = Read-Host "(2) Saisissez un nombre entre 0 et 10"
    } while ($nbre -lt 0 -or $nbre -ge 10)