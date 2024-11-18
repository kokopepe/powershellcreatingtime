Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Get the root folder from user input
$rootFolder = Read-Host "Enter the path to the root folder"

# Function to get folder size
function Get-FolderSize {
    param ([string]$folderPath)
    $size = (Get-ChildItem -Path $folderPath -Recurse -File | Measure-Object -Property Length -Sum).Sum
    return $size
}

# Get all subfolders
$folders = Get-ChildItem -Path $rootFolder -Directory

# Create an array to store folder information
$folderInfo = @()

foreach ($folder in $folders) {
    $size = Get-FolderSize -folderPath $folder.FullName
    $sizeGB = [math]::Round($size / 1GB, 2)
    $folderInfo += [PSCustomObject]@{
        Name = $folder.Name
        Path = $folder.FullName
        SizeBytes = $size
        SizeGB = $sizeGB
    }
}

# Sort folders by size (largest first)
$sortedFolders = $folderInfo | Sort-Object -Property SizeBytes -Descending

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Folder Sizes'
$form.Size = New-Object System.Drawing.Size(600,400)
$form.StartPosition = 'CenterScreen'

# Create the ListView
$listView = New-Object System.Windows.Forms.ListView
$listView.View = [System.Windows.Forms.View]::Details
$listView.FullRowSelect = $true
$listView.Location = New-Object System.Drawing.Point(10,10)
$listView.Size = New-Object System.Drawing.Size(560,300)

# Add columns to the ListView
$listView.Columns.Add("Folder Name", 300)
$listView.Columns.Add("Size (GB)", 100)

# Add items to the ListView
foreach ($folder in $sortedFolders) {
    $item = New-Object System.Windows.Forms.ListViewItem($folder.Name)
    $item.SubItems.Add($folder.SizeGB.ToString())
    $item.Tag = $folder.Path
    $listView.Items.Add($item)
}

# Add double-click event to open folders
$listView.Add_DoubleClick({
    $selectedItem = $listView.SelectedItems[0]
    if ($selectedItem) {
        Start-Process "explorer.exe" $selectedItem.Tag
    }
})

# Add the ListView to the form
$form.Controls.Add($listView)

# Show the form
$form.ShowDialog()
