# following creates resource group
#New-AzResourceGroup -Name demoResourceGroup -Location westus2
New-AzResourceGroup -Name nsc-rg-dev-usw2-team3 -Location westus2

# to choose existingresource group
$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"

Get-AzResourceGroup -Name $resourceGroupName

#to deploy to subscription
#New-AzSubscriptionDeployment -Location <location> -TemplateFile <path-to-template>

#to deploy to a resource group, following example deploys a template to create a resource group
New-AzResourceGroupDeployment `
  -Name demoRGDeployment `
  -ResourceGroupName nsc-rg-dev-usw2-team3 `
  -TemplateUri https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-storage-account-create/azuredeploy.json `
  -storageAccountType Standard_GRS `

 #to deploy to a resource group
 #New-AzResourceGroupDeployment -ResourceGroupName <resource-group-name> -TemplateFile <path-to-template> 
 #New-AzResourceGroupDeployment -ResourceGroupName <resource-group-name> -VMTemplate /automation/vmtemplate.json

 #to deploy a local template with set parameter value that comes from template
 New-AzResourceGroupDeployment `
  -Name ExampleDeployment `
  -ResourceGroupName ExampleGroup `
  -TemplateFile c:\MyTemplates\azuredeploy.json


#to export all resources in a resource group
$resourceGroupName = Read-Host -Prompt "Enter the Resource Group name"

Export-AzResourceGroup -ResourceGroupName $resourceGroupName