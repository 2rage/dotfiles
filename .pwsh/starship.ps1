# Find out which distribution we are running on
$LFILE = "/etc/os-release"
$MFILE = "/System/Library/CoreServices/SystemVersion.plist"

if (Test-Path $LFILE) {
    $_distro = (Get-Content $LFILE | Select-String -Pattern '^ID=').ToString().Split('=')[1].ToLower()
} elseif (Test-Path $MFILE) {
    $_distro = "macos"

    # On macOS use the system_profiler to determine the current model
    $_device = (system_profiler SPHardwareDataType | Select-String -Pattern 'Model Name').ToString().Split(':')[1].Trim()

    switch -Regex ($_device) {
        ".*MacBook.*" { $DEVICE = "󰌢"; break }
        ".*mini.*" { $DEVICE = "󰇄"; break }
        default { $DEVICE = ""; break }
    }
} elseif ($env:OS -match "Windows_NT") {
    $_distro = "windows"
    # Additional logic to determine device or version info on Windows
}

# Set an icon based on the distribution
# Make sure your font is compatible with https://github.com/lukas-w/font-logos
switch ($_distro) {
    "kali"          { $ICON = "󰠥"; break }
    "arch"          { $ICON = ""; break }
    "debian"        { $ICON = ""; break }
    "raspbian"      { $ICON = ""; break }
    "ubuntu"        { $ICON = ""; break }
    "elementary"    { $ICON = ""; break }
    "fedora"        { $ICON = ""; break }
    "coreos"        { $ICON = ""; break }
    "gentoo"        { $ICON = ""; break }
    "mageia"        { $ICON = ""; break }
    "centos"        { $ICON = ""; break }
    "opensuse"      { $ICON = ""; break }
    "tumbleweed"    { $ICON = ""; break }
    "sabayon"       { $ICON = ""; break }
    "slackware"     { $ICON = ""; break }
    "linuxmint"     { $ICON = ""; break }
    "alpine"        { $ICON = ""; break }
    "aosc"          { $ICON = ""; break }
    "nixos"         { $ICON = ""; break }
    "devuan"        { $ICON = ""; break }
    "manjaro"       { $ICON = ""; break }
    "rhel"          { $ICON = ""; break }
    "macos"         { $ICON = "󰀵"; break }
    "windows"       { $ICON = ""; break }
    default         { $ICON = ""; break }
}

$env:STARSHIP_DISTRO = $ICON
$env:STARSHIP_DEVICE = $DEVICE
