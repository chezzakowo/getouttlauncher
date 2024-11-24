# Define the Mods folder path
$ModsFolder = "C:\Users\Dell\AppData\Roaming\.minecraft\mods"

# Remove the existing Mods folder
if (Test-Path $ModsFolder) {
    Remove-Item $ModsFolder -Recurse -Force
}

# Recreate the Mods folder
New-Item -Path "C:\Users\Dell\AppData\Roaming\.minecraft" -Name "mods" -ItemType "directory" -Force

# Get the ACL for the newly created folder
$Acl = Get-Acl $ModsFolder

# Create a new access rule to deny write permissions to the SYSTEM user
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule(
    "NT AUTHORITY\SYSTEM",
    "Write",
    "ContainerInherit,ObjectInherit",
    "None",
    "Deny"
)

# Add the new access rule to the ACL
$Acl.SetAccessRule($Ar)

# Apply the updated ACL to the Mods folder
Set-Acl $ModsFolder $Acl

Write-Host "Đã cho mod TLCape ra chuồng gà."
