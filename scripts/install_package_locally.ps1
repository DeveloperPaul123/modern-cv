# requires the PSToml cmdlet to be installed
# https://github.com/jborean93/PSToml?tab=readme-ov-file
# Install-Module -Name PSToml -Scope AllUsers

$typst_toml = ConvertFrom-Toml (Get-Content "$PSScriptRoot/../typst.toml" -Raw)
Write-Host 'Package version: ' $typst_toml.package.version
$Source = "$PSScriptRoot/../*"
$Destination = "$env:LOCALAPPDATA/typst/packages/local/modern-cv/$($typst_toml.package.version)"
New-Item -ItemType Directory -Path $Destination -Force
Copy-Item -Path $Source -Destination $Destination -Recurse -Force
