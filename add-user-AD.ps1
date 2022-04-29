$csv = "C:\utilisateurs.csv"
$data = Import-Csv -Path $csv -Delimiter ';'

$DCtld='lan'
$DCdomain='m2i'
$rootOU = 'organisation'


#check if root OU is already created, creating it if not
$rootOUpath = "OU=$rootOU,DC=$DCdomain,DC=$DCtld"
if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $rootOUpath') {
    Write-Host "$rootOUpath already exists." -ForegroundColor Red
  } 
  else {
    Write-Host "$rootOUpath don't exists." -ForegroundColor green
    Write-Host "Creating $rootOUpath OU" -ForegroundColor yellow
    #New-ADOrganizationalUnit -Name $rootOU -Path "DC=$DCdomain,DC=$DCtld"
  }

#check if location OU is already created, creating it if not
foreach($user in $data){
    $locationOU = $user.lieu.Tolower()
    $locationOUpath = "OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $locationOUpath') {
    } 
    else {
        Write-Host "$locationOU OU don't exists." -ForegroundColor green
        Write-Host "Creating $locationOU OU" -ForegroundColor yellow
        New-ADOrganizationalUnit -Name $locationOU -Path $rootOUpath
    }

    #Checking if Users OU is already created, creating it if not
    $UserslocationOUpath = "OU=users,OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $UserslocationOUpath') {
    } 
    else {
        Write-Host "Users OU don't exists." -ForegroundColor green
        Write-Host "Creating Users OU" -ForegroundColor yellow
        New-ADOrganizationalUnit -Name "users" -Path $locationOUpath
    }

    #Checking if Computers OU is already created, creating it if not
    $ComputerslocationOUpath = "Ou=computers,OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $ComputerslocationOUpath') {
    } 
    else {
        Write-Host "Computers OU don't exists." -ForegroundColor green
        Write-Host "Creating Computers OU" -ForegroundColor yellow
        New-ADOrganizationalUnit -Name "computers" -Path $locationOUpath
    }


    #Checking if User is already in AD
    $name = $user.nom.Tolower()
    $firstName = $user.prenom.Tolower()
    $phone = $user.telephone.Tolower()
    $userLogin = $name+'.'+$firstName
   
    if (Get-ADUser -Filter {SamAccountName -eq $userLogin})
    {
        Write-Host "User $userLogin already exists." -ForegroundColor red        
    }
    else{
        Write-Host "User $userLogin don't exists." -ForegroundColor green
    }



