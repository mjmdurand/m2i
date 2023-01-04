$location = 'westeurope'
$rgname = 'az104-06-rg1'
$vmNames = (Get-AzVm -ResourceGroupName $rgname).name

foreach ($vmName in $vmNames)
{
Set-AzVMExtension `
    -ResourceGroupName $rgname `
    -location $location `
    -VMName $vmName `
    -Name 'networkWatcherAgent' `
    -Publisher 'Microsoft.Azure.NetworkWatcher' `
    -Type 'NetworkWatcherAgentWindows' `
    -TypeHandlerVersion '1.4'
}