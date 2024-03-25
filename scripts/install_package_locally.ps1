$Source = "$PSScriptRoot/../*"
$Destination = "$env:LOCALAPPDATA/typst/packages/local/modern-cv/0.1.0"
Copy-Item -Path $Source -Destination $Destination -Recurse -Force
