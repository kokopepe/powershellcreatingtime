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


##  Filtering with Logical Operators

When working with cmdlets like `Get-Service`, you can use logical operators like `-and` and `-or` to create more complex filtering conditions. This allows for more precise and powerful data manipulation.

### Examples using AND and OR operators:

```powershell
# Get services that start with "W" AND are running
Get-Service | Where-Object { $_.Name -like "W*" -and $_.Status -eq "Running" } |
    Select-Object Name, Status, DisplayName

# Get services that are either stopped OR have "Windows" in their display name
Get-Service | Where-Object { $_.Status -eq "Stopped" -or $_.DisplayName -like "*Windows*" } |
    Select-Object Name, Status, DisplayName
```

These examples demonstrate how to use `-and` and `-or` operators to create more sophisticated filters. You can combine multiple conditions to pinpoint exactly the services you're interested in analyzing.
