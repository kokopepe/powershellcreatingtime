<#
.SYNOPSIS
Gathers detailed system information and optionally exports it to a CSV file.

.DESCRIPTION
This script collects various system information using WMI, including computer details,
operating system information, processor details, RAM, and optionally disk information.
The gathered information can be displayed on the console and/or exported to a CSV file.

.PARAMETER IncludeDiskInfo
If specified, includes disk information in the report.

.PARAMETER ExportToCSV
If specified, exports the report to a CSV file named "SystemReport.csv" in the current directory.

.EXAMPLE
.\SystemInfoGatherer.ps1
Runs the script with default settings, displaying system information on the console.

.EXAMPLE
.\SystemInfoGatherer.ps1 -IncludeDiskInfo -ExportToCSV
Runs the script including disk information and exports the results to a CSV file.

.NOTES
Author: Your Name
Date: Current Date
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [switch]$IncludeDiskInfo,

    [Parameter(Mandatory=$false)]
    [switch]$ExportToCSV
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
    }
    catch {
        Write-Error "An error occurred while gathering system information: $_"
    }
}

end {
    Write-Verbose "System information gathering completed."
}
