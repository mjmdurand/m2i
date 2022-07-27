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
}


