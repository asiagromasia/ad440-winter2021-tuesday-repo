[cmdletbinding()]
Param(
    [Parameter(Mandatory=$true)]
    [string]
    $RGName,
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
    $SGName,
    [Parameter(Mandatory=$true)]
    [string]
    $PIpAddress
   )
#Login into Azure
Connect-AzAccount | Out-Null
#Display existing typed resource group
Get-AzResourceGroup -ResourceGroupName $RGName
New-AzVm -ResourceGroupName $RGName -Name $VMName -Location $Location -VirtualNetworkName $VNetName -SubnetName $SubNetName -SecurityGroupName $SGName -PublicIpAddressName $PIpAddress -OpenPorts 80,3389