typst compile -f png $PSScriptRoot/../template/resume.typ $PSScriptRoot/../assets/images/resume.png
typst compile -f png $PSScriptRoot/../template/coverletter.typ $PSScriptRoot/../assets/images/coverletter.png

oxipng.exe $PSScriptRoot/../assets/images/*
