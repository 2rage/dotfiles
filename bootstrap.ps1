# Define the source directory of dotfiles
$sourceDirectory = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Change directory to the location of bootstrap.ps1
Set-Location $sourceDirectory

# Pull latest changes from the branch "windows"
git pull origin windows

function Check-PowershellProfile {
    try {
        # Replace single backslashes with double to avoid errors in regular expressions
        $profileCheck = [regex]::Escape('$powershellProfilePath = "$HOME\.pwsh\powershell_profile.ps1"')
        $profilePath = Join-Path -Path $env:USERPROFILE -ChildPath 'Documents\PowerShell\Microsoft.PowerShell_profile.ps1'
        $profileContent = @"
# Define the path to .pwsh/powershell_profile.ps1
`$powershellProfilePath = "`$HOME\.pwsh\powershell_profile.ps1`"

# Call .pwsh/powershell_profile.ps1
. `$powershellProfilePath
"@

        # Check if the file exists
        if (-not (Test-Path $profilePath)) {
            Write-Host "The PowerShell profile file does not exist at $profilePath. Creating the file..."
            New-Item -Path $profilePath -ItemType File | Out-Null
            # If the file was just created, add the default content
            Add-Content -Path $profilePath -Value $profileContent
            Write-Host "PowerShell profile file created at $profilePath"
        }

        # Check if $PROFILE already contains the needed string
        elseif ((Get-Content $profilePath | Out-String) -notmatch $profileCheck) {
            # If not, add the entire block of code
            Add-Content -Path $profilePath -Value $profileContent
            Write-Host "Added powershell_profile.ps1 path to $profilePath"
        } else {
            Write-Host "New `$PROFILE already exists in $profilePath"
        }
    } catch {
        Write-Host "An error occurred: $_"
    }
}


Check-PowershellProfile


# Function to sync dotfiles to the home directory
function Sync-Files {
    $excludeItems = @(".git/", ".DS_Store", "README.md", "LICENSE-MIT.txt", "bootstrap.ps1")
    $sourceItems = Get-ChildItem -Path $sourceDirectory -Exclude $excludeItems
    foreach ($item in $sourceItems) {
        $destinationPath = Join-Path -Path $HOME -ChildPath $item.Name
        <# 
        # Skip copying if the item is the 'Documents' directory
        if ($item.Name -eq "Documents") {
            Write-Host "Skipping $($item.FullName)"
            continue
        }
        #>
        if (Test-Path $destinationPath) {
            Write-Host "Overwriting $($item.FullName) -> $($destinationPath)"
        } else {
            Write-Host "Copying $($item.FullName) -> $($destinationPath)"
        }
        Copy-Item -Path $item.FullName -Destination $HOME -Recurse -Force
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
