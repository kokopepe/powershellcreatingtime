# PowerShell Cmdlets 101: Diving into Cmdlets 


## Cmdlets: The Building Blocks of PowerShell

Cmdlets are the fundamental building blocks of PowerShell. 
As we mentioned in previos exercise. Building Bricks. 
Let's see how we can use them.

## Characteristics:

### 1. **Verb-Noun Naming**: 

Cmdlets follow a Verb-Noun naming convention (e.g., `Get-Service`, `Stop-Process`), making them intuitive and predictable.

- PowerShell has a standardized list of approved verbs.
- You can view this list using the `Get-Verb` cmdlet.
```powershell
Get-Verb
```
- There are no synonyms in verb usage. For example, it's always "Stop", never "Terminate" or "End".
- Verbs give you a clue about a cmdlet's action:
  - `Get-` cmdlets retrieve information without modifying system settings.
  - `Set-` cmdlets can change settings.

This standardization helps you predict cmdlet names and understand their functions.

### 2. **Parameters**: 
Cmdlets accept parameters to modify their behavior or specify what information you want. For example:

```powershell
# Get all services
Get-Service

# Get a specific service by name
Get-Service -Name "WinRM"

# Stop a specific service by name
Stop-Service -Name "WinRM"

# Change the startup type of a service
Set-Service -Name "WinRM" -StartupType Automatic
```


### 3. **Working Together**: 
Cmdlets are designed to work together, allowing you to build complex operations from simple commands. 
While we'll explore this in depth later, here's a glimpse:
Pipelining is the process of passing the output of one cmdlet as the input to another cmdlet.

```powershell
Get-Service -Name "WinRM" | Stop-Service
Get-Service -Name "WinRM" | Set-Service -StartupType Disabled
```

This command gets all services, filters for running ones, and selects specific properties to display.

As you progress, we will learn how to combine these building blocks to create powerful scripts and automate complex tasks.

> Note: The `*` wildcard can be used with some parameters to match multiple items. For instance, `"Win*"` matches all services that start with "Win".


## Aliases

Aliases in PowerShell are shortcuts or alternate names for cmdlets. 
They allow for quicker typing and can make command-line operations more efficient.

Some common aliases include are well known to keep dos/linux experience:
- `ls` or `dir` for `Get-ChildItem`
- `cd` for `Set-Location`
- `cls` for `Clear-Host`

You can view all aliases using the `Get-Alias` cmdlet.

### Quick Exercise:

Try to find out what `?` and `%` mean in PowerShell. These are aliases for commonly used cmdlets in pipelines.

Hint: Use `Get-Alias ?` and `Get-Alias %` to discover their meanings.

While aliases are great for interactive use, it's generally recommended to use full cmdlet names in scripts for better readability and maintainability.


In future lessons, we'll explore essential PowerShell discovery commands like Get-Help, Get-Command, and Get-Member. These will help you understand cmdlet parameters, find relevant commands, and explore object properties, enhancing your ability to construct effective PowerShell commands and pipelines.


## Exercise 1: Finding Firewall-related Cmdlets

Imagine we need to find something related to Firewalls. Let's use `Get-Command` to help us:

1. We know it should start with `Get-`
2. The second part might contain "Firewall" or "FW"
3. It's likely a built-in Windows command


## Exercise 2: Discovering the Show-Command Cmdlet

There's a command that allows us to see a graphical interface for all the parameters needed for a cmdlet.

We know:
- It's related to commands
- It displays a graphic interface

Try to find this cmdlet using `Get-Command`.

## Additional Notes

- `Get-Command *` shows all commands, including non-native ones.
- PowerShell's consistent syntax makes it easier to find commands for unfamiliar products that support PowerShell cmdlets.



## Unified PowerShell Approach 

Azure
```powershell
Get-AzADUser | selectc displayname,UserPrincipalName,@{n="CreatedTime";e={$_.ExtensionProperty.createdDateTime }} | export-csv –notypeinformation .\Report.csv
```
Active Directory
```powershell
Get-ADUser -filter * -Properties whenCreated | Select-Object Name,whenCreated | export-csv –notypeinformation .\report.csv
```
AWS
```powershell
Get-IAMUserList | select-Object username,createDate | export-csv –notypeinformation ReportUsers.csv
```
In PowerShell, the commands shown in the image demonstrate that, regardless of the system (whether it is Active Directory, Azure, or AWS), the approach is similar. These are the key common actions:

This shows that once you understand the basic process in PowerShell, you can easily adapt the commands to work with different systems and services. The technology may change, but the core principles remain the same.

While the systems (Azure AD, traditional AD, and AWS IAM) are different, the general flow is the same:

- Retrieving Users: In all three cases, you are fetching a list of users. Whether using Get-azureaduser, Get-ADUser, or Get-IAMUserList, the first step is to gather the user data from the system.

- Selecting Specific Properties: The next common action is selecting specific properties of the users that are relevant to your task. In the commands, you are selecting usernames, the time when the user was created, or other important fields, using Select-Object.

- Exporting the Data: Once the data is gathered and formatted, the final step is exporting it, typically into a CSV file. This is done using export-csv in each of the commands.



