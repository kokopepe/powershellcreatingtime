6. PowerShell Variables and Data Types

## Introduction to Variables

In PowerShell, variables are used to store and manipulate data. They act as containers that hold information, which can be referenced and modified throughout your scripts.

### Declaring and Using Variables

To declare a variable in PowerShell, you use the `$` symbol followed by the variable name. Here's the basic syntax:

powershell
$variableName = value

````powershell
$name = "John"
$age = 30
$isStudent = $true
````

You can use variables in your scripts by referencing them directly:

```powershell
Write-Host "Hello, $name! You are $age years old."
```

## Data Types

PowerShell is a dynamically typed language, which means you don't need to explicitly declare the data type. However, understanding common data types is crucial:

1. **Strings**: Text values
   ```powershell
   $greeting = "Hello, World!"
   ```

2. **Integers**: Whole numbers
   ```powershell
   $count = 42
   ```

3. **Floating-point numbers**: Numbers with decimal points
   ```powershell
   $pi = 3.14159
   ```

4. **Booleans**: True or false values
   ```powershell
   $isEnabled = $true
   $isDisabled = $false
   ```

5. **Arrays**: Collections of values
   ```powershell
   $fruits = @("apple", "banana", "orange")
   ```

6. **Hashtables**: Key-value pairs
   ```powershell
   $person = @{
       "Name" = "Alice"
       "Age" = 25
       "City" = "New York"
   }
   ```

You can check the type of a variable using the `GetType()` method:

powershell
$name = "John"
$name.GetType()
$age = 30
$age.GetType()


