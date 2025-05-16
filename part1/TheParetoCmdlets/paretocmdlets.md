# PowerShell Cmdlets: Select-Object, Where-Object, and ForEach-Object

PowerShell is a powerful scripting language and command-line shell that allows you to interact with your system and manage various aspects of it. Two essential cmdlets in PowerShell are `Select-Object` and `Where-Object`. These cmdlets help you filter and manipulate data effectively.

<p align="center">
  <img src="/part1/TheParetoCmdlets/images/productionline.png" alt="Production Line" width="600">
</p>

## Listening to Your Environment

Before we can effectively use PowerShell, we need to understand how to query our environment. This involves:

1. Filtering output
2. Retrieving data in the desired format
3. Understanding key commands

## Select-Object

`Select-Object` is one of the most frequently used cmdlets in PowerShell. It allows you to choose specific properties (or columns) of objects that you want to see in the output.


- Ability to limit the properties returned from a command. 
- Can create custom or calculated properties (We will alk about this)

### Examples:
````powershell
Limit the properties returned
Get-Process | Select-Object -Property Name, Id
List everything but a few properties
Get-Process | Select-Object -Property -Exclude "Memory"
Get the last few objects
Get-ChildItem C:\ | Select-Object -Last 3
````

## Where-Object

`Where-Object` is used to filter objects out of the pipeline based on specified criteria.


- Removes or filters objects based on conditions you specify

### Example:
````powershell
Get processes with working set (WS) more than 100MB
Get-Process | Where-Object {$.WS -gt 100MB}
````

## ForEach-Object

`ForEach-Object` allows you to perform operations on each item in a collection of input objects.

- Executes a script block on each item in the pipeline
- Can be used for complex operations or simple property access
- Often used with the Alias: `%`

### Examples:
Using the % alias
````powershell
Get-Process | % { Write-Host $_.Name }
````
Convert a list of strings to uppercase:
````powershell
"apple", "banana", "cherry" | % { $_.ToUpper() }
````


# PowerShell Comparison Operators

PowerShell provides various comparison operators that can be used in conditional statements, filtering, and object selection. Below is an explanation of some key operators and an example using `Select-Object`.

### Common Comparison Operators:

- **-eq**, **-ne**,**-gt**,**-ge**,**-lt**,**-le**: Equal, greater, less. 
  ```powershell
  # Example: -eq or -ne for equal or not equal
  Get-Process | Select-Object Name, Id | Where-Object { $_.Id -eq 1000 }
  ```
 ```powershell
  # Example: greater than, greater than or equal to
  Get-Process |  Where-Object { $_.Id -gt 5000 }
  ```
  ```powershell
  # Example: -lt for less than -le for less than or equal to
  Get-Process |  Where-Object { $_.Id -lt 5000 }
  ```
- **-match**, **-notmatch**: Regular expression match
  ```powershell
  # Example: Matching process names that start with "S"
  Get-Process |  Where-Object { $_.Name -match '^S' }
  ```




## Advanced Filtering with Logical Operators

When working with `Get-Process`, `Where-Object`, and `Select-Object`, you can use logical operators like `-and` and `-or` to create more complex filtering conditions. This allows for more precise and powerful data manipulation.

### Examples using AND and OR operators:

```powershell
# Get services that start with "W" AND are running
Get-Service | Where-Object { $_.Name -like "W*" -and $_.Status -eq "Running" } |
    Select-Object Name, Status, DisplayName

# Get services that are either stopped OR have "Windows" in their display name
Get-Service | Where-Object { $_.Status -eq "Stopped" -or $_.DisplayName -like "*Windows*" } |
    Select-Object Name, Status, DisplayName
```


These examples demonstrate how to use `-and` and `-or` operators to create more sophisticated filters. You can combine multiple conditions to pinpoint exactly the processes you're interested in analyzing. 


## Built-in Remote Capabilities

PowerShell offers various methods to execute commands on remote computers. One of the most common tasks in PowerShell is to run commands against remote systems, and this can often be done using built-in remote capabilities.


To discover which cmdlets have a `ComputerName` parameter, you can use the following command:

