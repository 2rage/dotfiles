# Define the source directory of dotfiles
$sourceDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Change directory to the location of bootstrap.ps1
Set-Location $sourceDirectory

# Pull latest changes from the repository
git pull origin windows

# Function to sync dotfiles to the home directory
function Sync-Files {
    $excludeItems = @(".git/", ".DS_Store", "README.md", "LICENSE-MIT.txt", "bootstrap.ps1")
    $sourceItems = Get-ChildItem -Path $sourceDirectory -Exclude $excludeItems
    foreach ($item in $sourceItems) {
        $destinationPath = Join-Path -Path $HOME -ChildPath $item.Name
        if (Test-Path $destinationPath) {
            Write-Host "Overwriting $($item.FullName) -> $($destinationPath)"
        } else {
            Write-Host "Copying $($item.FullName) -> $($destinationPath)"
        }
        Copy-Item -Path $item.FullName -Destination $HOME -Recurse -Force
    }
    # Source the appropriate shell configuration file
    $powershellProfilePath = Join-Path -Path $HOME -ChildPath "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    if (Test-Path $powershellProfilePath) {
        Write-Host "Sourcing PowerShell profile $($powershellProfilePath)"
        . $powershellProfilePath
    }
}


# Check if the script is run with force flag or interactively
if ($args[0] -eq "--force" -or $args[0] -eq "-f") {
    Sync-Files
} else {
    $reply = Read-Host "This may overwrite existing files in your home directory. Are you sure? (y/n)"
    if ($reply -eq "y" -or $reply -eq "Y") {
        Sync-Files
    }
}
