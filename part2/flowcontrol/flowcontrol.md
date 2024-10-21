# Flow Control in PowerShell

## Looping

One of the great things about PowerShell is, once you figure out how to do something for one item, it's almost as easy to do the same task for hundreds of items. Simply loop through the items using one of the many different types of loops in PowerShell.


PowerShell offers several flow control structures to manage the execution of your scripts. Here's a quick overview:

| Structure | Purpose | Basic Syntax |
|-----------|---------|--------------|
| If | Conditional execution | `if ($condition) { ... } else { ... }` |
| ForEach | Iterate over collection | `foreach ($item in $collection) { ... }` |
| For | Repeat a specified number of times | `for ($i = 0; $i -lt $count; $i++) { ... }` |
| Do-While | Execute at least once, then while condition is true | `do { ... } while ($condition)` |
| ForEach-Object | Process pipeline input | `$input | ForEach-Object { ... }` |

Let's explore each of these in more detail:

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

### Exercise: Age Check
Write a script that asks the user for their age using `Read-Host`, then checks if they are 18 or older. If they are, output "You are an adult". Otherwise, output "You are a minor".

<details>
<summary>Solution</summary>

```powershell
$age = Read-Host "Please enter your age"
if ($age -ge 18) {
    Write-Output "You are an adult"
}
else {
    Write-Output "You are a minor"
}
````


</details>

## Loops

### ForEach Loop

The `ForEach` loop iterates through a collection of items:

$fruits = @("apple", "banana", "orange")
foreach ($fruit in $fruits) {
    Write-Output "I like $fruit"
}

### Exercise: Service Stopper
Create a script that uses a `ForEach` loop to stop three non-critical services (e.g., "XboxGipSvc", "XblAuthManager", "XblGameSave"). For each service, output its name and new status after attempting to stop it.

<details>
<summary>Solution</summary>

```powershell
$services = @("XboxGipSvc", "XblAuthManager", "XblGameSave")
foreach ($serviceName in $services) {
        Stop-Service -Name $serviceName -Force -ErrorAction Stop
        $service = Get-Service -Name $serviceName
        Write-Output "Service: $($service.DisplayName) is stopped "

}
````


</details>

> **Tip:** Don't confuse `foreach` with `ForEach-Object`. Use `ForEach-Object` when working with pipeline input or when you need to process items as they come in.

```powershell
Get-Service | Where-Object {$_.Status -eq 'Running'} | ForEach-Object { 
    Write-Output "Running Service: $($_.DisplayName)"
}
````

### For Loop

The `For` loop repeats an action a specified number of times:

for ($i = 1; $i -le 5; $i++) {
    Write-Output "Iteration $i"
}

### Exercise: Multiplication Table
Use a `For` loop to create a multiplication table for the number 5 (5x1 to 5x10).

<details>
<summary>Solution</summary>

```powershell
for ($i = 1; $i -le 10; $i++) {
    $result = 5 * $i
    Write-Output "5 x $i = $result"
}
````


</details>

### Do-While Loop

The `Do-While` loop executes a block of code at least once and then repeatedly executes the block as long as a condition is true:

$counter = 1
do {
    Write-Output "Counter is $counter"
    $counter++
} while ($counter -le 5)

### Exercise: Number Guessing Game
Create a simple number guessing game using a `Do-While` loop. The script should generate a random number between 1 and 10, and the user should guess until they get it right.

<details>
<summary>Solution</summary>

```powershell
$targetNumber = Get-Random -Minimum 1 -Maximum 11
do {
    $guess = Read-Host "Guess a number between 1 and 10"
    if ($guess -lt $targetNumber) {
        Write-Output "Too low!"
    }
    elseif ($guess -gt $targetNumber) {
        Write-Output "Too high!"
    }
} while ($guess -ne $targetNumber)
Write-Output "Correct! The number was $targetNumber."
````


</details>

### ForEach-Object

Note: `ForEach-Object` is a cmdlet used in the pipeline, different from the `foreach` statement:

### Exercise: File Size Calculator
Use `ForEach-Object` in a pipeline to calculate the total size of all .txt files in the current directory.

<details>
<summary>Solution</summary>

```powershell
$totalSize = Get-ChildItem -Filter *.txt | ForEach-Object {
    $_.Length
} | Measure-Object -Sum | Select-Object -ExpandProperty Sum

Write-Output "Total size of .txt files: $totalSize bytes"
````
</details>

