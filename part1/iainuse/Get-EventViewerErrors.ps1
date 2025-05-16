#Requires -Version 7.0

# Function to get recent error events from Event Viewer
function Get-RecentErrors {
    param (
        [int]$Hours = 24,
        [int]$MaxEvents = 5
    )
    
    $startTime = (Get-Date).AddHours(-$Hours)
    
    Get-WinEvent -FilterHashtable @{
        LogName = 'System', 'Application'
        Level = 1, 2  # Error and Critical
        StartTime = $startTime
    } -MaxEvents $MaxEvents | ForEach-Object {
        @{
            TimeCreated = $_.TimeCreated
            LogName = $_.LogName
            Level = $_.Level
            Message = $_.Message
            EventId = $_.Id
        }
    }
}

# Function to analyze errors with OpenAI
function Invoke-OpenAIAnalysis {
    param (
        [Parameter(Mandatory=$true)]
        [array]$Events
    )
    
    # You need to set your OpenAI API key as an environment variable
    $apiKey = $env:OPENAI_API_KEY
    if (-not $apiKey) {
        Write-Error "Please set your OpenAI API key as an environment variable: OPENAI_API_KEY"
        return
    }

    # Prepare the prompt
    $prompt = "As an IT expert, analyze these Windows Event Viewer errors and provide suggestions for fixing them:`n`n"
    foreach ($event in $Events) {
        $prompt += "Time: $($event.TimeCreated)`n"
        $prompt += "Log: $($event.LogName)`n"
        $prompt += "Event ID: $($event.EventId)`n"
        $prompt += "Message: $($event.Message)`n`n"
    }

    # Prepare the API request
    $headers = @{
        "Authorization" = "Bearer $apiKey"
        "Content-Type" = "application/json"
    }

    $body = @{
        model = "gpt-3.5-turbo"
        messages = @(
            @{
                role = "system"
                content = "You are an IT expert specializing in Windows systems. Provide clear, actionable suggestions for fixing the errors."
            }
            @{
                role = "user"
                content = $prompt
            }
        )
        temperature = 0.7
    } | ConvertTo-Json

    try {
        $response = Invoke-RestMethod -Uri "https://api.openai.com/v1/chat/completions" `
            -Method Post `
            -Headers $headers `
            -Body $body

        return $response.choices[0].message.content
    }
    catch {
        Write-Error "Error calling OpenAI API: $_"
        return $null
    }
}

# Main script execution
Write-Host "Getting recent error events from Event Viewer..." -ForegroundColor Cyan
$errors = Get-RecentErrors -Hours 24 -MaxEvents 5

if ($errors.Count -eq 0) {
    Write-Host "No recent errors found in the Event Viewer." -ForegroundColor Green
    exit
}

Write-Host "`nFound $($errors.Count) recent errors. Analyzing with OpenAI..." -ForegroundColor Cyan
$analysis = Invoke-OpenAIAnalysis -Events $errors

if ($analysis) {
    Write-Host "`nOpenAI Analysis and Suggestions:" -ForegroundColor Green
    Write-Host $analysis
} 