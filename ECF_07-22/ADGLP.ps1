$csv = "C:\ADGLP.csv"
$data = Import-Csv -Path $csv -Delimiter ';'

$DCtld='faitchaud'
$DCdomain='oskour'
$rootOU = 'organisation'


#check if GG OU is already created, creating it if not
$GGOUpath = "OU=GG,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $GGOUpath') {
  } 
  else {
    Write-Host "Creating $rootOUpath OU" -ForegroundColor yellow
    New-ADOrganizationalUnit -Name "GG" -Path "OU=$rootOU,DC=$DCdomain,DC=$DCtld"
  }

#check if DL OU is already created, creating it if not
$DLOUpath = "OU=DL,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $DLOUpath') {
  } 
  else {
    Write-Host "Creating $rootOUpath OU" -ForegroundColor yellow
    New-ADOrganizationalUnit -Name "DL" -Path "OU=$rootOU,DC=$DCdomain,DC=$DCtld"
  }

#Explode CSV
foreach($user in $data){

    #Store GG/DL name in a var
    $name = $user.nom.Tolower()

########################################################################################
    #Checking if GG is already in AD
    #if GG already exists
    if (Get-ADGroup -Filter {SamAccountName -eq "GG_$name"})
    {
        Write-Host "GG_$name already exists." -ForegroundColor red        
    }

    #creating GG if not exists
    else{
        Write-Host "Creating GG_$name." -ForegroundColor green
        try { 
            New-ADGroup -Name "GG_$name" `
            -SamAccountName "GG_$name" `
            -GroupCategory Security `
            -GroupScope DomainLocal `
            -DisplayName "GG_$name" `
            -Path "OU=GG,OU=$rootOU,DC=$DCdomain,DC=$DCtld" `
            -Description "$name"
        }
        catch {Write-Host "Error while creating GG_$name.." -ForegroundColor red }
    }
########################################################################################
    #Checking if DL_RO is already in AD
    #if DL_RO already exists
    if (Get-ADGroup -Filter {SamAccountName -eq "DL_RO_$name"})
    {
        Write-Host "DL_RO_$name already exists." -ForegroundColor red        
    }

    #creating DL_RO if not exists
    else{
        Write-Host "Creating DL_RO_$name." -ForegroundColor green
        try { 
            New-ADGroup -Name "DL_RO_$name" `
            -SamAccountName "DL_RO_$name" `
            -GroupCategory Security `
            -GroupScope DomainLocal `
            -DisplayName "DL_RO_$name" `
            -Path "OU=DL,OU=$rootOU,DC=$DCdomain,DC=$DCtld" `
            -Description "$name"
        }
        catch {Write-Host "Error while creating DL_RO_$name.." -ForegroundColor red }
    }
########################################################################################
    #Checking if DL_RW is already in AD
    #if DL_RW already exists
    if (Get-ADGroup -Filter {SamAccountName -eq "DL_RW_$name"})
    {
        Write-Host "DL_RW_$name already exists." -ForegroundColor red        
    }

    #creating DL_RW if not exists
    else{
        Write-Host "Creating DL_RW_$name." -ForegroundColor green
        try { 
            New-ADGroup -Name "DL_RW_$name" `
            -SamAccountName "DL_RW_$name" `
            -GroupCategory Security `
            -GroupScope DomainLocal `
            -DisplayName "DL_RW_$name" `
            -Path "OU=DL,OU=$rootOU,DC=$DCdomain,DC=$DCtld" `
            -Description "$name"
        }
        catch {Write-Host "Error while creating DL_RW_$name.." -ForegroundColor red }
    }
########################################################################################
    #Checking if DL_CT is already in AD
    #if DL_CT already exists
    if (Get-ADGroup -Filter {SamAccountName -eq "DL_CT_$name"})
    {
        Write-Host "DL_CT_$name already exists." -ForegroundColor red        
    }

    #creating DL_CT if not exists
    else{
        Write-Host "Creating DL_CT_$name." -ForegroundColor green
        try { 
            New-ADGroup -Name "DL_CT_$name" `
            -SamAccountName "DL_CT_$name" `
            -GroupCategory Security `
            -GroupScope DomainLocal `
            -DisplayName "DL_CT_$name" `
            -Path "OU=DL,OU=$rootOU,DC=$DCdomain,DC=$DCtld" `
            -Description "$name"
        }
        catch {Write-Host "Error while creating DL_CT_$name.." -ForegroundColor red }
    }

}