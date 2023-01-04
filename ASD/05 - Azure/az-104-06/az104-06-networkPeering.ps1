### A FAIRE MANUELLEMENT ###
### regler le peerig autorisé/autorisé sur vnet2 & vnet3
### laisser le peerig autorisé/bloqués ur vnet01

$rgname = 'az104-06-rg1'

$vnet01 = Get-AzVirtualNetwork -Name 'az104-06-vnet01' -ResourceGroupName $rgname
$vnet2 = Get-AzVirtualNetwork -Name 'az104-06-vnet2' -ResourceGroupName $rgname
$vnet3 = Get-AzVirtualNetwork -Name 'az104-06-vnet3' -ResourceGroupName $rgname

Add-AzVirtualNetworkPeering -Name 'az104-06-vnet01_to_az104-06-vnet2' -VirtualNetwork $vnet01 -RemoteVirtualNetworkId $vnet2.id 
Add-AzVirtualNetworkPeering -Name 'az104-06-vnet2_to_az104-06-vnet01' -VirtualNetwork $vnet2 -RemoteVirtualNetworkId $vnet01.id 
Add-AzVirtualNetworkPeering -Name 'az104-06-vnet01_to_az104-06-vnet3' -VirtualNetwork $vnet01 -RemoteVirtualNetworkId $vnet3.id 
Add-AzVirtualNetworkPeering -Name 'az104-06-vnet3_to_az104-06-vnet01' -VirtualNetwork $vnet3 -RemoteVirtualNetworkId $vnet01.id