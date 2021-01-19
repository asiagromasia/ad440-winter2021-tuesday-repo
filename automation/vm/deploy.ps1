[cmdletbinding()]
Param(
    [Parameter(Mandatory=$True)]
    [string]
    $SubscriptionId,
    [Parameter(Mandatory=$True)]
    [string]
    $TenantId,
    [Parameter(Mandatory=$true)]
    [string]
    $ResourceGroupName,
    [Parameter(Mandatory=$true)]
    [string]
    $VMName,
    [Parameter(Mandatory=$true)]
    [string]
    $Location,
    [Parameter(Mandatory=$true)]
    [string]
    $VNetName,
    [Parameter(Mandatory=$true)]
    [string]
    $SubNetName,
    [Parameter(Mandatory=$true)]
    [string]
    $SecurityGroupName,
    [Parameter(Mandatory=$true)]
    [string]
    $PublicIpAddressName
   )
#Login into Azure
Connect-AzAccount 

#Display existing typed resource group
Get-AzResourceGroup -ResourceGroupName $ResourceGroupName

#creates new resource group if needed
#New-AzResourceGroup -Name $ResourceGroupName -Location $Location

#creates VM
New-AzVm -ResourceGroupName $ResourceGroupName -Name $VMName -Location $Location -VirtualNetworkName $VNetName -SubnetName $SubNetName -SecurityGroupName $SecurityGroupName -PublicIpAddressName $PublicIpAddressName -OpenPorts 80,3389