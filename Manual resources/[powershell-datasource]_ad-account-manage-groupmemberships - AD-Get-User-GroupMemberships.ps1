# Variables configured in form
$user = $datasource.selectedUser

# Fixed values
$propertiesToSelect = @(
    "ObjectGuid",
    "SamAccountName",
    "Name",
    "Description",
    "Mail"
) # Properties to select from Microsoft AD, comma separated

# Set debug logging
$VerbosePreference = "SilentlyContinue"
$InformationPreference = "Continue"
$WarningPreference = "Continue"

try {
    $actionMessage = "querying AD groupmembership(s) for user [$($user.SamAccountName)]"
    
    # Get all AD groups the user is a member of
    $getAdGroupsMembershipSplatParams = @{
        Identity    = $user.ObjectGuid
        ErrorAction = "Stop"
    }
    $adGroups = Get-ADPrincipalGroupMembership @getAdGroupsMembershipSplatParams | Select-Object $propertiesToSelect 
    # Filter out Domain users
    $adGroups = $adGroups | Where-Object { $_.Name -ne "Domain Users" }

    Write-Information "Queried AD groupmembership(s) for user [$($user.SamAccountName)]. Result count: $(@($adGroups).Count)"

    # Sort and Send results to HelloID
    $actionMessage = "sending results to HelloID"
    $adGroups | Sort-Object -Property Name | ForEach-Object {
        Write-Output $_
    } 
}
catch {
    $ex = $PSItem
    Write-Warning "Error at Line [$($ex.InvocationInfo.ScriptLineNumber)]: $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"
    Write-Error "Error $($actionMessage). Error: $($ex.Exception.Message)"
    # exit # use when using multiple try/catch and the script must stop
}
