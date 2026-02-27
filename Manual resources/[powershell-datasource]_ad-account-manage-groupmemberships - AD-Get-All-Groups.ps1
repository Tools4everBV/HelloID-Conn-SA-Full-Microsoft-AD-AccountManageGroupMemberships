# Use Name -like '*' to query all groups
$filter = "Name -like '*'"

# Global variables
$searchOUs = $AdGroupsSearchOU

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
    $actionMessage = "querying AD group(s) matching the filter [$filter] in OU(s) [$($searchOUs)]"

    $ous = $searchOUs -split ';'
    $adGroups = [System.Collections.ArrayList]@()
    foreach ($ou in $ous) {
        $actionMessage = "querying AD group(s) matching the filter [$filter] in OU [$($ou)]"
        $getAdGroupsSplatParams = @{
            Filter      = $filter
            Searchbase  = $ou
            Properties  = $propertiesToSelect
            Verbose     = $False
            ErrorAction = "Stop"
        }
        $getAdGroupsResponse = Get-AdGroup @getAdGroupsSplatParams | Select-Object -Property $propertiesToSelect

        if ($getAdGroupsResponse -is [array]) {
            [void]$adGroups.AddRange($getAdGroupsResponse)
        }
        else {
            [void]$adGroups.Add($getAdGroupsResponse)
        }
    }
    # Filter out Domain users
    $adGroups = $adGroups | Where-Object { $_.Name -ne "Domain Users" }
    Write-Information "Queried AD group(s) matching the filter [$filter] in OU(s) [$($searchOUs)]. Result count: $(($adGroups | Measure-Object).Count)"

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
