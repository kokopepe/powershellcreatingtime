# PowerShell Cmdlets: Select-Object, Where-Object, and ForEach-Object

PowerShell is a powerful scripting language and command-line shell that allows you to interact with your system and manage various aspects of it. Two essential cmdlets in PowerShell are `Select-Object` and `Where-Object`. These cmdlets help you filter and manipulate data effectively.

## Listening to Your Environment

Before we can effectively use PowerShell, we need to understand how to query our environment. This involves:

1. Filtering output
2. Retrieving data in the desired format
3. Understanding key commands

## Select-Object

`Select-Object` is one of the most frequently used cmdlets in PowerShell. It allows you to choose specific properties (or columns) of objects that you want to see in the output.

### Key features of Select-Object:

- Can select an arbitrary subset of output rows using `-First` and `-Last`
- Ability to limit the properties returned from a command using wildcards
- Can create custom or calculated properties

### Examples:
````powershell
Limit the properties returned
Get-Process | Select-Object -Property Name, Id
List everything but a few properties
Get-Process | Select-Object -Property -Exclude "Memory"
Get the first few objects
Get-ChildItem C:\ | Select-Object -First 5
Get the last few objects
Get-ChildItem C:\ | Select-Object -Last 3
````

## Where-Object

`Where-Object` is used to filter objects out of the pipeline based on specified criteria.

### Key features of Where-Object:

- Removes or filters objects based on conditions you specify
- Works well in combination with `Select-Object` for powerful data manipulation

### Example:
````powershell
Get processes with working set (WS) more than 100MB
Get-Process | Where-Object {$.WS -gt 100MB}
````

## ForEach-Object

`ForEach-Object` allows you to perform operations on each item in a collection of input objects.

### Key features of ForEach-Object:

- Executes a script block on each item in the pipeline
- Can be used for complex operations or simple property access
- Often abbreviated as `%` in PowerShell scripts

### Examples:
Using the % alias
````powershell
1..5 | % { $PSItem * 2 }
````


## Exercises

To practice these concepts, try the following exercises:

1. Get all Windows processes whose name starts with letter "s"
2. List processes whose name is svchost and PM (Private Memory) is more than 100MB
3. Get Process Name, Process ID and HandleCount where PM is more than 100MB and CPU more than 1000s
4. Export the results of (3) to html and CSV format
5. Use `ForEach-Object` to display the name and size of each file in the current directory, but only if the file is larger than 1MB

Remember, mastering these cmdlets will greatly enhance your ability to manipulate, analyze, and process data in PowerShell!

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

These operators are used extensively in PowerShell scripting to filter data or compare values when processing collections of objects.


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


These examples demonstrate how to use `-and` and `-or` operators to create more sophisticated filters. You can combine multiple conditions to pinpoint exactly the processes you're interested in analyzing. By mastering these logical operators, you can create highly specific queries that allow you to extract precisely the information you need from your system.
