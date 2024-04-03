# requires typstyle to be installed
# cargo install typstyle

# get all *.typ files and format them
Get-ChildItem -Path $PSScriptRoot/../*.typ -Recurse | ForEach-Object { typstyle -i $_.FullName }