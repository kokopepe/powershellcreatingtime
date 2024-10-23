# PowerShell Operators

In PowerShell, **operators** are special symbols that tell the PowerShell engine to perform specific actions on variables or values. These actions can be mathematical, logical, comparison-based, or even specific to strings or arrays. Below is a breakdown of the main types of operators in PowerShell:

## 1. Arithmetic Operators
These operators are used to perform mathematical calculations.

| **Operator** | **Description**          | **Example**          | **Result**      |
|--------------|--------------------------|----------------------|-----------------|
| `+`          | Addition                  | `5 + 2`              | `7`             |
| `-`          | Subtraction               | `5 - 2`              | `3`             |
| `*`          | Multiplication            | `5 * 2`              | `10`            |
| `/`          | Division                  | `10 / 2`             | `5`             |
| `%`          | Modulus (remainder)       | `10 % 3`             | `1`             |

## 2. Assignment Operators
These operators are used to assign values to variables.

| **Operator** | **Description**          | **Example**          | **Result**      |
|--------------|--------------------------|----------------------|-----------------|
| `=`          | Assigns a value           | `$a = 10`            | `$a` is `10`    |
| `+=`         | Adds and assigns          | `$a += 5`            | `$a = $a + 5`   |
| `-=`         | Subtracts and assigns     | `$a -= 2`            | `$a = $a - 2`   |
| `*=`         | Multiplies and assigns    | `$a *= 3`            | `$a = $a * 3`   |
| `/=`         | Divides and assigns       | `$a /= 2`            | `$a = $a / 2`   |

## 3. Comparison Operators
These operators are used to compare two values and return a Boolean result (`True` or `False`).

| **Operator**    | **Description**              | **Example**           | **Result**        |
|-----------------|------------------------------|-----------------------|-------------------|
| `-eq`           | Equal to                     | `5 -eq 5`             | `True`            |
| `-ne`           | Not equal to                 | `5 -ne 3`             | `True`            |
| `-gt`           | Greater than                 | `5 -gt 3`             | `True`            |
| `-ge`           | Greater than or equal to     | `5 -ge 5`             | `True`            |
| `-lt`           | Less than                    | `5 -lt 10`            | `True`            |
| `-le`           | Less than or equal to        | `5 -le 5`             | `True`            |
| `-like`         | Wildcard pattern matching    | `"Hello" -like "H*"`  | `True`            |
| `-notlike`      | Wildcard pattern mismatch    | `"Hello" -notlike "B*"`| `True`           |
| `-match`        | Regular expression matching  | `"abc123" -match "\d"`| `True`            |
| `-notmatch`     | Regular expression mismatch  | `"abc" -notmatch "\d"`| `True`            |

## 4. Logical Operators
Logical operators are used to combine two or more conditions.

| **Operator** | **Description**              | **Example**             | **Result**          |
|--------------|------------------------------|-------------------------|---------------------|
| `-and`       | Logical AND                  | `$a -eq 5 -and $b -eq 3` | `True` if both True |
| `-or`        | Logical OR                   | `$a -eq 5 -or $b -eq 3`  | `True` if one True  |
| `-not`       | Logical NOT                  | `-not($a -eq 5)`         | `False`             |

## 5. String Operators
Used to manipulate or compare strings.

| **Operator**   | **Description**                     | **Example**               | **Result**              |
|----------------|-------------------------------------|---------------------------|-------------------------|
| `+`            | Concatenation (combine strings)     | `"Power" + "Shell"`        | `"PowerShell"`          |
| `-replace`     | Replaces text in a string           | `"abc" -replace "a", "x"`  | `"xbc"`                 |
| `-split`       | Splits a string into an array       | `"a,b,c" -split ","`       | `@('a', 'b', 'c')`      |
| `-join`        | Joins an array into a string        | `("a", "b", "c") -join ","`| `"a,b,c"`               |

## 6. Array Operators
PowerShell includes operators that work on arrays.

| **Operator**    | **Description**                 | **Example**                         | **Result**           |
|-----------------|---------------------------------|-------------------------------------|----------------------|
| `+`             | Combines arrays                 | `@(1, 2) + @(3, 4)`                 | `@(1, 2, 3, 4)`      |
| `-`             | Removes elements from an array  | `@(1, 2, 3) - @(2)`                 | `@(1, 3)`            |
| `-contains`     | Checks if array contains value  | `@(1, 2, 3) -contains 2`            | `True`               |
| `-notcontains`  | Checks if array does not contain| `@(1, 2, 3) -notcontains 5`         | `True`               |

## 7. Type Operators
Used to check or change the type of a variable.

| **Operator**   | **Description**                     | **Example**                       | **Result**            |
|----------------|-------------------------------------|-----------------------------------|-----------------------|
| `-is`          | Checks if object is of a certain type | `$a -is [int]`                   | `True` if `$a` is integer |
| `-as`          | Casts an object to a certain type   | `"123" -as [int]`                | Converts `"123"` to `123`|


---

## Summary of Operator Types

| **Category**          | **Description**                                           |
|-----------------------|-----------------------------------------------------------|
| **Arithmetic**        | Basic math operations like `+`, `-`, `*`, `/`, `%`.       |
| **Assignment**        | Assigns values to variables (e.g., `=`, `+=`, `-=`).      |
| **Comparison**        | Compares values (`-eq`, `-ne`, `-gt`, `-lt`, etc.).       |
| **Logical**           | Combines conditions (`-and`, `-or`, `-not`).              |
| **String**            | Works on strings (e.g., `-replace`, `-split`, `-join`).   |
| **Array**             | Works on arrays (e.g., `-contains`, `-notcontains`).      |
| **Type**              | Type checking or casting (`-is`, `-as`).                  |

## Basic Exercises

1. **Arithmetic and Assignment Operators**
   
   Calculate the area of a rectangle with length 7 and width 5, then increase it by 10%.

   ```powershell
   $length = 7
   $width = 5
   $area = $length * $width
   $area *= 1.1
   Write-Output "The area after increase is: $area"
   ```

2. **Comparison and Logical Operators**
   
   Check if a number is between 1 and 10 (inclusive).

   ```powershell
   $number = 7
   $result = ($number -ge 1) -and ($number -le 10)
   Write-Output "Is $number between 1 and 10? $result"
   ```

3. **String and Array Operators**
   
   Split a comma-separated string into an array, add a new element, and join it back into a string.

   ```powershell
   $fruits = "apple,banana,cherry"
   $fruitArray = $fruits -split ","
   $fruitArray += "date"
   $newFruits = $fruitArray -join ", "
   Write-Output "Updated fruit list: $newFruits"
   ```

4. **Date Subtraction**
   
   Calculate the number of days between two dates.

   ```powershell
   $startDate = Get-Date "2023-01-01"
   $endDate = Get-Date "2023-12-31"
   $daysDifference = ($endDate - $startDate).Days
   Write-Output "Number of days between $startDate and $endDate"
   ```

Try these exercises in your PowerShell environment to practice using different types of operators!
