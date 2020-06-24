### Install Az module if not installed already
#Install-Module Az -Force
#Import-Module Az

### Connect with AzAccount if not done so
#Connect-AzAccount
#Get-AzContext

### Select your subscription
Select-AzSubscription -SubscriptionName "Your subscription id"

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force -Scope Process

#### Api-version
#((Get-AzResourceProvider -ProviderNamespace Microsoft.Web).ResourceTypes | Where-Object ResourceTypeName -eq sites).ApiVersions
#(Get-AzResourceProvider -ProviderNamespace Microsoft.Web).ResourceTypes | Format-Table
#$Provider=Get-AzResourceProvider | Format-Table 
#$Provider.ResourceTypes
#####
$resourceGroupName = "OneITTelemetry-BulkIngestion-Recovery" 

### remove resource group otherwise deployment is increamental
#Remove-AzResourceGroup $resourceGroupName -Force

New-AzResourceGroup -Name $resourceGroupName  -Location "West US" -Force 

# Deploy from Github repo or storage account SAS url
New-AzResourceGroupDeployment `
    -Name 'BIDeployment' `
    -ResourceGroupName $resourceGroupName `
    -TemplateUri 'https://raw.githubusercontent.com/jayesh-tanna/azure-arm-template/master/link-template/main.json'

### Append below parameter uri if we do not want to provide any runtime values
#-TemplateParameterUri 'https://raw.githubusercontent.com/jayesh-tanna/azure-arm-template/master/link-template/mainparameter.json'
