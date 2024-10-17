# Calculated Properties in PowerShell

Calculated properties in PowerShell allow you to create custom properties on the fly when working with objects. They are especially useful when you need to manipulate or format data for display or further processing.

## Understanding Calculated Properties

A calculated property is defined using a hashtable with two key-value pairs:
- `Name`: The name you want to give to the new property
- `Expression`: A script block that defines how to calculate the property's value

The basic syntax is:

``` powershell
@{Name = "PropertyName"; Expression = { $_ / $PsItem | Some-Calculation }}
```


## Examples

### Example 1: Adding a custom property

Let's say we want to list files in a directory and add a "Size in KB" property:

``` powershell
Get-ChildItem | Select-Object Name, @{Name="SizeKB"; Expression={$_.Length / 1KB}}
```

This command will list files with their names and sizes in kilobytes.

### Example 2: Combining multiple properties

We can create a calculated property that combines existing properties:

``` powershell
Get-Process | Select-Object Name, @{Name="MemoryMB"; Expression={$_.WorkingSet / 1MB -as [int]}}
```

This command lists processes with their names and memory usage in megabytes (rounded to the nearest integer).

## Exercises

1. File Extension Counter:
   Create a calculated property that counts the number of files for each extension in a directory.

2. Uptime Calculator:
   Use `Get-CimInstance Win32_OperatingSystem` to retrieve system information and create a calculated property showing the system uptime in days.

3. Service Status Formatter:
   List services and add a calculated property that shows "Running" in green and "Stopped" in red.

## Solutions

<details>
<summary>Click to reveal solutions</summary>

1. File Extension Counter:
```powershell
Get-ChildItem | Group-Object Extension | Select-Object Name, @{Name="Count"; Expression={$_.Count}}
```

2. Uptime Calculator:
```powershell
Get-CimInstance Win32_OperatingSystem | Select-Object @{Name="UptimeDays"; Expression={($_.LastBootUpTime - (Get-Date)).Days}}
```

3. Service Status Formatter:
```powershell
Get-Service | Select-Object Name, @{Name="Status"; Expression={
    if ($_.Status -eq "Running") {
        return "`e[32mRunning`e[0m"
    } else {
        return "`e[31mStopped`e[0m"
    }
}}
```

Note: This solution uses ANSI escape codes for coloring, which may not work in all environments.

</details>

Remember to practice these examples and exercises to become more comfortable with calculated properties in PowerShell!
