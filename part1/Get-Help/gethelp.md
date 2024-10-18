# Understanding Get-Help in PowerShell


Get-Command + Get-Help. One to find the cmdlet, the second to find out how to use it.

<p align="center">
  <img src="https://raw.githubusercontent.com/kokopepe/powershellcreatingtime/main/Get-Help/images/helpmeme.gif" alt="Get-Help in action">
</p>



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
| Mandatory | Must be provided for the cmdlet to function | `-Path` in `Set-Location` |
| Named | Explicitly specified by their names | `-Name "Process1"` |
| Positional | Can be used without specifying the parameter name | `Get-Process winlogon` |
| Switched | Act as boolean flags | `-Force` |
| Default Value | Have a pre-set value if not specified | `-ErrorAction` defaults to `Continue` |

## Parameter Syntax



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




## Challenge 

Let's explore the `Out-File` cmdlet using `Get-Help`. 
Find out the answers to the following questions:

1. Is there a parameter to add information to an existing file without overwriting it? (Yes/No)
2. Is there a parameter to prevent the cmdlet from overwriting an existing file? (Yes/No)
3. Which parameter is mandatory for `Out-File`?
4. Is there a parameter to specify the encoding of the output file? (Yes/No)
5. What does the `-NoNewline` parameter do? (Brief explanation)

## Find out what parameters a cmdlet has

Use the `Get-Help` cmdlet to examine the `Set-Location` cmdlet. 

1. Which parameter is mandatory?
2. List three optional parameters.
3. Write a command using `Set-Location` with both a mandatory and an optional parameter.
4. List  switch parameters for this cmdlet.