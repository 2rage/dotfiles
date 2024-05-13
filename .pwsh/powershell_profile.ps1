# init starship
Invoke-Expression (&starship init powershell)

# init starship powershell config
if (Test-Path ~/.pwsh/starship.ps1) {
    . ~/.pwsh/starship.ps1
}
