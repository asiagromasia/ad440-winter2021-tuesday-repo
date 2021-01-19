
nsc-aut-dev-usw2-vm-joanna -parampath /automation/parameters.json

Param(
    [Parameter(Mandatory=$True,HelpMessage='Enter the path to your csv')]
    [string]$parampath
    )
#checking that the path is correct and file is there
$testpath = Test-Path -Path $parampath
if (!$testpath){
    clear-host
    write-host -ForegroundColor Red '*** Invalid csv Path ***' -ErrorAction Stop
} else {

    #this will be local username and password for VM
    $Credential = Get-Credential

    #import the info from file "csv"
    Import-Csv -Path "$paramPath" | ForEach-Object {

    # Get the storage Acct info
    $StorageAccount = Get-AzureRmStorageAccount

    # naming convention for OS disk
    $OSDiskName = $_.'VMName' + 'OSDisk'


    #network Info
    $PublicIP = New-AzureRmPublicIpAddress -Name $_.'IntefaceName' -ResourceGroupName $_.'ResourceGroupName' - Location $_.'Location' - AllocationMethod Dynamic
    $VMNetwork = Get-AzureRmVirtualNetwork
    $Interface = New-AzureRmNetworkInterface -Name $_.'IntefaceName' -ResourceGroupName $_.'ResourceGroupName' - Location $_.'Location' -SubnetId $VMNetwork.Subnets[0].Id -PublicIpAdressIP.Id $PublicIP.Id

    # setup local vm object
    $VirtualMachine = New-AzureRmVMConfig -VMName $_.'VMName' -VMSize $_.'VMSize'
    $VirtualMachine = Set-AzureRmVMOpertingSystem -VM $VirtualMachine -Widows -ComputerName $_.'ComputerName' - Credential $Credential - ProvisionVMAgent -EnableAutoUpdate
    $VirtualMachine = Set-AzureRmVMSourceImage -VM $VirtualMachine -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2016-DataCenter -Version 'latest'
    $VirtualMachine = Add-AzureRmVMNetworkInetrface -VM $VirtualMachine -Id $Interface.Id
    $OSDiskUri = $StorageAccount.PrimaryEndpoints.Blob.ToString() + 'vhds/' + $OSDiskName + '.vhd'
    $VirtualMachine = Set-AzureRmVMOSDisk -VM $VirtualMachine -Name $OSDiskName -VhdUri $OSDiskUri -CreateOption FromImage

    #Create the VM n Azure
    New-AzureRmVM -ResourceGroupName $_.'ResourceGroupName' -'Location' -VM $VirtualMachine -Verbose
    }

}