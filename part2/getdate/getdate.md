## Working with Dates and Time

In PowerShell, working with dates and times is a common task, and the `Get-Date` cmdlet is your trusty companion for this. It returns a `DateTime` object, which is much more than just a simple string or number.

```powershell
$today = Get-Date

Display the full DateTime object
$currentDateTime
Access specific properties
$currentDateTime.Year
$currentDateTime.Month
$currentDateTime.Day
$currentDateTime.Hour
```


```powershell
Get-Date -Format "yyyy-MM-dd" # Outputs: 2023-04-15
Get-Date -Format "dddd, MMMM dd, yyyy" # Outputs: Saturday, April 15, 2023
Get-Date -Format "HH:mm:ss" # Outputs: 14:30:45
```

```powershell
$tomorrow = (Get-Date).AddDays(1)
$lastWeek = (Get-Date).AddDays(-7)
$twoHoursLater = (Get-Date).AddHours(2)
```




### Exercise: Calculate Your Age in Days and Hours

Use Get-Help to learn about the -Date parameter of Get-Date.


#### Solution:

<details>
<summary>Click to reveal the solution</summary>

Here's a complete solution to the exercise, including the bonus challenges:

```powershell


$myBirthDate = Get-Date -Year $myBirthInfo.Year -Month $myBirthInfo.Month -Day $myBirthInfo.Day

# Step 3: Calculate days alive
$daysAlive = (Get-Date) - $myBirthDate
$totalDays = [math]::Round($daysAlive.TotalDays)

# Step 4: Calculate hours alive
$totalHours = [math]::Round($daysAlive.TotalHours)

# Bonus 1: Calculate weeks alive
$totalWeeks = [math]::Round($daysAlive.TotalDays / 7)

# Bonus 2: Calculate minutes alive
$totalMinutes = [math]::Round($daysAlive.TotalMinutes)

# Bonus 3: Calculate next birthday and days until then
$nextBirthday = Get-Date -Year (Get-Date).Year -Month $myBirthInfo.Month -Day $myBirthInfo.Day
if ($nextBirthday -lt (Get-Date)) {
    $nextBirthday = $nextBirthday.AddYears(1)
}
$daysUntilNextBirthday = ($nextBirthday - (Get-Date)).Days

# Display the results
Write-Host "You have been alive for approximately:"
Write-Host "$totalDays days"
Write-Host "$totalHours hours"
Write-Host "$totalWeeks weeks"
Write-Host "$totalMinutes minutes"
Write-Host ""
Write-Host "Your next birthday is on $($nextBirthday.ToString('dddd, MMMM dd, yyyy'))"
Write-Host "There are $daysUntilNextBirthday days until your next birthday"
```

This solution demonstrates:

1. How to create a DateTime object from a hashtable of birth information.
Calculating the time span between two dates using subtraction.
Using the TotalDays, TotalHours, and TotalMinutes properties of a TimeSpan object.
4. Rounding numbers using [math]::Round().
Calculating the next birthday, including adjusting for when the birthday has already passed this year.
Formatting date output using the ToString() method with a custom format string.
Remember, the actual output will depend on your birth date and the current date when you run the script. The numbers you see will be unique to you!
Explanation of Bonus Challenges:
1. Weeks alive: We divide the total days by 7 to get the number of weeks.
Minutes alive: We use the TotalMinutes property of the TimeSpan object.
Next birthday: We create a date for this year's birthday, then check if it's already passed. If so, we add a year. We then calculate the days until this date.
This exercise showcases the versatility of DateTime objects and TimeSpan calculations in PowerShell. It's a practical example of how these concepts can be applied to real-world scenarios, like calculating ages or planning for future dates.
</details>