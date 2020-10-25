<#
This script clopies permissions (ACL) of a selected $sampleFoder and overwrites
with the same permissions in the $folders list

How-to Use:
1. Specify the $rootFolder
2. Specify the $sampleFolder - it's a foder from which ACL will be copied 
 #>

$rootFolder = "J:\01 - D&D"
$sampleFolder = "J:\test"

$folders = Get-ChildItem $rootFolder |
        Where-Object {$_.PSIsContainer} |
        Foreach-Object {$_.Name}


$successful = @()

Write-Host "Default permission for $sampleFolder"
Get-Acl $sampleFolder | Format-List

Measure-Command {
    $folders | ForEach-Object -Parallel {
        try {
            Write-Host "Setting up permissions on $_"_
            # 3. Replace the Get-Acl folder with the samplefolder as well as the patch. TODO: fix the issue here
            # TODO: Get-Acl returns error when using the $rootFolder variable 
            Get-Acl "J:\test" | Set-Acl -Path "J:\01 - D&D\$_"
            Write-Host "All good on $_. Moving on"
            $successful.Add($_)
        } catch {
            Write-Host "Something went wront with $_"
        }
    } -ThrottleLimit 6 
    # Set how many parallel task are allowed 
}


