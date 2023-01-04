#Variables
$RgName = 'exo1-rg1'
$location = (Get-AzResourceGroup -Name 'exo1-rg1').Location
$vnet = @{
    Name = 'VNet2'
    ResourceGroupName = $RgName
    Location = $location
    AddressPrefix = '10.20.0.0/16'
}
$subnetsToCreate = @(
    [pscustomobject]@{Name="Front";Address="10.20.1.0/24"},
    [pscustomobject]@{Name="Back";Address="10.20.2.0/24"})


#Create Ressource Group
New-AzResourceGroup -Name $RgName -location $location

#Create VMNetwork
$virtualNetwork = New-AzVirtualNetwork @vnet

#Create Subnets
Foreach($element in $subnetsToCreate) 
{ 
     $subnet = @{
        Name = $element.Name
        VirtualNetwork = $virtualNetwork
        AddressPrefix = $element.Address
    }
    $subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet
}

#Associate subnets
$virtualNetwork | Set-AzVirtualNetwork