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


## 7. Fun with Speech Synthesis: Building Complexity

Let's explore PowerShell's speech synthesis capabilities, starting simple and gradually adding complexity.

### 7.1 Basic Speech Output

```powershell
function Speak-Simple {
    $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $voice.Speak("Hello, PowerShell world!")
}

Speak-Simple
```

### 7.2 Adding a Parameter

```powershell
function Speak-WithParam {
    param(
        [string]$Message
    )
    $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $voice.Speak($Message)
}

Speak-WithParam -Message "PowerShell is awesome!"
```

### 7.3 Multiple Parameters and Default Values

```powershell
function Speak-MultiParam {
    param(
        [string]$Message,
        [int]$Volume = 100
    )
    $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $voice.Volume = $Volume
    $voice.Speak($Message)
}

Speak-MultiParam -Message "Can you hear me?" -Volume 75
```

### 7.4 Parameter Validation

```powershell
function Speak-Validated {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Message,

        [ValidateRange(0,100)]
        [int]$Volume = 100
    )
    $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
    $voice.Volume = $Volume
    $voice.Speak($Message)
}

Speak-Validated -Message "This message is required!" -Volume 50
```

### 7.5 Advanced Function with Pipeline Support

```powershell
function Speak-Advanced {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Message,

        [ValidateSet("Male", "Female")]
        [string]$VoiceGender = "Female",

        [ValidateRange(0,100)]
        [int]$Volume = 100
    )
    
    process {
        $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
        $voiceName = $voice.GetInstalledVoices().VoiceInfo | 
                     Where-Object { $_.Gender -eq $VoiceGender } | 
                     Select-Object -ExpandProperty Name -First 1
        
        $voice.SelectVoice($voiceName)
        $voice.Volume = $Volume
        $voice.Speak($Message)
    }
}

"PowerShell is fun!", "Let's learn more!" | Speak-Advanced -VoiceGender Male -Volume 75
```



### 7.6 Combining API Calls with Speech Synthesis

Let's create functions that fetch Chuck Norris jokes and dad jokes from public APIs and then read them aloud:

```powershell
function Get-ChuckNorrisJoke {
    $response = Invoke-RestMethod -Uri "https://api.chucknorris.io/jokes/random" -Method Get
    return $response.value
}

function Get-DadJoke {
    $headers = @{
        "Accept" = "application/json"
    }
    $response = Invoke-RestMethod -Uri "https://icanhazdadjoke.com/" -Method Get -Headers $headers
    return $response.joke
}

function Read-Joke {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$Joke,
        
        [ValidateSet("Male", "Female")]
        [string]$VoiceGender = "Female",
        
        [ValidateRange(-10, 10)]
        [int]$Speed = 0
    )

    process {
        $voice = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
        $voiceName = $voice.GetInstalledVoices().VoiceInfo | 
                     Where-Object { $_.Gender -eq $VoiceGender } | 
                     Select-Object -ExpandProperty Name -First 1
        
        $voice.SelectVoice($voiceName)
        $voice.Rate = $Speed

        Write-Host "Telling joke: $Joke"
        $voice.Speak($Joke)
    }
}

# Fetch and read a Chuck Norris joke
$chuckJoke = Get-ChuckNorrisJoke
Read-Joke -Joke $chuckJoke -VoiceGender Male -Speed -2

# Fetch and read a Dad joke
$dadJoke = Get-DadJoke
Read-Joke -Joke $dadJoke -VoiceGender Female -Speed 1
```

This example demonstrates:
1. Using `Invoke-RestMethod` to fetch jokes from two different public APIs
2. Parsing the JSON responses to extract the joke strings
3. Passing the jokes to our speech function
4. Using different voice genders and speeds for variety

These functions fetch random Chuck Norris jokes and dad jokes from their respective APIs and then read them aloud using our speech synthesis function. It's a fun way to demonstrate how different PowerShell capabilities can be combined to create more complex and interesting scripts.
