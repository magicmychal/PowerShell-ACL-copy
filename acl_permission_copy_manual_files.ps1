# Variation. Manually enter the folders that must be changed
$sampleFolder = "J:\test"
 
 $folders = ""
 
 $successful = @()
 
 Write-Host "Default permission for $sampleFolder"
 Get-Acl $sampleFolder | Format-List
 
 Measure-Command {
     $folders | ForEach-Object -Parallel {
         try {
             Write-Host "Setting up permissions on $_"
             # 3. Replace the Get-Acl folder with the samplefolder as well as the patch. TODO: fix the issue here
             Get-Acl "J:\test" | Set-Acl -Path "$_"
             Write-Host "All good on $_. Moving on"
             $successful.Add($_)
         } catch {
             Write-Error "Error mesage: $_"
         }
     } -ThrottleLimit 6 
     # Set how many parallel task are allowed 
     
 }
 
 
 