# Understanding Get-Help in PowerShell


Get-Command + Get-Help. One to find the cmdlet, the second to find out how to use it.

<p align="center">
  <img src="https://raw.githubusercontent.com/kokopepe/powershellcreatingtime/main/part1/Get-Help/images/helpmeme.gif" alt="Get-Help in action">
</p>


Get-Help is an essential tool in PowerShell, providing comprehensive documentation for cmdlets and functions.
Mastering Get-Help allows you to quickly understand and utilize PowerShell's vast array of commands and features.

### Basic Usage

To get help on any cmdlet, simply type `Get-Help` followed by the cmdlet name:

````powershell
Get-Help Get-Process
````
## Update Help

The `Update-Help` cmdlet downloads the latest help content, including new cmdlets and updated information. It retrieves `.help.xml` files for all installed modules, ensuring you have the most current documentation.
```` powershell
Update-Help
````

### Detailed Help

This will display basic information about the `Get-Process` cmdlet.

- For more detailed information, use the `-Detailed` parameter:
```` powershell
Get-Help Get-Process -Detailed
````

- To see all available help content, including examples, use the `-Full` parameter:
```` powershell
Get-Help Get-Process -Full
````

- Online Help: To view the most up-to-date help content in your web browser, use the `-Online` parameter:
```` powershell
Get-Help Get-Process -Online
````

- Examples: To see examples of how to use a cmdlet, use the `-Examples` parameter:

```` powershell
Get-Help Get-Process -Examples
````

> Use `Show-Command` for a GUI interface to explore parameters:
   ```powershell
   Show-Command Get-Process
   ```

## Understanding Parameters in Help

When you use `Get-Help` on a cmdlet, you'll see a list of parameters. Here's how to interpret them:

1. **Parameter name**: The name you use to specify the parameter (e.g., `-Name`).
2. **Data type**: The type of data the parameter accepts (e.g., `<String>`).
3. **Position**: If a number is shown, the parameter can be used by position without its name.
4. **Mandatory/Optional**: 
   - In the detailed parameter description, it will say "Required?" followed by "True" (mandatory) or "False" (optional).
5. **Accepts pipeline input**: Shows if the parameter can accept input from a pipeline.
6. **Accepts wildcard characters**: 
   - In the detailed parameter description, look for "Accept wildcard characters?" followed by "True" or "False".

Example:
```powershell
Get-Help Get-Process -Parameter Name
```

# Understanding PowerShell Parameters

PowerShell cmdlets use various types of parameters to control their behavior. Let's break down the key concepts:

## Types of Parameters

| Parameter Type | Description | Example |
|----------------|-------------|---------|
| Optional | Not required for the cmdlet to run | `-Verbose` |
| Mandatory | Must be provided for the cmdlet to function | `-FilePath` in `Out-File` |
| Named | Explicitly specified by their names | `-Name "Process1"` |
| Positional | Can be used without specifying the parameter name | `Get-Process winlogon` |
| Switched | Act as boolean flags | `-Force` |
| Default Value | Have a pre-set value if not specified | `-ErrorAction` defaults to `Continue` |


```powershell
Cmdlet-Name -ParameterName ParameterValue
```

## Visual Representation

```powershell

Get-ChildItem -Recurse -Filter *.ps1 | Select-Object name,length
|----------| |------| |--------|       |------------| |---------|
   Cmdlet    Switch   Named               Cmdlet   Positional
             Param    Param            Param    Param
```


# Autocomplete

The TAB key is your ally in PowerShell, offering powerful autocomplete functionality for commands and parameters. Leveraging TAB can significantly speed up your typing and help you discover available options as you work.

PowerShell provides several types of autocomplete:

1. **Command completion**: When you start typing a command name, PowerShell completes the rest of the name and shows all commands that contain the typed text anywhere in its name.

2. **Parameter completion**: After you have typed a command, entering a hyphen (-) enables parameter completion. PowerShell lists all parameters that match the typed text anywhere in its name.

3. **Argument completion**: After typing a parameter, PowerShell often can suggest and complete available argument values, depending on the command and parameter.

4. **Variable completion**: After typing $, PowerShell completes variable names and providers (drives).

5. **Member completion**: After a dot (.), PowerShell completes object members such as methods and properties.

6. **Path completion**: When typing a file or directory path, PowerShell can autocomplete folder and file names, making navigation through the file system, registry, psdrivers providers (certificates, AD, SQL ...)


Using these autocomplete features can greatly enhance your productivity and help you discover PowerShell's capabilities as you work.

## Challenge 

Let's explore the `Out-File` cmdlet using `Get-Help`. 
Find out the answers to the following questions:

1. Is there a parameter to add information to an existing file without overwriting it? (Yes/No)
2. Is there a parameter to prevent the cmdlet from overwriting an existing file? (Yes/No)
3. Which parameter is mandatory for `Out-File`?
4. Is there a parameter to specify the encoding of the output file? (Yes/No)
5. What does the `-NoNewline` parameter do? (Brief explanation)
6. List all switch parameters for this cmdlet.


## Parameter Breakdown

1. **[-FilePath] <System.String>**
   - Mandatory parameter (square brackets around the name indicate it can be omitted if used positionally)
   - Accepts a string value specifying the path of the output file

2. **[-Encoding] {ASCII | BigEndianUnicode | ...}**
   - Optional parameter (entire parameter in square brackets)
   - Accepts one of the listed encoding types
   - Curly braces {} indicate a set of predefined values

3. **[-Append]**
   - Optional switch parameter
   - When present, adds content to the end of an existing file

4. **[-Force]**
   - Optional switch parameter
   - Overrides restrictions that prevent the command from succeeding

5. **[-InputObject <System.Management.Automation.PSObject>]**
   - Optional parameter
   - Accepts input to be written to the file

6. **[-NoClobber]**
   - Optional switch parameter
   - Prevents overwriting of an existing file

7. **[-NoNewline]**
   - Optional switch parameter
   - Omits the newline character at the end of the output

8. **[-Width <System.Int32>]**
   - Optional parameter
   - Accepts an integer specifying the width of the output

9. **[-Confirm]**
   - Optional switch parameter
   - Prompts for confirmation before executing the command

10. **[-WhatIf]**
    - Optional switch parameter
    - Shows what would happen if the command were to run

11. **[<CommonParameters>]**
    - Indicates that this cmdlet supports common parameters like `-Verbose`, `-Debug`, etc.
