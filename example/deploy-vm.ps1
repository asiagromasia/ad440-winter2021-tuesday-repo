[CmdletBinding()]
param (
    [Parameter(Mandatory=$True)]
    [string]
    $SubscriptionId,

    [Parameter(Mandatory=$True)]
    [string]
    $TenantId,

    [Parameter(Mandatory=$False)]
    [string]
    $ServicePrincipalId,

    [Parameter(Mandatory=$False)]
    [SecureString]
    $ServicePrincipalPassword,

    [Parameter(Mandatory=$True)]
    [string]
    $RGName,
    
    [Parameter(Mandatory=$True)]
    [string]
    $Location,

    [Parameter(Mandatory=$True)]
    [string]
    $TempFilePath,

    [Parameter(Mandatory=$True)]
    [string]
    $ParamFilePath,

    [Parameter(Mandatory=$True)]
    [string]
    $VMName,

    [Parameter(Mandatory=$True)]
    [string]
    $VNetName,

    [Parameter(Mandatory=$True)]
    [string]
    $SubNetName,

    [Parameter(Mandatory=$True)]
    [string]
    $SGName,

    [Parameter(Mandatory=$True)]
    [string]
    $PIpAddress
    
)

#To login to azure from powershell use the following
Connect-AzAccount
#to Connect to Azure using a service principal account
    
  #  $Credential = Get-Credential
  #  Connect-AzAccount -Credential $Credential -Tenant 'xxxx-xxxx-xxxx-xxxx' -ServicePrincipal
    
  
#Display existing typed resource group
#Get-AzResourceGroup -ResourceGroupName $RGName

#create a resource group if not there
#New-AzResourceGroup -ResourceGroupName $RGName -Location $Location

  #$TempFilePath = ./automation/vm/template.json
  #$ParamFilePath =  ./automation/vm/parameters.json

New-AzResourceGroup -Name $RGName -Location $Location
#deploying VM(created all resources)
New-AzVm -ResourceGroupName $RGName -Name $VMName -Location $Location -VirtualNetworkName $VNetName -TemplateFile $TempFilePath -TemplateParameterFile $ParamFilePath -SubnetName $SubNetName -SecurityGroupName $SGName -PublicIpAddressName $PIpAddress -OpenPorts 80,3389
#with path in here
#New-AzVm -ResourceGroupName $RGName -Name $VMName -Location $Location -VirtualNetworkName $VNetName -TemplateFile ./template.json -TemplateParameterFile ./automation/vm/parameters.json -SubnetName $SubNetName -SecurityGroupName $SGName -PublicIpAddressName $PIpAddress -OpenPorts 80,3389