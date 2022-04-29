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
    #New-ADOrganizationalUnit -Name $rootOU -Path "DC=$DCdomain,DC=$DCtld"
  }

#check if location OU is already created, creating it if not
foreach($user in $data){
    $locationOU = $data.lieu
    $locationOUpath = "OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $locationOUpath') {
        Write-Host "$locationOU already exists." -ForegroundColor red
    } 
    else {
        #New-ADOrganizationalUnit -Name $locationOU -Path $rootOUpath
    }

    #Checking if Users OU is already created, creating it if not
    $locationOUpath = "OU=Users,OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $UserslocationOUpath') {
        Write-Host "Users OU already exists." -ForegroundColor red
    } 
    else {
        #New-ADOrganizationalUnit -Name "Users" -Path $locationOUpath
    }

    #Checking if Computers OU is already created, creating it if not
    $locationOUpath = "Ou=Computers,OU=$locationOU,OU=$rootOU,DC=$DCdomain,DC=$DCtld"
    if (Get-ADOrganizationalUnit -Filter 'distinguishedName -eq $ComputesrlocationOUpath') {
        Write-Host "Computer OU already exists." -ForegroundColor red
    } 
    else {
        #New-ADOrganizationalUnit -Name "Computers" -Path $locationOUpath
    }
}






$newOU = "OU=$navnpaaou,$parentOU"