```powershell
Get-Command -ParameterName ComputerName
````
Or check the status of a service on multiple remote computers:

```powershell
Get-Service -Name "Spooler" -ComputerName Server01, Server02, Server03
````

```powershell
get-adcomputer | foreach-object {
    get-service -name "Spooler" -computername $_.name
}
````

```powershell
Get-Service -Name "Spooler" -ComputerName Server01, Server02, Server03
```

## Output and Conversion Cmdlets

PowerShell provides several cmdlets for outputting and converting data. Here are four commonly used ones:

### Out-File

`Out-File` sends output to a file, allowing you to save command results for later use or analysis.

```powershell
Get-Process | Out-File -FilePath "C:\processes.txt"
```
Key features: Can append to existing files (-Append), set encoding (-Encoding), and force overwrite of read-only files (-Force).

### Export-Csv

`Export-Csv` exports objects to a comma-separated value (CSV) file, which is great for data that needs to be imported into spreadsheets or databases.

```powershell
Get-Process | Export-Csv -Path "C:\processes.csv" -NoTypeInformation
```
Key features: Removes type information header (-NoTypeInformation), specifies delimiter (-Delimiter), and supports appending (-Append).

### ConvertTo-Json

`ConvertTo-Json` converts objects to a JSON-formatted string, which is useful for data interchange or when working with web services.

```powershell
Get-Process | Select-Object Name, Id, CPU | ConvertTo-Json | Out-File "C:\processes.json"
```
Key features: Controls depth of conversion (-Depth), supports compression of output (-Compress), and handles circular references (-EscapeHandling).

### ConvertTo-Html

`ConvertTo-Html` converts objects into HTML format, which is useful for creating reports or web-based output.

```powershell
Get-Process | Select-Object Name, Id, CPU | ConvertTo-Html | Out-File "C:\processes.html"
```
Key features: Customizes HTML output with CSS (-CssUri), adds custom headers and footers (-Head, -Body, -Title), and creates tables or lists (-As Table/List).

These cmdlets are powerful tools for exporting and converting data in PowerShell, allowing you to interface with various file formats and systems.

## Exercises

To practice these concepts, try the following exercises:

1. Get all Windows processes whose name starts with letter "s"
2. List processes whose name is svchost and PM (Private Memory) is more than 100MB
3. Export the results of (3) to html and CSV format
4. Use `ForEach-Object` to display the name and size of each file in the current directory, but only if the file is larger than 1MB

## File Search and Manipulation Exercise

This exercise is designed to help you practice file searching and manipulation skills using PowerShell. The `CreateDataStructure.ps1` script has generated a set of files with various properties in the `FindFileExercise` folder.

### Your Tasks

Using PowerShell commands, complete the following exercises. They are arranged from easiest to most challenging:

#### 1. Basic File Search
Find and list all files in the `FindFileExercise` folder that have "PSCourse" in their name.

#### 2. Date-based Search
Find the file created before 1990.

#### 3. Size-based Search and Sorting
Find the 3 largest files in the entire directory structure. Display their names, sizes, and locations.

#### 4. Complex Date Range Search
Find all files created between June 1, 2020, and July 31, 2020. Display their names and exact creation dates.

#### 5. Advanced Filtering and Calculations
Find all files larger than 1MB (1 million bytes) that were created in the last 5 years. Calculate and display the total size of these files in GB.

### Tips

- Use `Get-ChildItem` (alias `dir` or `ls`) to list files and folders
- The `-Recurse` parameter allows you to search subfolders
- `Where-Object` (alias `where`) can help you filter files based on their properties
- `Sort-Object` (alias `sort`) can order files by size or date
- `Select-Object` (alias `select`) can limit the number of results or choose specific properties to display
- `Measure-Object` (alias `measure`) can help with calculations like sum and average

### Example Command

Here's an example of how you might start your search for Exercise 1:

```powershell
Get-ChildItem -Path .\FindFileExercise -Recurse -File | Where-Object { $_.Name -like "*PSCourse*" }
```

### Submission

For each exercise, provide:
1. The PowerShell command(s) you used to complete the task
2. The output of your command(s)
3. A brief explanation of how your command works

