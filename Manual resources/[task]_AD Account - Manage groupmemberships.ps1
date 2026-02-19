$VerbosePreference = "SilentlyContinue"
$InformationPreference = "Continue"
$WarningPreference = "Continue"

# variables configured in form
$user = $form.gridUsers
$groupsToAdd = $form.memberships.leftToRight
$groupsToRemove = $form.memberships.RightToLeft

foreach($groupToAdd in $groupsToAdd){
    try{
        # Add member to group
        # https://learn.microsoft.com/en-us/powershell/module/activedirectory/add-adgroupmember
        $actionMessage = "adding user with displayName [$($user.displayName)] and objectGuid [$($user.objectGuid)] as member to group with name [$($groupToAdd.Name)] and objectGuid [$($groupToAdd.objectGuid)]"

        $addGroupMemberSplatParams = @{
            Identity    = $groupToAdd.ObjectGuid
            Members     = $user.ObjectGuid
            Verbose     = $false
            ErrorAction = "Stop"
        }
        Add-ADGroupMember @addGroupMemberSplatParams

        # Send auditlog to HelloID
        $Log = @{
            Action            = "GrantMembership" # optional. ENUM (undefined = default) 
            System            = "ActiveDirectory" # optional (free format text) 
            Message           = "Added user with displayName [$($user.displayName)] and objectGuid [$($user.objectGuid)] as member to group with name [$($groupToAdd.Name)] and objectGuid [$($groupToAdd.objectGuid)]." # required (free format text) 
            IsError           = $false # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
            TargetDisplayName = $groupToAdd.Name # optional (free format text) 
            TargetIdentifier  = $groupToAdd.ObjectGuid # optional (free format text) 
        }
        Write-Information -Tags "Audit" -MessageData $log
    } catch {
        $ex = $PSItem
        $auditMessage = "Error $($actionMessage). Error: $($ex.Exception.Message)"
        $warningMessage = "Error at Line [$($ex.InvocationInfo.ScriptLineNumber)]: $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"
        $log = @{
                Action            = "GrantMembership" # optional. ENUM (undefined = default) 
                System            = "ActiveDirectory" # optional (free format text) 
                Message           = $auditMessage # required (free format text) 
                IsError           = $true # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
                TargetDisplayName = $groupToAdd.Name # optional (free format text) 
                TargetIdentifier  = $groupToAdd.ObjectGuid # optional (free format text) 
            }
        Write-Information -Tags "Audit" -MessageData $log
        Write-Warning $warningMessage   
        Write-Error $auditMessage
    }
}

foreach($groupToRemove in $groupsToRemove){
    try{
        # Remove member from group
        # https://learn.microsoft.com/en-us/powershell/module/activedirectory/remove-adgroupmember
        $actionMessage = "removing user with displayName [$($user.displayName)] and objectGuid [$($user.objectGuid)] as member from group with name [$($groupToRemove.Name)] and objectGuid [$($groupToRemove.objectGuid)]"
        
        $removeGroupMemberSplatParams = @{
            Identity    = $groupToRemove.ObjectGuid
            Members     = $user.ObjectGuid
            Confirm     = $false
            ErrorAction = "Stop"
        }
        Remove-ADGroupMember @removeGroupMemberSplatParams

        # Send auditlog to HelloID
        $Log = @{
            Action            = "RevokeMembership" # optional. ENUM (undefined = default) 
            System            = "ActiveDirectory" # optional (free format text) 
            Message           = "Removed user with displayName [$($user.displayName)] and objectGuid [$($user.objectGuid)] as member from group with name [$($groupToRemove.Name)] and objectGuid [$($groupToRemove.objectGuid)]." # required (free format text) 
            IsError           = $false # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
            TargetDisplayName = $groupToRemove.Name # optional (free format text) 
            TargetIdentifier  = $groupToRemove.ObjectGuid # optional (free format text) 
        }
        Write-Information -Tags "Audit" -MessageData $log
    } catch {
        $ex = $PSItem
        $auditMessage = "Error $($actionMessage). Error: $($ex.Exception.Message)"
        $warningMessage = "Error at Line [$($ex.InvocationInfo.ScriptLineNumber)]: $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"
        $log = @{
            Action            = "RevokeMembership" # optional. ENUM (undefined = default) 
            System            = "ActiveDirectory" # optional (free format text) 
            Message           = $auditMessage # required (free format text) 
            IsError           = $true # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
            TargetDisplayName = $groupToRemove.Name # optional (free format text) 
            TargetIdentifier  = $groupToRemove.ObjectGuid # optional (free format text) 
        }
        Write-Information -Tags "Audit" -MessageData $log
        Write-Warning $warningMessage   
        Write-Error $auditMessage
    }
}
