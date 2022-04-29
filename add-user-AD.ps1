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
    $locationOU = $user.lieu
    $locationOUpath = "OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $locationOUpath') {
        Write-Host "$locationOU already exists." -ForegroundColor red
    } 
    else {
        Write-Host "$locationOU don't exists." -ForegroundColor green
        Write-Host "Creating $locationOU OU" -ForegroundColor yellow
        #New-ADOrganizationalUnit -Name $locationOU -Path $rootOUpath
    }

    #Checking if Users OU is already created, creating it if not
    $UserslocationOUpath = "OU=Users,OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $UserslocationOUpath') {
        Write-Host "Users OU already exists." -ForegroundColor red
    } 
    else {
        Write-Host "Users don't exists." -ForegroundColor green
        Write-Host "Creating Users OU" -ForegroundColor yellow
        #New-ADOrganizationalUnit -Name "Users" -Path $locationOUpath
    }

    #Checking if Computers OU is already created, creating it if not
    $ComputerslocationOUpath = "Ou=Computers,OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $ComputerslocationOUpath') {
        Write-Host "Computer OU already exists." -ForegroundColor red
    } 
    else {
        Write-Host "Computers don't exists." -ForegroundColor green
        Write-Host "Creating Computers OU" -ForegroundColor yellow
        #New-ADOrganizationalUnit -Name "Computers" -Path $locationOUpath
    }
}






$newOU = "OU=$navnpaaou,$parentOU"




