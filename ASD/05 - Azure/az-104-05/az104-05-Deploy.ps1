$location1 = 'westeurope'
$location2 = 'northeurope'

$rgname = 'az104-05-rg1'

New-AzResourceGroup -name $rgname -location $location1

$ResourceGroupDeployParams = @{
    ResourceGroupName = $rgname
    TemplateFile = 'az104-05-vnetvm-loop-template.json'
    TemplateParameterFile = 'az104-05-vnetvm-loop-parameters.json'
    location1 = $location1
    location2 = $location2
}
New-AzResourceGroupDeployment @ResourceGroupDeployParams