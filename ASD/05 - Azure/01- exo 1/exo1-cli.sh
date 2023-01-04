#Set Variables
RGNAME='exo1-rg3'
LOCATION=$(az group show --query location --name exo1-rg1 -o tsv)
VNETNAME='VNet3'
SUBNETSADDRESSES=( "10.30.1.0/24" "10.30.2.0/24" )
SUBNETSNAMES=( "Front" "Back")

#Create Ressource Group
az group create \
    --name $RGNAME \
    --location $LOCATION

#Create VMNetwork

az network vnet create \
  --name $VNETNAME \
  --resource-group $RGNAME \
  --location $LOCATION \
  --address-prefixes 10.30.0.0/16 \

#Create Subnets
count=0
for  element in ${SUBNETSADDRESSES[@]}
do
    az network vnet subnet create \
    --resource-group $RGNAME \
    --name ${SUBNETSNAMES[$count]} \
    --vnet-name $VNETNAME \
    --address-prefixes $element
    count=$(($count+1))
done
