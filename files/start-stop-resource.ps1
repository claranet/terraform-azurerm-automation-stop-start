Param(
    [Parameter(Mandatory = $true)][ValidateNotNullOrEmpty()]
    [String]
    $target_resource_id,
    [Parameter(Mandatory = $true)][ValidateSet("start", "stop")]
    [String]
    $action
)

# Ensures you do not inherit an AzContext in your runbook
Disable-AzContextAutosave -Scope Process | Out-Null

# Connect using a Managed Service Identity
try {
    $AzureContext = (Connect-AzAccount -Identity).context
}
catch {
    Write-Output "There is no system-assigned user identity. Aborting.";
    exit
}

Write-Output "Using system-assigned managed identity"

# set and store context
$AzureContext = Set-AzContext -SubscriptionName $AzureContext.Subscription -DefaultProfile $AzureContext

$resource_type       = $(Get-AzResource -ResourceId $target_resource_id).ResourceType
$resource_name       = $(Get-AzResource -ResourceId $target_resource_id).Name
$resource_group_name = $(Get-AzResource -ResourceId $target_resource_id).ResourceGroupName
$resource_sub        = ($target_resource_id -split "/")[2]

Write-Output "Resource type: $resource_type - Resource name: $resource_name in Sub $resource_sub"
Write-Output "Switching context to $resource_sub"

Set-AzContext -Subscription $resource_sub
Get-AzContext

Switch ($resource_type) {
    "Microsoft.Compute/virtualMachines" {
        Switch ($action) {
            "stop" {
                Write-Output "Stopping VM $resource_name"
                Stop-AzVM -Force -Id $target_resource_id
            }
            "start" {
                Write-Output "Starting VM $resource_name"
                Start-AzVM -Id $target_resource_id
            }
        }
    }

    "Microsoft.DBforMySQL/flexibleServers" {
        Switch ($action) {
            "stop" {
                Write-Output "Stopping MySQL Flexible $resource_name"
                Stop-AzMySqlFlexibleServer -InputObject $target_resource_id/stop
            }
            "start" {
                Write-Output "Starting MySQL Flexible $resource_name"
                Start-AzMySqlFlexibleServer -InputObject $target_resource_id/start
            }
        }
    }

    "Microsoft.DBforPostgreSQL/flexibleServers" {
        Switch ($action) {
            "stop" {
                Write-Output "Stopping PostgreSQL Flexible $resource_name"
                Stop-AzPostgreSqlFlexibleServer -InputObject $target_resource_id/stop
            }
            "start" {
                Write-Output "Starting PostgreSQL Flexible $resource_name"
                Start-AzPostgreSqlFlexibleServer -InputObject $target_resource_id/start
            }
        }
    }

    "Microsoft.ContainerService/managedClusters" {
        Switch ($action) {
            "stop" {
                Write-Output "Stopping AKS cluster $resource_name"
                Get-AzAksCluster -Id $target_resource_id | Stop-AzAksCluster
            }
            "start" {
                Write-Output "Starting AKS cluster $resource_name"
                Get-AzAksCluster -Id $target_resource_id | Start-AzAksCluster
            }
        }
    }

    "Microsoft.Web/sites" {
        Switch ($action) {
            "stop" {
                Write-Output "Stopping Web App $resource_name"
                Stop-AzWebApp -Name $resource_name -ResourceGroupName $resource_group_name -Force
            }
            "start" {
                Write-Output "Starting Web App $resource_name"
                Start-AzWebApp -Name $resource_name -ResourceGroupName $resource_group_name
            }
        }
    }

}
