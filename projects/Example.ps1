# Get current date
$currentDate = Get-Date
# Calculate date 6 months ago
$sixMonthsAgo = $currentDate.AddMonths(-6)

# Function to format file size in readable format
function Format-FileSize {
    param([long]$size)
    $sizes = 'Bytes,KB,MB,GB,TB'
    $sizes = $sizes.Split(',')
    $index = 0
    while ($size -ge 1kb -and $index -lt ($sizes.Count - 1)) {
        $size = $size / 1kb
        $index++
    }
    return "{0:N2} {1}" -f $size, $sizes[$index]
}

# Prompt user for the path to search
$searchPath = Read-Host "Enter the path to search (e.g., C:\Users\YourUsername\Documents)"

# Verify if path exists
if (-not (Test-Path $searchPath)) {
    Write-Host "The specified path does not exist." -ForegroundColor Red
    exit
}
