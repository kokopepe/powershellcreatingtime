# 1. PowerShell Variables and Data Types

## Introduction to Variables

In PowerShell, variables are containers that store data. They're essential for:
- Storing configuration values
- Holding command results
- Managing state in scripts
- Passing data between commands

To declare a variable, use the `$` symbol followed by the variable name:
```powershell
$name = "value"  # Basic variable declaration
$result = Get-Process  # Storing command output
$count = 42  # Storing a number
```

## PowerShell Logging

PowerShell logs are stored in different locations depending on the logging type:

1. **Event Viewer**:
   - Open Event Viewer
   - Navigate to: Windows Logs > PowerShell
   - Contains: Script block logging and module logging

2. **Transcription Logs**:
   - Default location: `%USERPROFILE%\Documents\PowerShell_transcripts`
   - Contains: All PowerShell commands and output

To check logging status:
```powershell
# Check current logging configuration
$transcriptionEnabled = Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\Transcription -Name EnableTranscripting -ErrorAction SilentlyContinue
$scriptBlockLoggingEnabled = Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -Name EnableScriptBlockLogging -ErrorAction SilentlyContinue
$moduleLoggingEnabled = Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ModuleLogging -Name EnableModuleLogging -ErrorAction SilentlyContinue

"Transcription Enabled: $($transcriptionEnabled.EnableTranscripting -eq 1)"
"ScriptBlock Logging Enabled: $($scriptBlockLoggingEnabled.EnableScriptBlockLogging -eq 1)"
"Module Logging Enabled: $($moduleLoggingEnabled.EnableModuleLogging -eq 1)"
```

### Basic Variable Types

1. **Strings**: Text values
   ```powershell
   $policyName = "PasswordPolicy"
   ```

2. **Integers**: Whole numbers
   ```powershell
   $portNumber = 443
   ```

3. **Booleans**: True or false values
   ```powershell
   $isFirewallEnabled = $true
   ```

4. **Hashtables**: Key-value pairs
   ```powershell
   $backupConfig = @{
       "JobName" = "DailyBackup"
       "Schedule" = "Daily"
   }
   ```

## String and Number Operations

```powershell
# String concatenation (preferred method)
$deviceName = "Switch01"
$message = "Device $deviceName is Up"

# Number operations
$port1 = 6
$port2 = "6"
$sum = $port1 + [int]$port2  # Converts string to number: 12
```

## Quick Exercises (5 minutes)

### Exercise 1: Variables
Create variables for a backup job:
- Job name: "CriticalBackup"
- Retention period: 30 days
- Compression enabled: true

### Exercise 2: String Operations
Create a status message for a network device:
- Device name: "Switch01"
- Port: 80
- Status: "Active"

### Questions:
1. What's the difference between `$true` and `"true"`?
2. What's the difference between `6` and `"6"`?
3. When would you use a hashtable?

### Answers:
1. `$true` is a boolean value, while `"true"` is a string.
2. `6` is an integer for calculations, while `"6"` is a string. Use `[int]"6"` to convert.
3. Use hashtables to group related data, like configuration settings.

# PSCustomObject in PowerShell

<p align="center">
  <img src="part2/variableslogic101/images/swiss.png" alt="Future of AI" width="400">
</p>

PSCustomObject is a powerful and flexible way to create custom objects in PowerShell. It's particularly useful for creating structured data for security, backup, and network management tasks.

## How to Use PSCustomObject

### Security Example:
```powershell
$securityAudit = [PSCustomObject]@{
    ComputerName = $env:COMPUTERNAME
    LastAuditDate = (Get-Date)
    SecurityUpdates = @{
        Installed = 150
        Pending = 5
        Failed = 2
    }
    FirewallStatus = "Enabled"
    AntivirusStatus = "Active"
}
```

### Backup Example:
```powershell
$backupStatus = [PSCustomObject]@{
    JobName = "DailyBackup"
    LastRunTime = (Get-Date).AddHours(-12)
    Status = "Completed"
    FilesBackedUp = 1500
    TotalSize = "2.5GB"
    Duration = "45 minutes"
}
```

### Network Example:
```powershell
$networkDevice = [PSCustomObject]@{
    DeviceName = "Switch01"
    IPAddress = "192.168.1.1"
    Model = "Cisco Catalyst 2960"
    Uptime = "45 days"
    InterfaceStatus = @{
        "GigabitEthernet0/1" = "Up"
        "GigabitEthernet0/2" = "Down"
    }
}
```

## Advantages of PSCustomObject

1. **Pipeline compatibility**: PSCustomObjects work seamlessly with PowerShell's pipeline operations, making it easy to process security logs, backup reports, or network device information.

2. **Flexibility**: You can easily add, remove, or modify properties of a PSCustomObject, which is useful when dealing with changing security requirements or network configurations.

3. **Easy conversion**: You can easily convert PSCustomObjects to and from other data formats like JSON or CSV, which is essential for:
   - Exporting security audit reports
   - Creating backup job configurations
   - Storing network device inventories

Compared to other object types in PowerShell, PSCustomObject offers a balance of simplicity, flexibility, and performance, making it an excellent choice for IT automation scenarios.

## Building Request Bodies for API Calls

When working with APIs in PowerShell, you'll often need to build request bodies for POST, PUT, or PATCH requests. Here are practical examples for security, backup, and network scenarios:

