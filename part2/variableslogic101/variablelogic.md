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


# PSCustomObject in PowerShell

<p align="center">
  <img src="part2/variableslogic101/images/swiss.png" alt="Future of AI" width="400">
</p>


PSCustomObject is a powerful and flexible way to create custom objects in PowerShell. It provides a simple and efficient method for creating structured data that can be easily manipulated and accessed.

## How to Use PSCustomObject

To create a PSCustomObject, you can use the following syntax:

$myObject = [PSCustomObject]@{
    Name = "John Doe"
    Age = 30
    City = "New York"
}

You can then access the properties of the object using dot notation:

$myObject.Name  # Output: John Doe
$myObject.Age   # Output: 30

## Advantages of PSCustomObject



1. **Pipeline compatibility**: PSCustomObjects work seamlessly with PowerShell's pipeline operations.

2. **Flexibility**: You can easily add, remove, or modify properties of a PSCustomObject.

3. **Easy conversion**: You can easily convert PSCustomObjects to and from other data formats like JSON or CSV.

Compared to other object types in PowerShell, PSCustomObject offers a balance of simplicity, flexibility, and performance, making it an excellent choice for many scripting scenarios.

