$snow_vms =  $snow_vms | Select-Object *,
@{n="disk_size"; e={$_.UsedSpaceGB}},
@{n="memory"; e={$_.memorygb * 1024}},
@{n="cpus"; e={$_.NumCPU}},
@{n="state"; e={($_.PowerState).TrimStart("Powered")},
@{n="operational_status"; e={ "1" }}
