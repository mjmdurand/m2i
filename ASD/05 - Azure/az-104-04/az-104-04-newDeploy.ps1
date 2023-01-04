$RgName = 'az-104-04-rg1'
New-AzResourceGroupDeployment `
    -ResourceGroupName "$RgName" `
    -TemplateFile "az104-04-vms-loop-template.json" `
    -TemplateParameterFile "az104-04-vms-loop-parameters.json"
    