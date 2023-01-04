Install-WindowsFeature -name RemoteAccess -IncludeManagementTools
Install-WindowsFeature -name Routing -IncludeManagementTools -IncludeAllSubFeature
Install-RemoteAccess -VpnType routingonly
Get-netadapter | set-netipinterface -forwarding enabled