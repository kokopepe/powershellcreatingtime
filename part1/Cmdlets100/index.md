# PowerShell Basics 100 - Introduction to Cmdlets and Modules

Welcome to your first PowerShell exercise! This exercise is designed to help you get comfortable with using basic PowerShell commands. 
By the end, you'll have a better understanding of what cmdlets and modules are, and you'll get a chance to share your observations.

## Objective

- Run two basic commands in PowerShell.
- Get familiar with the `Get-Command` and `Get-Module` cmdlets.

## Task 1: Discovering Cmdlets

1. Open PowerShell.

   -  "PowerShell" in the Start menu and open it.
   -  type `pwsh` to launch PowerShell.

2. Run `Get-Command`.
   - In the PowerShell window, type the following and press Enter:
     ```powershell
     Get-Command
     ```
   - This command lists all the available cmdlets in PowerShell.

3. Observe the Output.
   - Look at the list of cmdlets that appear. They typically follow a format like Verb-Noun (e.g., Get-Help or Start-Service).
   
**Question:** What are some cmdlets that caught your eye?

4. Try these variations to explore cmdlets:
   ```powershell
   # List only Get commands
   Get-Command -Verb Get

   # List commands related to processes
   Get-Command -Noun Process

   # Count how many cmdlets are available
   (Get-Command).Count
   ```

## Task 2: Exploring Modules

1. Run `Get-Module -ListAvailable`.
   - In the same PowerShell window, type the following and press Enter:
     ```powershell
     Get-Module -ListAvailable
     ```
   - This command lists all the modules that are installed on your system.

2. Observe the Output.
   - You should see a list of modules and their paths.
   - Modules are like "toolboxes" that contain cmdlets grouped together based on their purpose.

3. Try these additional module commands:
   ```powershell
   # See what commands are in a specific module
   Get-Command -Module Microsoft.PowerShell.Management

   ```

## Task 3: Quick Practice Exercises

Try these simple exercises to get comfortable with cmdlets:


1. **File System Basics**
   ```powershell
   # List files in current directory
   Get-ChildItem

   # Create a test folder
   New-Item -ItemType Directory -Path "TestFolder"
   ```

## Summary

- You used `Get-Command` to see all available cmdlets in PowerShell.
- You used `Get-Module -ListAvailable` to see all modules installed on your system.

## Key Takeaways:

- Cmdlets are like specialized tools that help you get tasks done in PowerShell.
- Modules are like toolboxes that organize and hold these tools.
- Cmdlets work only within PowerShell sessions.

## Quick Tips:

1. **Common Verbs in PowerShell:**
   - Get: Retrieve information
   - Set: Change settings
   - New: Create new items
   - Remove: Delete items
   - Start: Begin a process
   - Stop: End a process

2. **Common Modules:**
   - Microsoft.PowerShell.Management: Basic system management
   - Microsoft.PowerShell.Utility: Data manipulation
   - Microsoft.PowerShell.Security: Security-related tasks

3. **Getting Help:**
   ```powershell
   # Get help for a specific cmdlet
   Get-Help Get-Process

   # Get examples for a cmdlet
   Get-Help Get-Process -Examples
   ```

## Next Steps:

1. Try using `Get-Help` with some of the cmdlets you discovered
2. Experiment with different parameters for the cmdlets you used
3. Try combining cmdlets using the pipeline (|)

