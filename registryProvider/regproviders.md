
# PowerShell Registry Provider

## Overview

In PowerShell, providers allow access to various data stores, such as the file system, certificate store, or the **Windows Registry**. The **Registry Provider** is a built-in provider that enables you to navigate and modify the Windows Registry, treating it like a file system.

## Default Registry Providers

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

``` powershell
Get-ChildItem Cert:\CurrentUser\my -Recurse |where-object {$_.NotAfter -lt (Get-Date)} |Select-Object Subject,thumbprint
```

## Conclusion

The PowerShell **Registry Provider** allows you to manage Windows Registry keys and values easily from the command line. You can navigate registry hives, create new keys, set values, and even delete them, all with simple PowerShell commands.

For more advanced registry management, check out additional cmdlets like `Get-Item`, `Set-Item`, and `Clear-ItemProperty`.

