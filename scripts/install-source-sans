#!/usr/bin/env bash
set -eu

wget -O ~/source-sans.zip https://github.com/adobe-fonts/source-sans/releases/download/3.052R/OTF-source-sans-3.052R.zip
mkdir -p ~/source-sans-fonts
unzip ~/source-sans.zip -d ~/source-sans-fonts
mkdir -p ~/.fonts
find ~/source-sans-fonts -type f -name "*.otf" -exec cp {} ~/.fonts \;
rm ~/source-sans.zip
rm -rf ~/source-sans-fonts
fc-cache -f -v
