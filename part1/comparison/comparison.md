# PowerShell Comparison Operators

PowerShell provides various comparison operators that can be used in conditional statements, filtering, and object selection. Think of these operators as your toolkit for making decisions and filtering data in PowerShell.

## Basic Comparison Operators

### 1. Equality Operators
- **-eq**: Equal to
- **-ne**: Not equal to

```powershell
# Try these examples:
5 -eq 5    # Returns True
"PowerShell" -eq "powershell"    # Returns False (case-sensitive)
Get-Process | Where-Object { $_.Id -eq 1000 }    # Find process with ID 1000
```

### 2. Numeric Comparison Operators
- **-gt**: Greater than
- **-ge**: Greater than or equal to
- **-lt**: Less than
- **-le**: Less than or equal to

```powershell
# Try these examples:
10 -gt 5    # Returns True
5 -ge 5     # Returns True
3 -lt 5     # Returns True
5 -le 5     # Returns True

# Practical example: Find processes using more than 500MB of memory
Get-Process | Where-Object { $_.WorkingSet -gt 500MB }
```

### 3. Pattern Matching Operators
- **-like**: Wildcard pattern matching
- **-notlike**: Negative wildcard pattern matching
- **-match**: Regular expression matching
- **-notmatch**: Negative regular expression matching

```powershell
# Try these examples:
"PowerShell" -like "Power*"    # Returns True
"PowerShell" -like "power*"    # Returns False (case-sensitive)
"PowerShell" -match "^Power"   # Returns True (regex)
"PowerShell" -match "shell$"   # Returns True (regex)

# Practical example: Find all services starting with "Win"
Get-Service | Where-Object { $_.Name -like "Win*" }
```

## Exercise: Combining Operators

Let's practice with a real-world scenario. Try to:
1. Find all processes that:
   - Start with "Chr" (Chrome)
   - Use more than 100MB of memory
   - Have been running for more than 1 hour

```powershell
Get-Process | Where-Object {
    $_.Name -like "Chr*" -and 
    $_.WorkingSet -gt 100MB -and 
    $_.StartTime -lt (Get-Date).AddHours(-1)
}
```

## Common Pitfalls to Avoid

1. **Case Sensitivity**: PowerShell comparison operators are case-sensitive by default
   ```powershell
   "PowerShell" -eq "powershell"    # Returns False
   ```

2. **Type Comparison**: Be careful when comparing different types
   ```powershell
   "5" -eq 5    # Returns True (PowerShell tries to convert types)
   ```

3. **Null Comparisons**: Special handling for null values
   ```powershell
   $null -eq $null    # Returns True
   $null -eq ""       # Returns False
   ```

## Advanced Filtering with Logical Operators

### AND (-and) and OR (-or) Operators

```powershell
# Find services that are either stopped OR have "Windows" in their name
Get-Service | Where-Object { 
    $_.Status -eq "Stopped" -or 
    $_.DisplayName -like "*Windows*" 
}

# Find processes that are both:
# 1. Using more than 500MB of memory AND
# 2. Have more than 100 threads
Get-Process | Where-Object {
    $_.WorkingSet -gt 500MB -and 
    $_.Threads.Count -gt 100
}
```

## Practice Exercise

Try to write a command that:
1. Gets all services
2. Filters for services that:
   - Start with "Win" OR "Net"
   - Are currently running
   - Have automatic startup type
3. Selects only the Name and Status properties
4. Sorts the results by Name

```powershell
# Your solution here:
Get-Service | Where-Object {
    ($_.Name -like "Win*" -or $_.Name -like "Net*") -and
    $_.Status -eq "Running" -and
    $_.StartType -eq "Automatic"
} | Select-Object Name, Status | Sort-Object Name
```

Remember: The key to mastering comparison operators is practice. Try modifying these examples and experiment with different combinations to see how they work!
