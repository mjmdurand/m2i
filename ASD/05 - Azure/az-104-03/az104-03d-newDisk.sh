RGNAME='az-104-03d-rg1'
DISKNAME='az-104-03d-disk1'
LOCATION=$(az group show --query location --name az-104-03c-rg1 -o tsv)
az disk create \
    --resource-group $RGNAME \
    --name $DISKNAME \
    --size-gb 32 \
    --location 'francecentral' \
    --sku 'Standard_LRS' \