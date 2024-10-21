# File Search and Manipulation Exercise

This exercise is designed to help you practice file searching and manipulation skills using PowerShell. The `CreateDataStructure.ps1` script has generated a set of files with various properties in the `FindFileExercise` folder.

## Your Tasks

Using PowerShell commands, complete the following exercises. They are arranged from easiest to most challenging:

### 1. Basic File Search
Find and list all files in the `FindFileExercise` folder that have "PSCourse" in their name.

### 2. Date-based Search
Find the file created before 1990.

### 3. Size-based Search and Sorting
Find the 3 largest files in the entire directory structure. Display their names, sizes, and locations.

### 4. Complex Date Range Search
Find all files created between June 1, 2020, and July 31, 2020. Display their names and exact creation dates.

### 5. Advanced Filtering and Calculations
Find all files larger than 1MB (1 million bytes) that were created in the last 5 years. Calculate and display the total size of these files in GB.

## Tips

- Use `Get-ChildItem` (alias `dir` or `ls`) to list files and folders
- The `-Recurse` parameter allows you to search subfolders
- `Where-Object` (alias `where`) can help you filter files based on their properties
- `Sort-Object` (alias `sort`) can order files by size or date
- `Select-Object` (alias `select`) can limit the number of results or choose specific properties to display
- `Measure-Object` (alias `measure`) can help with calculations like sum and average

## Example Command

Here's an example of how you might start your search for Exercise 1:

```powershell
Get-ChildItem -Path .\FindFileExercise -Recurse -File | Where-Object { $_.Name -like "*PSCourse*" }
```

## Submission

For each exercise, provide:
1. The PowerShell command(s) you used to complete the task
2. The output of your command(s)
3. A brief explanation of how your command works

