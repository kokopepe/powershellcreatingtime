# Practical Exercises

## Part 1: PowerShell Basics

### Cmdlets 100

#### Task 1: Discovering Cmdlets
1. Open PowerShell.
2. Run `Get-Command`.
3. Observe the output and list some cmdlets that caught your eye.

#### Task 2: Exploring Modules
1. Run `Get-Module -ListAvailable`.
2. Observe the output and list some modules and their paths.

### The Pareto Cmdlets

#### Exercises
1. Get all Windows processes whose name starts with the letter "s".
2. List processes whose name is `svchost` and PM (Private Memory) is more than 100MB.
3. Export the results of (2) to HTML and CSV format.
4. Use `ForEach-Object` to display the name and size of each file in the current directory, but only if the file is larger than 1MB.

### Get-Help

#### Exercise 1: Mandatory vs Optional Parameters
1. Use the `Get-Help` cmdlet to examine the `Set-Location` cmdlet.
2. Identify the mandatory parameter.
3. List three optional parameters.
4. Write a command using `Set-Location` with both a mandatory and an optional parameter.

#### Exercise 2: Positional Parameters
1. Examine the `Get-Process` cmdlet.
2. Identify the parameter that can be used positionally.
3. Write a command using `Get-Process` with a positional parameter.
4. Write the same command using the parameter name explicitly.

#### Exercise 3: Switch Parameters
1. Look at the `Get-ChildItem` cmdlet.
2. List three switch parameters for this cmdlet.
3. Write a command using `Get-ChildItem` that uses at least two switch parameters.
4. Explain what your command does.

### Practice Exercises

#### File Search and Manipulation Exercise
1. Basic File Search: Find and list all files in the `FindFileExercise` folder that have "PSCourse" in their name.
2. Date-based Search: Find the file created before 1990.
3. Size-based Search and Sorting: Find the 3 largest files in the entire directory structure. Display their names, sizes, and locations.
4. Complex Date Range Search: Find all files created between June 1, 2020, and July 31, 2020. Display their names and exact creation dates.
5. Advanced Filtering and Calculations: Find all files larger than 1MB (1 million bytes) that were created in the last 5 years. Calculate and display the total size of these files in GB.

## Part 2: Advanced PowerShell

### Flow Control

#### Exercise: Multiplication Table
Use a `For` loop to create a multiplication table for the number 5 (5x1 to 5x10).

#### Exercise: Number Guessing Game
Create a simple number guessing game using a `Do-While` loop. The script should generate a random number between 1 and 10, and the user should guess until they get it right.

#### Exercise: File Size Calculator
Use `ForEach-Object` in a pipeline to calculate the total size of all .txt files in the current directory.

## Part 3: Object-Oriented PowerShell

