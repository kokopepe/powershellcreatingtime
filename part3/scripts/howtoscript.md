# Learning PowerShell Scripting: System Information Gatherer

This guide will walk you through creating a PowerShell script to gather useful system information, starting from basic commands and building up to a full script.

## 1. Starting with a Single Cmdlet

Let's begin with a simple cmdlet to get basic system information:

```powershell
Get-ComputerInfo
```

This cmdlet provides a wealth of information about your computer. Run it and explore the output.

## 2. Filtering Information

We can use Select-Object to choose specific properties:

```powershell
Get-ComputerInfo | Select-Object WindowsProductName, OsVersion, OsArchitecture
```

This command gives us more focused information about the Windows version and architecture.

## 3. Creating a Simple Function

Let's create a function to wrap this functionality:

```powershell
function Get-BasicSystemInfo {
    Get-ComputerInfo | Select-Object WindowsProductName, OsVersion, OsArchitecture
}
```

# Use the function
Get-BasicSystemInfo

## 4. Adding More WMI Information

Now, let's expand our script to include more useful information using WMI:

```powershell
function Get-DetailedSystemInfo {
    $computerSystem = Get-WmiObject Win32_ComputerSystem
    $operatingSystem = Get-WmiObject Win32_OperatingSystem
    $processor = Get-WmiObject Win32_Processor
    $physicalMemory = Get-WmiObject Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum

    [PSCustomObject]@{
        ComputerName = $computerSystem.Name
        Manufacturer = $computerSystem.Manufacturer
        Model = $computerSystem.Model
        OperatingSystem = $operatingSystem.Caption
        OSVersion = $operatingSystem.Version
        Processor = $processor.Name
        RAM = "{0:N2} GB" -f ($physicalMemory.Sum / 1GB)
    }
}
```

# Use the function
```powershell
Get-DetailedSystemInfo
```

## 5. Creating an Advanced Function

Let's turn our function into an advanced function with parameter support:

```powershell
function Get-SystemReport {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [switch]$IncludeDiskInfo
    )

    $report = Get-DetailedSystemInfo

    if ($IncludeDiskInfo) {
        $diskInfo = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3" | 
            Select-Object DeviceID, 
                @{Name="Size(GB)";Expression={"{0:N2}" -f ($_.Size / 1GB)}},
                @{Name="FreeSpace(GB)";Expression={"{0:N2}" -f ($_.FreeSpace / 1GB)}}

        $report | Add-Member -MemberType NoteProperty -Name DiskInfo -Value $diskInfo
    }

    return $report
}
```

# Use the advanced function

```powershell
Get-SystemReport -IncludeDiskInfo
```

## 6. Final Script

Here's our complete script that brings everything together:

# SystemInfoGatherer.ps1

<#
.SYNOPSIS
Gathers detailed system information and optionally exports it to a CSV or HTML file.

.DESCRIPTION
This script collects various system information using WMI, including computer details,
operating system information, processor details, RAM, and optionally disk information.
The gathered information can be displayed on the console and/or exported to a CSV or HTML file.

.PARAMETER IncludeDiskInfo
If specified, includes disk information in the report.

.PARAMETER ExportToCSV
If specified, exports the report to a CSV file named "SystemReport.csv" in the current directory.

.PARAMETER ExportToHTML
If specified, exports the report to an HTML file named "SystemReport.html" in the current directory.

.EXAMPLE
.\SystemInfoGatherer.ps1
Runs the script with default settings, displaying system information on the console.

.EXAMPLE
.\SystemInfoGatherer.ps1 -IncludeDiskInfo -ExportToCSV -ExportToHTML
Runs the script including disk information and exports the results to both CSV and HTML files.

.NOTES
Author: Your Name
Date: Current Date
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [switch]$IncludeDiskInfo,

    [Parameter(Mandatory=$false)]
    [switch]$ExportToCSV,

    [Parameter(Mandatory=$false)]
    [switch]$ExportToHTML
)

begin {
    Write-Verbose "Starting system information gathering..."
}

process {
    try {
        # Gather basic system information
        Write-Verbose "Collecting basic system information..."
        $computerSystem = Get-WmiObject Win32_ComputerSystem
        $operatingSystem = Get-WmiObject Win32_OperatingSystem
        $processor = Get-WmiObject Win32_Processor
        $physicalMemory = Get-WmiObject Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum

        $report = [PSCustomObject]@{
            ComputerName = $computerSystem.Name
            Manufacturer = $computerSystem.Manufacturer
            Model = $computerSystem.Model
            OperatingSystem = $operatingSystem.Caption
            OSVersion = $operatingSystem.Version
            Processor = $processor.Name
            RAM = "{0:N2} GB" -f ($physicalMemory.Sum / 1GB)
        }

        # Include disk information if requested
        if ($IncludeDiskInfo) {
            Write-Verbose "Collecting disk information..."
            $diskInfo = Get-WmiObject Win32_LogicalDisk -Filter "DriveType=3" | 
                Select-Object DeviceID, 
                    @{Name="Size(GB)";Expression={"{0:N2}" -f ($_.Size / 1GB)}},
                    @{Name="FreeSpace(GB)";Expression={"{0:N2}" -f ($_.FreeSpace / 1GB)}}

            $report | Add-Member -MemberType NoteProperty -Name DiskInfo -Value $diskInfo
        }

        # Display the report
        $report | Format-List

        # Export to CSV if requested
        if ($ExportToCSV) {
            Write-Verbose "Exporting report to CSV..."
            $report | Export-Csv -Path "SystemReport.csv" -NoTypeInformation
            Write-Host "Report exported to SystemReport.csv"
        }

        # Export to HTML if requested
        if ($ExportToHTML) {
            Write-Verbose "Exporting report to HTML..."
            $htmlReport = $report | ConvertTo-Html -As List -Fragment
            $htmlBody = @"
            <h1>System Information Report</h1>
            $htmlReport
"@
            $htmlBody | ConvertTo-Html -Title "System Information Report" | Out-File "SystemReport.html"
            Write-Host "Report exported to SystemReport.html"
        }
    }
    catch {
        Write-Error "An error occurred while gathering system information: $_"
    }
}

end {
    Write-Verbose "System information gathering completed."
}

# To run this script, save it as SystemInfoGatherer.ps1 and execute it in PowerShell:
# .\SystemInfoGatherer.ps1
# Or with parameters:
# .\SystemInfoGatherer.ps1 -IncludeDiskInfo -ExportToCSV -ExportToHTML

# Main script execution
To run this script, save it as SystemInfoGatherer.ps1 and execute it in PowerShell:

.\SystemInfoGatherer.ps1

This script demonstrates the progression from basic cmdlets to advanced functions, all focused on gathering useful system information using WMI.



