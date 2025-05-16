# PowerShell and AI: Analyzing Windows Errors

## What We're Going to Build
We're going to create a simple tool that:
1. Gets error messages from your Windows computer
2. Sends them to an AI (OpenAI) to analyze
3. Gets back suggestions on how to fix these errors

Think of it like having an IT expert look at your computer's error messages and tell you what to do!

## How It Works
1. **Getting the Errors**
   - Windows keeps a log of all errors in something called "Event Viewer"
   - We'll use PowerShell to read these errors
   - We'll focus on the last 10 error messages

2. **Sending to AI**
   - We'll take these error messages
   - Send them to OpenAI (like ChatGPT)
   - Ask it to analyze them and give us suggestions

3. **Getting Help**
   - The AI will look at each error
   - Tell us what might be causing it
   - Give us simple steps to fix it

## The Code
Here's the simple script that does all this:

```powershell
# Get the last 10 error events from the System log
$events = Get-WinEvent -LogName System -MaxEvents 10 | Where-Object { $_.Level -eq 2 }

# Create a simple text of the events
$eventText = ""
foreach ($event in $events) {
    $eventText += "Time: $($event.TimeCreated)`n"
    $eventText += "Event ID: $($event.Id)`n"
    $eventText += "Message: $($event.Message)`n`n"
}

# Set your OpenAI API key
$env:OPENAI_API_KEY = "your-api-key-here"

# Send to OpenAI
$headers = @{
    "Authorization" = "Bearer $env:OPENAI_API_KEY"
    "Content-Type" = "application/json"
}

$body = @{
    model = "gpt-3.5-turbo"
    messages = @(
        @{
            role = "system"
            content = "You are an IT expert. Analyze these Windows errors and provide simple suggestions to fix them."
        }
        @{
            role = "user"
            content = $eventText
        }
    )
} | ConvertTo-Json

# Make the API call
$response = Invoke-RestMethod -Uri "https://api.openai.com/v1/chat/completions" -Method Post -Headers $headers -Body $body

# Show the response
Write-Host $response.choices[0].message.content
```

## How to Use This
1. You'll need an OpenAI API key (get it from https://platform.openai.com)
2. Replace "your-api-key-here" with your actual API key
3. Run the script in PowerShell

## What You'll Learn
- How to read Windows error logs
- How to work with APIs in PowerShell
- How to use AI to help solve computer problems
- Basic PowerShell commands and concepts

## Try It Yourself!
1. Start with just getting the errors:
```powershell
Get-WinEvent -LogName System -MaxEvents 5
```

2. Then try getting errors from a different log:
```powershell
Get-WinEvent -LogName Application -MaxEvents 5
```

## Important Notes
- Keep your API key secret
- The AI suggestions are helpful but always double-check them
- This is a basic example - you can make it more advanced later

Remember: The goal is to learn how to use PowerShell to get information and how to use AI to help understand that information!

## Understanding the Code

1. Getting Events:
```powershell
$events = Get-WinEvent -LogName System -MaxEvents 10 | Where-Object { $_.Level -eq 2 }
```
- Gets 10 error events from System log

2. Creating Event Text:
```powershell
$eventText = ""
foreach ($event in $events) {
    $eventText += "Time: $($event.TimeCreated)`n"
    $eventText += "Event ID: $($event.Id)`n"
    $eventText += "Message: $($event.Message)`n`n"
}
```
- Creates a simple text format of the events

3. OpenAI API Call:
```powershell
$response = Invoke-RestMethod -Uri "https://api.openai.com/v1/chat/completions" -Method Post -Headers $headers -Body $body
```
- Sends the events to OpenAI
- Gets back analysis and suggestions

## Tips
- You need an OpenAI API key from https://platform.openai.com
- The API key should be kept secret
- You can set the API key permanently using:
```powershell
$env:OPENAI_API_KEY = "your-api-key-here"
```

## Common Event Levels
- 1 = Critical
- 2 = Error
- 3 = Warning
- 4 = Information

Remember: Always keep your API keys secure and never share them!
