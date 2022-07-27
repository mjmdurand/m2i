$csv = "C:\utilisateurs.csv"
$data = Import-Csv -Path $csv -Delimiter ';'

$publicTld='fr'
$publicDomain='m2iformation'

$DCtld='faitchaud'
$DCdomain='oskour'
$rootOU = 'organisation'
$Defaultpassword = 'Pa$$w0rd'


#check if root OU is already created, creating it if not
$rootOUpath = "OU=$rootOU,DC=$DCdomain,DC=$DCtld"
if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $rootOUpath') {
  } 
  else {
    Write-Host "Creating $rootOUpath OU" -ForegroundColor yellow
    New-ADOrganizationalUnit -Name $rootOU -Path "DC=$DCdomain,DC=$DCtld"
  }

#check if location OU is already created, creating it if not
foreach($user in $data){
    $locationOU = $user.lieu.Tolower()
    $locationOUpath = "OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $locationOUpath') {
    } 
    else {
        Write-Host "Creating $locationOU OU" -ForegroundColor yellow
        New-ADOrganizationalUnit -Name $locationOU -Path $rootOUpath
    }

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
    #Checking if Users OU is already created, creating it if not
    $UserslocationOUpath = "OU=users,OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $UserslocationOUpath') {
    } 
    else {
        Write-Host "Creating Users OU" -ForegroundColor yellow
        New-ADOrganizationalUnit -Name "users" -Path $locationOUpath
    }

    #Checking if Computers OU is already created, creating it if not
    $ComputerslocationOUpath = "Ou=computers,OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $ComputerslocationOUpath') {
    } 
    else {
        Write-Host "Creating Computers OU" -ForegroundColor yellow
        New-ADOrganizationalUnit -Name "computers" -Path $locationOUpath
    }


    #Checking if User is already in AD
    $name = $user.nom.Tolower()
    $firstName = $user.prenom.Tolower()
    $phone = $user.telephone.Tolower()
    $userLogin = $name+'.'+$firstName

    $publicmail = "$firstName.$name@$locationOU.$publicDomain.$publicTld"
   
    #if user already exists
    if (Get-ADUser -Filter {SamAccountName -eq $userLogin})
    {
        Write-Host "User $userLogin ($firstName $name) already exists." -ForegroundColor red        
    }
    ########################################################################################
    #creating user if not exists
    else{
        Write-Host "Creating user $userLogin ($firstName $name)." -ForegroundColor green
        try { 
            New-ADUser -Name "$name $firstName" `
            -DisplayName "$firstName $name" `
            -SamAccountName $userLogin `
            -UserPrincipalName "$publicmail@$DCdomain.$DCtld" `
            -MobilePhone "$phone" `
            -Office "$locationOU" `
            -EmailAddress $publicmail `
            -Path "$UserslocationOUpath" `
            -AccountPassword(ConvertTo-SecureString $Defaultpassword -AsPlainText -Force) `
            -ChangePasswordAtLogon $false `
            -Enabled $true
        }
        catch {Write-Host "Error while creating user ($userLogin, $firstName $name)." -ForegroundColor red }
    }

    ########################################################################################
    #Checking if GG is already in AD
    #if GG already exists
    if (Get-ADGroup -Filter {SamAccountName -eq "GG_$locationOU"})
    {
        Write-Host "GG_$locationOU already exists." -ForegroundColor red        
    }

    #creating GG if not exists
    else{
        Write-Host "Creating GG_$locationOU." -ForegroundColor green
        try { 
            New-ADGroup -Name "GG_$locationOU" `
            -SamAccountName "GG_$locationOU" `
            -GroupCategory Security `
            -GroupScope Global `
            -DisplayName "GG_$locationOU" `
            -Path "OU=GG,OU=$rootOU,DC=$DCdomain,DC=$DCtld" `
            -Description "$locationOU"
        }
        catch {Write-Host "Error while creating GG_$locationOU." -ForegroundColor red }
    }
########################################################################################
    #Checking if DL_RO is already in AD
    #if DL_RO already exists
    if (Get-ADGroup -Filter {SamAccountName -eq "DL_RO_$locationOU"})
    {
        Write-Host "DL_RO_$locationOU already exists." -ForegroundColor red        
    }

    #creating DL_RO if not exists
    else{
        Write-Host "Creating DL_RO_$locationOU." -ForegroundColor green
        try { 
            New-ADGroup -Name "DL_RO_$locationOU" `
            -SamAccountName "DL_RO_$locationOU" `
            -GroupCategory Security `
            -GroupScope DomainLocal `
            -DisplayName "DL_RO_$locationOU" `
            -Path "OU=DL,OU=$rootOU,DC=$DCdomain,DC=$DCtld" `
            -Description "$locationOU"
        }
        catch {Write-Host "Error while creating DL_RO_$locationOU." -ForegroundColor red }
    }
########################################################################################
    #Checking if DL_RW is already in AD
    #if DL_RW already exists
    if (Get-ADGroup -Filter {SamAccountName -eq "DL_RW_$locationOU"})
    {
        Write-Host "DL_RW_$locationOU already exists." -ForegroundColor red        
    }

    #creating DL_RW if not exists
    else{
        Write-Host "Creating DL_RW_$locationOU." -ForegroundColor green
        try { 
            New-ADGroup -Name "DL_RW_$locationOU" `
            -SamAccountName "DL_RW_$locationOU" `
            -GroupCategory Security `
            -GroupScope DomainLocal `
            -DisplayName "DL_RW_$locationOU" `
            -Path "OU=DL,OU=$rootOU,DC=$DCdomain,DC=$DCtld" `
            -Description "$locationOU"
        }
        catch {Write-Host "Error while creating DL_RW_$locationOU." -ForegroundColor red }
    }
########################################################################################
    #Checking if DL_CT is already in AD
    #if DL_CT already exists
    if (Get-ADGroup -Filter {SamAccountName -eq "DL_CT_$locationOU"})
    {
        Write-Host "DL_CT_$locationOU already exists." -ForegroundColor red        
    }

    #creating DL_CT if not exists
    else{
        Write-Host "Creating DL_CT_$locationOU." -ForegroundColor green
        try { 
            New-ADGroup -Name "DL_CT_$locationOU" `
            -SamAccountName "DL_CT_$locationOU" `
            -GroupCategory Security `
            -GroupScope DomainLocal `
            -DisplayName "DL_CT_$locationOU" `
            -Path "OU=DL,OU=$rootOU,DC=$DCdomain,DC=$DCtld" `
            -Description "$locationOU"
        }
        catch {Write-Host "Error while creating DL_CT_$locationOU." -ForegroundColor red }
    }
########################################################################################
    #Adding user in GG    
    Add-ADGroupMember -Identity "GG_$locationOU" -Members "$userLogin"


}


