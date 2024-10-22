# PowerShell Functions

## Introduction to Functions in PowerShell

Functions in PowerShell are reusable blocks of code that perform specific tasks. They help organize code, improve readability, and promote code reuse. Functions can take inputs (parameters), perform actions, and return results.

## Basic Function Syntax

The basic syntax for a PowerShell function is:

```powershell
function Verb-Noun {
    # Function code goes here
}
```

The 'Verb-Noun' naming convention is important in PowerShell. Use approved verbs (you can see the list with `Get-Verb` cmdlet) for consistency.

## Creating a Simple Function

Here's a simple function that doesn't take any parameters:

```powershell
function Say-Hello {
    Write-Output "Hello, PowerShell!"
}

To use a function, simply type its name:

Say-Hello

## Functions with Parameters

Functions can accept input through parameters:

```powershell
function Greet-Person {
    param(
        [string]$Name  # This defines a parameter named 'Name' of type 'string'
    )
    Write-Output "Hello, $Name!"
}
```

You can provide the parameter value using the parameter name:

Greet-Person -Name "John"

## Functions with Return Values

Functions can return values using the 'return' keyword:

```powershell
function Add-Numbers {
    param(
        [int]$a,
        [int]$b
    )
    return $a + $b  # This function returns the sum of two numbers
}
```

The returned value can be stored in a variable:

```powershell
$result = Add-Numbers -a 5 -b 3
Write-Output "The sum is: $result"
```

## Advanced Function Features

PowerShell functions can have many advanced features:
- Parameter validation: Ensure inputs meet certain criteria
- Pipeline input: Accept input from the PowerShell pipeline
- Default parameter values: Provide fallback values if not specified
- Help messages: Provide documentation for your function

Here's an example of a more advanced function:

```powershell
function Get-Square {
    [CmdletBinding()]  # This enables advanced function features
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [ValidateRange(1, 100)]  # This ensures the input is between 1 and 100
        [int]$Number
    )
    
    process {  # This block is used for pipeline input processing
        $square = $Number * $Number
        Write-Output "The square of $Number is $square"
    }
}
```

You can use this function like this:

Get-Square -Number 7
# Or with pipeline input:
1..5 | Get-Square

## Best Practices

1. Use approved verbs (`Get-Verb`): Ensures consistency with PowerShell conventions
2. Follow naming conventions: Use PascalCase for function names
3. Include comment-based help: Provide documentation for your functions
4. Use parameter validation: Ensure your function receives valid input
5. Make your functions modular: Each function should do one thing well
6. Use clear, descriptive names for functions and parameters

## Exercises

1. Create a function that calculates the area of a circle
2. Write a function that converts Celsius to Fahrenheit
3. Develop a function that checks if a number is prime

This markdown provides a comprehensive introduction to PowerShell functions. It covers basic syntax, parameters, return values, advanced features, and best practices. Use this as a foundation for your 101 training, and expand on each concept with more detailed explanations and examples as needed.
