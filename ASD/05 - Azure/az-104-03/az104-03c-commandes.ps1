#Update un disque dur PS
New-AzDiskUpdateConfig -DiskSizeGB 64 | Update-AzDisk -ResourceGroupName $rgName -DiskName $diskName
New-AzDiskUpdateConfig -sku Premium_LRS | Update-AzDisk -ResourceGroupName $rgName -DiskName $diskName