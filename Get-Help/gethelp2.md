# Understanding PowerShell Parameters

PowerShell cmdlets use various types of parameters to control their behavior. Let's break down the key concepts:

## Types of Parameters

| Parameter Type | Description | Example |
|----------------|-------------|---------|
| Optional | Not required for the cmdlet to run | `-Verbose` |
| Mandatory | Must be provided for the cmdlet to function | `-Path` in `Set-Location` |
| Named | Explicitly specified by their names | `-Name "Process1"` |
| Positional | Can be used without specifying the parameter name | `Get-Process winlogon` |
| Switched | Act as boolean flags | `-Force` |
| Default Value | Have a pre-set value if not specified | `-ErrorAction` defaults to `Continue` |

## Parameter Syntax

```
Cmdlet-Name -ParameterName ParameterValue
```

## Visual Representation

```
Get-ChildItem -Recurse -Filter *.ps1 | Select-Object name,length
|----------| |------| |--------|   |------------| |---------|
   Cmdlet    Switch   Named      Pipeline    Cmdlet   Positional
             Param    Param      Operator            Parameters
```



## Common Parameters

All cmdlets support a set of common parameters:

- `-Verbose`
- `-Debug`
- `-ErrorAction`
- `-ErrorVariable`
- `-WarningAction`
- `-WarningVariable`
- `-InformationAction`
- `-InformationVariable`
- `-OutVariable`
- `-OutBuffer`
- `-PipelineVariable`



## Tips for Working with Parameters

1. Use `Get-Help` to see all available parameters:
   ```powershell
   Get-Help Get-Process -Full
   ```

2. Tab completion works for parameter names:
   ```powershell
   Get-Process -Name <Tab>
   ```

3. Use `Show-Command` for a GUI interface to explore parameters:
   ```powershell
   Show-Command Get-Process
   ```

Remember, mastering parameters is key to effectively using PowerShell cmdlets and creating powerful scripts!


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

## Visual Representation

```
Get-ChildItem -Recurse -Filter *.ps1 | Select-Object name,length
|----------| |------| |--------|   |------------| |---------|
   Cmdlet    Switch   Named      Pipeline    Cmdlet   Positional
             Param    Param      Operator            Parameters
```
# PowerShell Parameter Exercises

## Exercise 1: Mandatory vs Optional Parameters

Use the `Get-Help` cmdlet to examine the `Set-Location` cmdlet. 

1. Which parameter is mandatory?
2. List three optional parameters.
3. Write a command using `Set-Location` with both a mandatory and an optional parameter.

## Exercise 2: Positional Parameters

Examine the `Get-Process` cmdlet.

1. Which parameter can be used positionally?
2. Write a command using `Get-Process` with a positional parameter.
3. Now write the same command using the parameter name explicitly.

## Exercise 3: Switch Parameters

Look at the `Get-ChildItem` cmdlet.

1. List three switch parameters for this cmdlet.
2. Write a command using `Get-ChildItem` that uses at least two switch parameters.
3. Explain what your command does.

