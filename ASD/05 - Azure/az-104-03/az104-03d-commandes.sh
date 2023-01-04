RGNAME='az-104-03d-rg1'
LOCATION=$(az group show --query location --name az-104-03c-rg1 -o tsv)
DISKNAME='az-104-03d-disk1'

#creer un groupe de ressources
az group create -n $RGNAME -l $LOCATION

#update disque
az disk update \
    --resource-group $RGNAME \
    --name $DISKNAME \
    --size-gb 40

#supp toius les groupes de ressources qui commencent par
az group list --query "[?starts_with(name, 'az-104-03')].name" -o tsv | xargs -L1 bash -c 'az group delete --name $0 --no-wait --yes'