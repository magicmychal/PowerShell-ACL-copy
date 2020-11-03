## This script copies the permission of selected $sampleFolder 
## and overwrites with the same permissions all of the main folders within the #rootFolder

$rootFolder = "<ENTER PATH HERE>"
$folders = Get-ChildItem $rootFolder |
        Where-Object {$_.PSIsContainer} |
        Foreach-Object {$_.Name}


Write-Host "Showing permissions for folders in $sampleFolder"


$folders | ForEach-Object  {
    Write-Host "Permissions on $_"
    Get-Acl "$rootFolder\$_" | Format-List
} 



