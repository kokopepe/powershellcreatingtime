### Event Logs and Viewing PowerShell Logs

#### Windows PowerShell 5.1
- Location: Application and Services Logs -> Windows PowerShell
- Event IDs: 400, 403, 600, 4104 (Script Block Logging)

#### PowerShell 7
- Location: Application and Services Logs -> PowerShellCore
- ETW provider GUID: {f90714a8-5509-434a-bf6d-b1624c8a19a2}
- Event ID 4104 in PowerShellCore/Operational log


## 1. PowerShell Security Overview

### Core Differences: Windows PowerShell vs PowerShell 7
- **Windows PowerShell**: Built into Windows (v5.1 is latest), uses .NET Framework
- **PowerShell 7**: Cross-platform (Windows, macOS, Linux), uses .NET Core/6+
- **Security Implications**: Different logging paths, different default settings
- **Configuration Files**: PowerShell 7 uses powershell.config.json for persistent configuration

### PowerShell 7 Specific Security Enhancements
- Improved AMSI integration for better malware detection
- More granular control over module logging
- Enhanced script block logging with more detailed information
- Group Policy support available on both versions but with different registry paths

### Execution Policy Levels
- **Restricted**: No scripts allowed (default)
- **AllSigned**: Only signed scripts by trusted publishers
- **RemoteSigned**: Local scripts run unrestricted, downloaded scripts must be signed
- **Unrestricted**: All scripts run (security risk)
- **Bypass**: No restrictions, warnings or prompts
- **Undefined**: Remove current policy, use default

### Execution Policy Management
```powershell
# Set execution policy via PowerShell (requires admin)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

# Verify current execution policy
Get-ExecutionPolicy -List
```

### Execution Policy Implementation Differences
- **Windows PowerShell**: Enforced by Windows, effective security boundary
- **PowerShell 7 on Windows**: Honors Windows execution policies
- **PowerShell 7 on Linux/macOS**: Execution policies exist but are not enforced (informational only)

```powershell
# Check execution policy on cross-platform PowerShell 7
Get-ExecutionPolicy

# On Linux/macOS this typically returns "Unrestricted" and cannot be changed
# For actual security on Linux/macOS, rely on file system permissions instead
```

## 2. PowerShell Logging Mechanisms

### PowerShell supports version-specific logging mechanisms:

#### Windows PowerShell (5.1) Logging
- Event logs stored in: `Applications and Services Logs\Windows PowerShell`
- Script Block Logging events: Event ID 4104

#### PowerShell 7 Logging
- Event logs stored in: `Applications and Services Logs\PowerShellCore\Operational`
- Different provider ID than Windows PowerShell
- Configurable via PowerShell 7 configuration files

#### 1. Module Logging
- Records pipeline execution events for specified modules
- Must be enabled for both session and specific modules
- Configuration via Group Policy or PowerShell configuration

```powershell
# Enable module logging for specific module
$psrl = Get-Module PSReadLine
$psrl.LogPipelineExecutionDetails = $true
Get-Module PSReadLine | Select-Object Name, LogPipelineExecutionDetails
```

#### 2. Script Block Logging
- Records processing of commands, scripts, functions whether interactive or automated
- Logs content of all script blocks processed
- Event ID 4104 in PowerShellCore/Operational log

### Enabling Script Block Logging

**Via Group Policy**:
- Administrative Templates -> PowerShell Core -> Turn on PowerShell Script Block Logging

**Via Registry**:
```powershell
function Enable-PSScriptBlockLogging {
    $basePath = @(
        'HKLM:\Software\Policies\Microsoft'
        'PowerShellCore\ScriptBlockLogging'
    ) -join '\'

    if (-not (Test-Path $basePath)) {
        $null = New-Item $basePath -Force
    }

    Set-ItemProperty $basePath -Name EnableScriptBlockLogging -Value "1"
}
```

**PowerShell 7 Configuration File Method**:
```powershell
# PowerShell 7 uses JSON configuration - create/edit powershell.config.json
# Location: $PSHOME/powershell.config.json 

# Sample content to enable Script Block Logging
{
  "ScriptBlockLogging": {
    "EnableScriptBlockLogging": true,
    "EnableScriptBlockInvocationLogging": true
  },
  "ModuleLogging": {
    "EnableModuleLogging": true,
    "ModuleNames": ["PSReadLine", "*"]
  }
}
```

## 3. Implementing Comprehensive PowerShell Monitoring

### Registry Paths for PowerShell Logging

#### Windows PowerShell 5.1
```powershell
# Windows PowerShell registry paths
$winPS = @{
    ScriptBlock = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging'
    Module = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging'
    Transcription = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription'
}
```

#### PowerShell 7
```powershell
# PowerShell 7 registry paths
$ps7 = @{
    ScriptBlock = 'HKLM:\SOFTWARE\Policies\Microsoft\PowerShellCore\ScriptBlockLogging'
    Module = 'HKLM:\SOFTWARE\Policies\Microsoft\PowerShellCore\ModuleLogging'
    Transcription = 'HKLM:\SOFTWARE\Policies\Microsoft\PowerShellCore\Transcription'
}
```

### PowerShell Event Log Details
| Field     | Value                    |
|-----------|--------------------------|
| EventId   | 4104 / 0x1008            |
| Channel   | Operational              |
| Level     | Verbose                  |
| Opcode    | Create                   |
| Task      | CommandStart             |
| Keyword   | Runspace                 |

### Protected Event Logging
- Protects sensitive data in logs using encryption (IETF Cryptographic Message Syntax)
- Uses public key cryptography - content encrypted with public key can only be decrypted by private key

**Enabling via Group Policy**:
- Administrative Templates -> Windows Components -> Event Logging -> Enable Protected Event Logging
- Requires encryption certificate

**Decrypting Protected Events**:
```powershell
Get-WinEvent Microsoft-Windows-PowerShell/Operational |
    Where-Object Id -EQ 4104 | Unprotect-CmsMessage
```

### Implementing a Complete Monitoring Solution
```powershell
# Check current logging configuration
$transcriptionEnabled = Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\Transcription -Name EnableTranscripting -ErrorAction SilentlyContinue
$scriptBlockLoggingEnabled = Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -Name EnableScriptBlockLogging -ErrorAction SilentlyContinue
$moduleLoggingEnabled = Get-ItemProperty HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ModuleLogging -Name EnableModuleLogging -ErrorAction SilentlyContinue

"Transcription Enabled: $($transcriptionEnabled.EnableTranscripting -eq 1)"
"ScriptBlock Logging Enabled: $($scriptBlockLoggingEnabled.EnableScriptBlockLogging -eq 1)"
"Module Logging Enabled: $($moduleLoggingEnabled.EnableModuleLogging -eq 1)"
```

### Just Enough Administration (JEA)
- Restrict administrative capabilities
- Create role capabilities defining allowed commands
- Implement session configurations for controlled access

```powershell
# Check language mode (Constrained Language is more secure)
$ExecutionContext.SessionState.LanguageMode

# Set constrained language mode
$ExecutionContext.SessionState.LanguageMode = "ConstrainedLanguage"
```

### Registering PowerShell Event Provider
```powershell
# Register event provider (required for Windows)
$PSHOME\RegisterManifest.ps1

# Unregister provider (when updating PowerShell)
$PSHOME\RegisterManifest.ps1 -Unregister
```