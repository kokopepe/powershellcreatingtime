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

## 6. Error Handling

PowerShell provides a error handling mechanism using Try, Catch, and Finally blocks. 
This allows you to  handle exceptions and ensure proper resource cleanup.

```powershell
try {
    # Code that might cause an error
    $result = 10 / 0  # This will cause a division by zero error
}
catch {
    # Code to handle the error
    Write-Error "An error occurred: $_"
}
finally {
    # Code that always runs, whether there was an error or not
    Write-Output "This always executes"
}
```

- The `try` block contains code that might cause an error.
- The `catch` block handles any errors that occur in the `try` block.
- The `finally` block contains code that always runs, regardless of whether an error occurred.


## 6. Final Script

Here's our complete script that brings everything together:

# SystemInfoGatherer.ps1
```powershell
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
```

### To run this script, save it as SystemInfoGatherer.ps1 and execute it in PowerShell:
```powershell
 .\SystemInfoGatherer.ps1
```
### Or with parameters:

```powershell
.\SystemInfoGatherer.ps1 -IncludeDiskInfo -ExportToCSV -ExportToHTML
```

## Main script execution

To run this script, save it as SystemInfoGatherer.ps1 and execute it in PowerShell:

```powershell
.\SystemInfoGatherer.ps1
```

This script demonstrates the progression from basic cmdlets to advanced functions, all focused on gathering useful system information using WMI.

## 7. Fun with Speech Synthesis: Building Complexity

Let's explore PowerShell's speech synthesis capabilities, starting simple and gradually adding complexity.

### 7.1 Basic Speech Output

```powershell
function Speak-Simple {
    $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $voice.Speak("Hello, PowerShell world!")
}

Speak-Simple
```

### 7.2 Adding a Parameter

```powershell
function Speak-WithParam {
    param(
        [string]$Message
    )
    $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $voice.Speak($Message)
}

Speak-WithParam -Message "PowerShell is awesome!"
```

### 7.3 Multiple Parameters and Default Values

```powershell
function Speak-MultiParam {
    param(
        [string]$Message,
        [int]$Volume = 100
    )
    $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $voice.Volume = $Volume
    $voice.Speak($Message)
}

Speak-MultiParam -Message "Can you hear me?" -Volume 75
```

### 7.4 Parameter Validation

```powershell
function Speak-Validated {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Message,

        [ValidateRange(0,100)]
        [int]$Volume = 100
    )
    $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $voice.Volume = $Volume
    $voice.Speak($Message)
}

Speak-Validated -Message "This message is required!" -Volume 50
```

### 7.5 Advanced Function with Pipeline Support

```powershell
function Speak-Advanced {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Message,

        [ValidateSet("Male", "Female")]
        [string]$VoiceGender = "Female",

        [ValidateRange(0,100)]
        [int]$Volume = 100
    )
    
    process {
        $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
        $voiceName = $voice.GetInstalledVoices().VoiceInfo | 
                     Where-Object { $_.Gender -eq $VoiceGender } | 
                     Select-Object -ExpandProperty Name -First 1
        
        $voice.SelectVoice($voiceName)
        $voice.Volume = $Volume
        $voice.Speak($Message)
    }
}

"PowerShell is fun!", "Let's learn more!" | Speak-Advanced -VoiceGender Male -Volume 75
```

This progression demonstrates:
1. Basic function creation
2. Adding parameters
3. Using default values
4. Implementing parameter validation
5. Creating an advanced function with pipeline support

Each step builds on the previous, showcasing how to gradually increase function complexity and capability in PowerShell.
