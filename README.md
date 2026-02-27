# HelloID-Conn-SA-Full-AD-AccountManageGroupMemberships

| :information_source: Information |
|:---|
| This repository contains the connector and configuration code only. The implementer is responsible for acquiring the connection details such as username, password, certificate, etc. You might even need to sign a contract or agreement with the supplier before implementing this connector. Please contact the client's application manager to coordinate the connector requirements. |

## Description

_HelloID-Conn-SA-Full-AD-AccountManageGroupMemberships_ is a delegated form designed for use with HelloID Service Automation (SA). It can be imported into HelloID and customized according to your requirements.

By using this delegated form, you can manage Active Directory user account group memberships. The following options are available:

1. Search for and select the target Active Directory (AD) user account by Name, DisplayName, User Principal Name (UPN), or Mail address.
2. View basic AD user account attributes (ObjectGuid, SamAccountName, DisplayName, UserPrincipalName, Enabled status, Description, Company, Department, and Title).
3. View all available AD groups (from specified OUs) and the current group memberships of the selected user account.
4. Add or remove group memberships for the selected user account with comprehensive audit logging.

## Getting started

### Requirements

• **Active Directory Access**:
  The connector requires access to an Active Directory domain with sufficient permissions to add and remove group memberships. A service account with appropriate AD permissions is necessary.

• **HelloID Agent**:
  A HelloID Agent must be installed and configured to communicate with the Active Directory domain.

• **PowerShell module 'ActiveDirectory'**:
  The HelloID Agent must have PowerShell available with Active Directory module support.

### Connection settings

The following user-defined variables are used by the connector.

| Setting | Description | Mandatory |
|---------|-------------|-----------|
| ADusersSearchOU | Array of Active Directory OUs for scoping AD user accounts in the search result of this form | Yes |
| ADgroupsSearchOU | Array of Active Directory OUs for scoping AD groups available in this form | Yes |

## Remarks

### User Search

• **Search Functionality:** Users can search for accounts using a wildcard (`*`) to return all users within the specified OUs, or by entering partial text to search across user attributes (Name, DisplayName, User Principal Name, or Mail address).

• **The search scope is limited to the OUs defined in the `ADusersSearchOU` variable.**

### Group Search

• **Search Functionality:** Groups are retrieved from the Active Directory OUs specified in the `ADgroupsSearchOU` variable.

• **The Domain Users group is automatically filtered out from the available groups list.**

## Development resources

### PowerShell Module
This connector uses the ActiveDirectory PowerShell module for managing Active Directory groups and user accounts.

- [ActiveDirectory Module Documentation](https://learn.microsoft.com/en-us/powershell/module/activedirectory/)

### Cmdlets
The following PowerShell cmdlets are used by the connector:

| Cmdlet | Description |
| --- | --- |
| Get-ADGroup | Retrieves Active Directory groups |
| Get-ADUser | Retrieves Active Directory user accounts |
| Get-ADPrincipalGroupMembership | Retrieves group memberships for a user or group |
| Add-ADGroupMember | Adds one or more users to an Active Directory group |
| Remove-ADGroupMember | Removes one or more users from an Active Directory group |

### Cmdlet documentation
- [Get-ADGroup](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-adgroup)
- [Get-ADUser](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-aduser)
- [Get-ADPrincipalGroupMembership](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-adprincipalgroupmembership)
- [Add-ADGroupMember](https://learn.microsoft.com/en-us/powershell/module/activedirectory/add-adgroupmember)
- [Remove-ADGroupMember](https://learn.microsoft.com/en-us/powershell/module/activedirectory/remove-adgroupmember)

## Getting help

> 💡 **Tip:**
> For more information on Delegated Forms, please refer to our [documentation](https://docs.helloid.com/en/service-automation/delegated-forms.html) pages.

## HelloID docs

The official HelloID documentation can be found at: [https://docs.helloid.com/](https://docs.helloid.com/)
