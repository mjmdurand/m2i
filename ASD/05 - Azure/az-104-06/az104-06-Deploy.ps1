$location = 'westeurope'

$rgname = 'az104-06-rg1'

New-AzResourceGroup -name $rgname -location $location

$ResourceGroupDeployParams = @{
    ResourceGroupName = $rgname
    TemplateFile = 'az104-06-vms-loop-template.json'
    TemplateParameterFile = 'az104-06-vms-loop-parameters.json'

}
New-AzResourceGroupDeployment @ResourceGroupDeployParams