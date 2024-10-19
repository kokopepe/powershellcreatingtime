
# Flow Control in PowerShell

PowerShell offers several flow control structures to manage the execution of your scripts. Let's explore the key ones:

## If Statement

The `If` statement allows you to execute code based on a condition:

if ($condition) {
    # Code to execute if condition is true
}
else {
    # Code to execute if condition is false
}

Example:

$age = 25
if ($age -ge 18) {
    Write-Output "You are an adult"
}
else {
    Write-Output "You are a minor"
}

## Loops

### ForEach Loop

The `ForEach` loop iterates through a collection of items:

$fruits = @("apple", "banana", "orange")
foreach ($fruit in $fruits) {
    Write-Output "I like $fruit"
}

> **Tip:** Don't confuse `foreach` with `ForEach-Object`. Use `ForEach-Object` when working with pipeline input or when you need to process items as they come in. 
```powershell
get-process | ForEach-Object { Write-Output "Processing item $_.Name" }
```



### For Loop

The `For` loop repeats an action a specified number of times:

for ($i = 1; $i -le 5; $i++) {
    Write-Output "Iteration $i"
}

### Do-While Loop

The `Do-While` loop executes a block of code at least once and then repeatedly executes the block as long as a condition is true:

$counter = 1
do {
    Write-Output "Counter is $counter"
    $counter++
} while ($counter -le 5)

### ForEach-Object

Note: `ForEach-Object` is a cmdlet used in the pipeline, different from the `foreach` statement:

1..5 | ForEach-Object { Write-Output "Processing item $_" }

## Exercises

1. Write a script that checks if a number is even or odd using an `If` statement.

2. Create an array of five colors. Use a `ForEach` loop to output each color.

3. Use a `For` loop to count from 1 to 10, outputting only even numbers.

4. Write a `Do-While` loop that asks the user for input and continues until they type "exit".

5. Create a pipeline that generates numbers 1 to 10 and uses `ForEach-Object` to output the square of each number.