### Security API Example
```powershell
# Building a request body for a security policy update
$securityPolicyBody = @{
    policyName = "EndpointProtection"
    enabled = $true
    settings = @{
        antivirusEnabled = $true
        firewallEnabled = $true
        realTimeProtection = $true
        scanSchedule = "Daily"
        scanTime = "02:00"
    }
    exclusions = @(
        "C:\Program Files\CustomApp",
        "C:\Data\Reports"
    )
} | ConvertTo-Json -Depth 10

# Making the API call
$response = Invoke-RestMethod -Uri "https://api.security.example.com/policies" `
    -Method Post `
    -Body $securityPolicyBody `
    -ContentType "application/json" `
    -Headers @{
        "Authorization" = "Bearer $token"
    }
```

### Backup API Example
```powershell
# Building a request body for a backup job
$backupJobBody = @{
    jobName = "CriticalDataBackup"
    schedule = @{
        frequency = "Daily"
        startTime = "23:00"
        retentionDays = 30
    }
    source = @{
        path = "C:\CriticalData"
        includePatterns = @("*.doc", "*.xlsx", "*.pdf")
        excludePatterns = @("*.tmp", "*.temp")
    }
    destination = @{
        type = "NetworkShare"
        path = "\\BackupServer\Backups"
        credentials = @{
            username = "backupuser"
            domain = "CORP"
        }
    }
    options = @{
        compression = $true
        encryption = $true
        verifyBackup = $true
    }
} | ConvertTo-Json -Depth 10

# Making the API call
$response = Invoke-RestMethod -Uri "https://api.backup.example.com/jobs" `
    -Method Post `
    -Body $backupJobBody `
    -ContentType "application/json" `
    -Headers @{
        "Authorization" = "Bearer $token"
    }
```

### Network API Example
```powershell
# Building a request body for a network device configuration
$networkConfigBody = @{
    deviceId = "SWITCH-001"
    hostname = "CoreSwitch01"
    interfaces = @(
        @{
            name = "GigabitEthernet0/1"
            enabled = $true
            vlan = 10
            description = "Server Farm"
            speed = 1000
            duplex = "Full"
        },
        @{
            name = "GigabitEthernet0/2"
            enabled = $true
            vlan = 20
            description = "User Network"
            speed = 1000
            duplex = "Full"
        }
    )
    management = @{
        ipAddress = "192.168.1.1"
        subnetMask = "255.255.255.0"
        defaultGateway = "192.168.1.254"
        snmpEnabled = $true
        snmpCommunity = "private"
    }
} | ConvertTo-Json -Depth 10

# Making the API call
$response = Invoke-RestMethod -Uri "https://api.network.example.com/devices" `
    -Method Post `
    -Body $networkConfigBody `
    -ContentType "application/json" `
    -Headers @{
        "Authorization" = "Bearer $token"
    }
```

## Common Variable Types in IT Automation

### Boolean Variables
```powershell
# Security
$isFirewallEnabled = $true
$isAntivirusActive = $true
$isUserLocked = $false
$isPasswordExpired = $false

# Backup
$isBackupRunning = $true
$isCompressionEnabled = $true
$isVerificationRequired = $true
$isIncrementalBackup = $false

# Network
$isInterfaceUp = $true
$isPortSecure = $true
$isVLANEnabled = $true
$isTrunkPort = $false

# Using boolean variables in conditions
if ($isFirewallEnabled -and $isAntivirusActive) {
    Write-Host "Security features are properly configured"
}
```

### Integer Variables
```powershell
# Security
$maxLoginAttempts = 3
$passwordLength = 12
$sessionTimeout = 30
$portNumber = 443

# Backup
$retentionDays = 90
$backupInterval = 24
$compressionLevel = 9
$maxConcurrentJobs = 5

# Network
$vlanId = 100
$mtuSize = 1500
$bandwidthLimit = 1000
$portNumber = 22

# Using integer variables in calculations
$totalStorageGB = $backupSizeMB / 1024
$remainingAttempts = $maxLoginAttempts - $currentAttempts
```

### String Variables
```powershell
# Security
$policyName = "PasswordPolicy"
$userRole = "Administrator"
$securityGroup = "Domain Admins"
$certificateThumbprint = "a1b2c3d4e5f6g7h8i9j0"

# Backup
$backupPath = "\\BackupServer\Backups"
$jobName = "DailyBackup"
$filePattern = "*.doc,*.xlsx,*.pdf"
$logPath = "C:\Logs\Backup"

# Network
$interfaceName = "GigabitEthernet0/1"
$deviceModel = "Cisco Catalyst 2960"
$ipAddress = "192.168.1.1"
$subnetMask = "255.255.255.0"

# String manipulation examples
$fullPath = Join-Path $backupPath $jobName
$interfaceStatus = "$interfaceName is $($isInterfaceUp ? 'Up' : 'Down')"
$securityMessage = "User $userRole attempted to access $policyName"
```



### Questions:
1. What's the difference between `$true` and `"true"`?
2. What's the difference between `6` and `"6"`?
3. When would you use a hashtable?

### Answers:
1. `$true` is a boolean value, while `"true"` is a string.
2. `6` is an integer for calculations, while `"6"` is a string. Use `[int]"6"` to convert.
3. Use hashtables to group related data, like configuration settings.

