## Working with Dates and Time

In PowerShell, working with dates and times is a common task, and the `Get-Date` cmdlet is your trusty companion for this. It returns a `DateTime` object, which is much more than just a simple string or number.

```powershell
$today = Get-Date

# Display the full DateTime object
$today
# Access specific properties
$today.Year
$today.Month
$today.Day
$today.Hour
```

### Exploring Get-Date with Get-Member

The `Get-Member` cmdlet is a powerful tool for discovering the properties and methods of objects in PowerShell. We can use it to explore the `DateTime` object returned by `Get-Date`:

```powershell
Get-Date | Get-Member
```

```powershell
Get-Date | Get-Member -MemberType Property
Get-Date | Get-Member -MemberType Method
```


This command will display all the properties and methods available on the `DateTime` object. Some key properties include:

- `Date`: Gets the date component of the `DateTime` object.
- `DayOfWeek`: Gets the day of the week represented by this `DateTime` instance.
- `DayOfYear`: Gets the day of the year represented by this `DateTime` instance.
- `TimeOfDay`: Gets the time of day for this instance.

You can also use `Get-Member` to explore specific property types:

```powershell
Get-Date | Get-Member -MemberType Property
Get-Date | Get-Member -MemberType Method
```

These commands will show you only the properties or methods of the `DateTime` object, respectively.

### Formatting Dates

[Microsoft Format Datetime](https://learn.microsoft.com/en-us/system-center/orchestrator/standard-activities/format-date-time?view=sc-orch-2022)

```powershell
Get-Date -Format "yyyy-MM-dd" # Outputs: 2023-04-15
Get-Date -Format "dddd, MMMM dd, yyyy" # Outputs: Saturday, April 15, 2023
Get-Date -Format "HH:mm:ss" # Outputs: 14:30:45
```

### Date Arithmetic

```powershell
$tomorrow = (Get-Date).AddDays(1)
$lastWeek = (Get-Date).AddDays(-7)
$twoHoursLater = (Get-Date).AddHours(2)
```

### Exercise: Calculate Your Age in Days and Hours

Use Get-Help to learn about the -Date parameter of Get-Date.


#### Exercise:

1. Using get-date with format create an object of the type datetime that it is representing your birthday
2. Check how many days you have been alive, how many weeks, how many minutes.
3. How many days till Xmas

<details>
<summary>Click to reveal the solution</summary>

Here's a complete solution to the exercise, including the bonus challenges:

```powershell

$myBirthInfo = @{
    Year = "1982"
    Month = "5"
    Day = "7"
}

$myBirthDate = Get-Date -Year $myBirthInfo.Year -Month $myBirthInfo.Month -Day $myBirthInfo.Day

# Step 3: Calculate days alive
$daysAlive = (Get-Date) - $myBirthDate
$daysAlive.TotalDays

# Step 4: Calculate hours alive
$totalHours = [math]::Round($daysAlive.TotalHours)

# Bonus 1: Calculate weeks alive
$totalWeeks = $daysAlive.TotalDays / 7




```

This solution demonstrates:


</details>
