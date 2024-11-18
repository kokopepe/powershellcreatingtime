function Move-OldLogFiles {
    param (
        $source= "C:\Logs",
        $destination = "C:\temp\oldlogs"
    )

    Get-ChildItem -Path $source -Filter *.log | Move-Item -Destination $destination
}