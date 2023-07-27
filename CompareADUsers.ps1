Import-Module ActiveDirectory

# Import List of users
$OldList = Get-Content -Path '.\userList.txt'

# User inputs group name to compare with
$newGroup = Read-Host -Prompt "Type in new group name"

# Retrieve all members of new list
$NewList = Get-ADGroupMember $newGroup | select name -expandproperty name

# Initiating Array for possible problem users
$problemUsers = @()

foreach($user in $OldList)
{
    if ($NewList -contains $user)
    {
        Write-Host "$user OK" -ForegroundColor green
    }
    
    else 
    {
        Write-Host  "$user NOT OK" -ForegroundColor red -BackgroundColor white
        $problemUsers = $problemUsers + $user 
    }
}


$problemUsers | Out-File ".\problemUsers.txt"
$problemCount = $problemUsers.Count
Write-Host "$problemCount have not been added, refer to generated text file if needed."