### Practical Usage
1. Create a .NET object in PowerShell:
   ```powershell
   $webclient = New-Object System.Net.WebClient

2. Compare using a .NET object vs. a built-in cmdlet:
# Using .NET WebClient object
$webclient = New-Object System.Net.WebClient
$content = $webclient.DownloadString("https://google.com")

# Using built-in Invoke-WebRequest cmdlet
$response = Invoke-WebRequest -Uri "https://google.com"
$content = $response.Content
You can save this content into a file named [`exercises.md`](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2Fc%3A%2FAcademy%2Fpowershellcreatingtime%2Fexercises.md%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%2C%221924d693-8dfa-4285-b7b8-323ae5340728%22%5D "c:\Academy\powershellcreatingtime\exercises.md"). Here is the command to do so:

# Practical Exercises

## Part 1: PowerShell Basics

### Cmdlets 100

#### Task 1: Discovering Cmdlets
1. Open PowerShell.
2. Run \`Get-Command\`.
3. Observe the output and list some cmdlets that caught your eye.

#### Task 2: Exploring Modules
1. Run \`Get-Module -ListAvailable\`.
2. Observe the output and list some modules and their paths.

### The Pareto Cmdlets

#### Exercises
1. Get all Windows processes whose name starts with the letter \"s\".
2. List processes whose name is \`svchost\` and PM (Private Memory) is more than 100MB.
3. Export the results of (2) to HTML and CSV format.
4. Use \`ForEach-Object\` to display the name and size of each file in the current directory, but only if the file is larger than 1MB.

### Get-Help

#### Exercise 1: Mandatory vs Optional Parameters
1. Use the \`Get-Help\` cmdlet to examine the \`Set-Location\` cmdlet.
2. Identify the mandatory parameter.
3. List three optional parameters.
4. Write a command using \`Set-Location\` with both a mandatory and an optional parameter.

#### Exercise 2: Positional Parameters
1. Examine the \`Get-Process\` cmdlet.
2. Identify the parameter that can be used positionally.
3. Write a command using \`Get-Process\` with a positional parameter.
4. Write the same command using the parameter name explicitly.

#### Exercise 3: Switch Parameters
1. Look at the \`Get-ChildItem\` cmdlet.
2. List three switch parameters for this cmdlet.
3. Write a command using \`Get-ChildItem\` that uses at least two switch parameters.
4. Explain what your command does.

### Practice Exercises

#### File Search and Manipulation Exercise
1. Basic File Search: Find and list all files in the \`FindFileExercise\` folder that have \"PSCourse\" in their name.
2. Date-based Search: Find the file created before 1990.
3. Size-based Search and Sorting: Find the 3 largest files in the entire directory structure. Display their names, sizes, and locations.
4. Complex Date Range Search: Find all files created between June 1, 2020, and July 31, 2020. Display their names and exact creation dates.
5. Advanced Filtering and Calculations: Find all files larger than 1MB (1 million bytes) that were created in the last 5 years. Calculate and display the total size of these files in GB.

## Part 2: Advanced PowerShell

### Flow Control

#### Exercise: Multiplication Table
Use a \`For\` loop to create a multiplication table for the number 5 (5x1 to 5x10).

#### Exercise: Number Guessing Game
Create a simple number guessing game using a \`Do-While\` loop. The script should generate a random number between 1 and 10, and the user should guess until they get it right.

#### Exercise: File Size Calculator
Use \`ForEach-Object\` in a pipeline to calculate the total size of all .txt files in the current directory.

## Part 3: Object-Oriented PowerShell

### Practical Usage
1. Create a .NET object in PowerShell:
   \`\`\`powershell
   \$webclient = New-Object System.Net.WebClient
   \`\`\`

2. Compare using a .NET object vs. a built-in cmdlet:
   \`\`\`powershell
   # Using .NET WebClient object
   \$webclient = New-Object System.Net.WebClient
   \$content = \$webclient.DownloadString(\"https://google.com\")

   # Using built-in Invoke-WebRequest cmdlet
   \$response = Invoke-WebRequest -Uri \"https://google.com\"
   \$content = \$response.Content
   \`\`\`

### Variables and Workflow

#### Exercise: Working with Variables
1. Create a variable to store your name:
   \`\`\`powershell
   \$name = \"Your Name\"
   \`\`\`
2. Create a variable to store the current date:
   \`\`\`powershell
   \$currentDate = Get-Date
   \`\`\`
3. Display a message using both variables:
   \`\`\`powershell
   Write-Output \"Hello, \$name! Today's date is \$currentDate.\"
   \`\`\`

### Understanding the Pipeline

#### Exercise: Using the Pipeline
1. Get a list of all processes and sort them by CPU usage:
   \`\`\`powershell
   Get-Process | Sort-Object CPU -Descending
   \`\`\`
2. Filter the sorted list to show only the top 5 processes:
   \`\`\`powershell
   Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
   \`\`\`
3. Export the filtered list to a CSV file:
   \`\`\`powershell
   Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 | Export-Csv -Path \"Top5Processes.csv\" -NoTypeInformation
   \`\`\`

