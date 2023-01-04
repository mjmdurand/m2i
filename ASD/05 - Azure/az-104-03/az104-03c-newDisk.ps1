$location = (Get-AzResourceGroup -Name 'az-104-03b-rg').Location
$rgName = 'az-104-03c-rg1' 

$diskConfig = New-AzDiskConfig `
   -location $location `
   -CreateOption Empty `
   -DiskSizeGb 32 `
   -sku Standard_LRS

$diskName = 'az-104-03c-disk1'

New-AzDisk `
    -ResourceGroupName $rgName `
    -diskname $diskName `
    -disk $diskConfig