# PowerShell Providers: A General Overview

## What is a PowerShell Provider?

A **PowerShell provider** is an adapter that lets you access and manage different types of data stores as if they were file systems. Providers make it easy to browse, read, and modify data in places like the file system, registry, certificate store, Active Directory, Azure, and even SQL databases.

## Common PowerShell Providers

- **FileSystem**: Access files and folders on your computer.
- **Registry**: Browse and edit the Windows Registry.
- **Certificate**: Manage certificates on your system.
- **Active Directory**: Interact with AD objects (if module installed).
- **SQLServer**: Work with SQL Server objects (with SQLServer module).
- **Azure**: Browse Azure resources (with Az module).
![Azure Provider Example](part1/registryProvider/images/azureprovider.png)

By default, PowerShell has the following registry provider:

- **Registry**: This provider helps you explore and manage registry keys and values. It exposes two main registry drives:

  - **HKLM**: Represents the `HKEY_LOCAL_MACHINE` hive, containing system-wide settings.
  - **HKCU**: Represents the `HKEY_CURRENT_USER` hive, containing user-specific settings.

You can see all available providers by running this command:

```powershell
Get-PSProvider
```

## Basic Navigation

Navigating through the registry is similar to navigating file directories. You can use commands like `cd`, `dir`, `Get-ChildItem`, and `New-Item` to interact with registry paths.

### Example 1: Navigating the Registry

```powershell
# Navigate to a registry path under HKEY_LOCAL_MACHINE (HKLM)
cd HKLM:\SOFTWARE

# List the subkeys (similar to directories)
Get-ChildItem
```

### Example 2: Creating a Registry Key

```powershell
# Navigate to HKEY_CURRENT_USER (HKCU)
cd HKCU:\Software

# Create a new key called 'MyNewApp'
New-Item -Path . -Name "MyNewApp"
```

### Example 3: Setting a Registry Value

```powershell
# Set a new value for the 'Version' entry under 'MyNewApp'
Set-ItemProperty -Path "HKCU:\Software\MyNewApp" -Name "Version" -Value "2.0"
```

### Example 4: Deleting a Registry Key

```powershell
# Example for working with expired certificates
Get-ChildItem Cert:\CurrentUser\my -Recurse | where-object {$_.NotAfter -lt (Get-Date)} | Select-Object Subject, thumbprint
```

### Example 5: Find Certificates Expiring in the Next 3 Months

```powershell
# Get the current date and the date 3 months from now
$today = Get-Date
$futureDate = $today.AddMonths(3)

# Search user and local machine certificate stores for expiring certs
$certsExpiringSoon = Get-ChildItem -Path Cert:\LocalMachine\my, Cert:\CurrentUser\my -Recurse |
    Where-Object { $_.NotAfter -lt $futureDate } |
    Select-Object Subject, NotAfter, Thumbprint, PSParentPath

# Display the results
$certsExpiringSoon
```

#### 🔍 What It Does

- `Get-Date` and `AddMonths(3)`: Sets the current and future date range.
- `Cert:\LocalMachine\my`, `Cert:\CurrentUser\my`: Accesses certs from both machine and user stores.
- `-Recurse`: Searches through subfolders (stores like Personal, Trusted Root, etc.).
- `Where-Object`: Filters only certificates that expire within 3 months.
- `Select-Object`: Outputs useful properties such as:
  - `Subject`: Who the cert is for
  - `NotAfter`: Expiration date
  - `Thumbprint`: Unique hash
  - `PSParentPath`: Location in cert store

#### 📝 Optional: Export to CSV

```powershell
$certsExpiringSoon | Export-Csv -Path "C:\Temp\ExpiringCerts.csv" -NoTypeInformation
```

This creates a report you can review or send to a team.


## Conclusion


PowerShell providers make it easy to work with a variety of data stores using familiar commands. Try exploring different providers with `Get-PSProvider` and see what you can manage from the shell!