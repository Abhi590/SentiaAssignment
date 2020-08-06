
[cmdletbinding()]
Param(
    [Parameter(Mandatory = $true)]
    [string] $WebAppName
)

$StagingSlotName = "staging"

$a = Get-AzWebApp -Name $WebAppName
$plan = $a.ServerFarmId.Split('/')[-1]

# remove old staging slot
Remove-AzureRMWebAppSlot -ResourceGroupName $a.ResourceGroup -Name $a.Name -Slot $StagingSlotName -Force

# create new staging slot by copying production
New-AzureRMWebAppSlot -ResourceGroupName $a.ResourceGroup -Name $a.Name -AppServicePlan $plan -Slot $StagingSlotName -SourceWebApp $a
