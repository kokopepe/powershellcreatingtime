# PowerShell 101

This set of exercises will guide you through identifying PowerShell versions, installing PowerShell 7.x, and setting up Visual Studio Code.




## Exercise 1: Identify the Default Windows PowerShell Version


### PowerShell 5.1 Overview

| Characteristic | Description |
|----------------|-------------|
| Framework      | Built on the .NET Framework (Windows-only) |
| Executable     | Runs using the powershell.exe executable |
| Availability   | Installed by default on all Windows operating systems |
| Version        | Final version: 5.1 |
| Support        | Still actively updated for stability and security fixes |



In this exercise, we will learn how to access and identify the version of PowerShell installed on your system using a built-in variable.

1. Open PowerShell.
2. Type the following command to view the version details:

   ```powershell
   $PSVersionTable
   ```

   - **Explanation**: `$PSVersionTable` is a built-in variable in PowerShell that displays version information, including the major and minor versions.

3. Note down the `PSVersion` value. This indicates your current PowerShell version.

### To Remember

Powershell.exe is installed by default on all Windows operating systems. So you can access it by typing `powershell` in any system. 


## Exercise 2: Install PowerShell 7.x

| Characteristic | Description                                         |
|----------------|-----------------------------------------------------|
| Framework      | Built on .NET Core (cross-platform)                 |
| Executable     | Runs using the pwsh executable                      |
| Availability   | Downloadable for Windows, macOS, and Linux          |
| Version        | Actively developed, with frequent updates           |
| Support        | Fully supported and maintained by Microsoft         |

Next, we’ll download and install PowerShell 7.x to use the latest cross-platform version.

1. Go to the [PowerShell 7.x Download Page](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4).
2. Select the appropriate installer for your operating system (Windows, macOS, or Linux).
3. Install PowerShell 7.x following the instructions provided on the download page.
4. Once installed, open the `pwsh` application (new executable for PowerShell 7.x).
5. Run `$PSVersionTable` again to confirm that PowerShell 7.x is installed.

### To Remember

Powershell 7.x is a cross-platform version of PowerShell that is compatible with Windows, macOS, and Linux. It is the one currently been developed and maintained by Microsoft.



## PowerShell Execution Policy

PowerShell execution policy is a safety feature that controls the conditions under which PowerShell loads configuration files and runs scripts. It's important to understand this concept when working with PowerShell scripts.

### Key Points:

1. **Purpose**: To prevent the unintentional execution of malicious scripts.
2. **Scope**: Can be set for the local computer, current user, or a specific PowerShell session.
3. **Default Settings**:
   - Windows Server (2016, 2019, 2022): RemoteSigned
   - Windows 10 and 11: Restricted

### Checking Execution Policy:

To check your current execution policy, run:

```powershell
Get-ExecutionPolicy
```

### Important Note:

While execution policy helps prevent unintentional script execution, it's not a security boundary. Determined users can bypass it. Always exercise caution when running scripts from untrusted sources.

### Execution Policy Scopes and Meanings:

| Scope | Description |
|-------|-------------|
| MachinePolicy | Set by Group Policy for all users of the computer |
| UserPolicy | Set by Group Policy for the current user of the computer |
| Process | Affects only the current PowerShell session |
| CurrentUser | Set directly for the current user, typically via PowerShell commands |
| LocalMachine | Default scope that affects all users on the current computer |

### Execution Policy Settings:

| Policy | Description |
|--------|-------------|
| Restricted | Doesn't load configuration files or run scripts |
| AllSigned | Requires all scripts and configuration files to be signed by a trusted publisher |
| RemoteSigned | Requires scripts downloaded from the internet to be signed by a trusted publisher |
| Unrestricted | Loads all configuration files and runs all scripts |
| Bypass | Nothing is blocked and there are no warnings or prompts |
| Undefined | Removes the currently assigned execution policy from the current scope |


## Backward Compatibility and Version-Specific Features

PowerShell maintains very good  backward compatibility across versions. 
Scripts written for older versions of PowerShell will generally run without issues on newer versions, including PowerShell 7.x. This ensures that legacy scripts and modules continue to function as expected.

However, there are some version-specific features to be aware of:

- Windows PowerShell (5.1 and earlier): Windows-specific features
  or Direct access to COM objects

- PowerShell 7.x: Cross-platform compatibility (Windows, macOS, Linux)
  
When writing scripts, consider the target PowerShell version and the features available in that version to ensure compatibility and optimal performance. Recommendation is to use PowerShell 7.x for new scripts and modules.



## Exercise 3: Install Visual Studio Code and PowerShell Extension

Visual Studio Code is a powerful code editor that enhances the PowerShell scripting experience.

1. Download and install Visual Studio Code from the [Visual Studio Code website](https://code.visualstudio.com/).
2. Open Visual Studio Code.
3. Go to the Extensions tab (or press `Ctrl+Shift+X`).
4. Search for “PowerShell” and install the [PowerShell Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell).
5. Create a new `.ps1` file in Visual Studio Code to start scripting in PowerShell.

## Exercise 4: Start PowerShell, PowerShell 7, and Visual Studio Code

In this exercise, you'll practice launching different PowerShell environments and Visual Studio Code.

1. Start Windows PowerShell:
   - Press Win + R, type `powershell`, and press Enter
   - Or search for "PowerShell" in the Start menu

2. Start PowerShell 7 (pwsh):
   - Press Win + R, type `pwsh`, and press Enter
   - Or search for "pwsh" in the Start menu

3. Launch Visual Studio Code:
   - Press Win + R, type `code`, and press Enter
   - Or search for "Visual Studio Code" in the Start menu

