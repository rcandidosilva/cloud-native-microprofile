#!/bin/sh

# Install Azure CLI
brew install azure-cli

# Login
az login

# Criar resource group
az group create -n tdc2018 -l westus


### AZURE CONTAINER INSTANCE

# Criar Docker Hub Privado
az acr create --resource-group tdc2018 --name tdchub --sku Basic --admin-enabled true

# Login Docker Hub Privado
az acr login -g tdc2018 --name tdchub

# ACR Show
az acr show --name tdchub -g tdc2018 --query loginServer
az acr show -g tdc2018 --name tdchub --query loginServer --output table

# ACR Show Images
az acr repository list --name tdchub -g tdc2018 --output table

# ACR Show Credentials for docker CLI
az acr credential show --name tdchub -g tdc2018 --query "passwords[0].value"
az acr credential show --name tdchub -g tdc2018 --query "passwords[0].value" -o plain
az acr credential show --name tdchub -g tdc2018 --query "passwords[0].value" -o tsv
az acr credential show --name tdchub -g tdc2018 --query "passwords[0].value" -o tsv > acr_password

# Create Container Instance
az container create --resource-group tdc2018 --name cloudee-duke \
   --image tdchub.azurecr.io/cloudee-duke:latest --cpu 2 --memory 1 \
   --registry-username tdchub --registry-password `cat acr_password` \
   --dns-name-label cloudee-duke --ports 8080

# Container show
az container show --resource-group tdc2018 --name cloudee-duke --query instanceView.state

# Container get IP
az container show --resource-group tdc2018 --name cloudee-duke --query ipAddress.fqdn

# Container logs
az container logs --resource-group tdc2018 --name cloudee-duke

# docker tag
docker tag <img-rodrigo> <acr>/image

# docker push
docker push <acr>/image

docker push tdchub.azurecr.io/cloudee-duke:latest
docker tag ivargrimstad/cloudee-duke:swarm tdchub.azurecr.io/cloudee-duke:latest


#### AZURE KUBERNETES SERVICE
az group create -n tdc2018east -l eastus
az aks create --resource-group tdc2018east --name tdcAKSCluster --node-count 3 --generate-ssh-keys --kubernetes-version 1.9.2


az aks get-credentials --resource-group tdc2018east --name tdc2018cluster

brew install kubernetes-helm

################
################

#!/bin/sh

# Criar resource group
az group create -n tdc2018 -l westus

name: tdc2018

# Criar container image repository
az acr create --resource-group tdc2018 --name tdchub --sku Basic --admin-enabled true

loginServer: tdchub.azurecr.io
name: tdchub

# ACR Login
az acr login -g tdc2018 --name tdchub

# ACR Get Full Name
az acr show -g tdc2018 --name tdchub --query loginServer --output table

tdchub.azurecr.io

# ACR Get Credential Password
az acr credential show --name tdchub -g tdc2018 --query "passwords[0].value" -o tsv > acr_password

# ACR Tag Image
docker tag ivargrimstad/cloudee-duke:swarm tdchub.azurecr.io/cloudee-duke:latest

# Docker Push
docker push tdchub.azurecr.io/cloudee-duke:latest

# ACR List Images
az acr repository list --name tdchub -g tdc2018 --output table

# Efetuar deployment
az container create --resource-group tdc2018 --name cloudee-duke  \
  --image tdchub.azurecr.io/cloudee-duke:latest --cpu 2 --memory 1 \
  --registry-username tdchub --registry-password `cat acr_password` \
  --dns-name-label cloudee-duke --ports 8080

# Checar status
az container show --resource-group tdc2018 --name cloudee-duke --query instanceView.state

# Get URL
az container show --resource-group tdc2018 --name cloudee-duke --query ipAddress.fqdn

# View logs
az container logs --resource-group tdc2018 --name cloudee-duke