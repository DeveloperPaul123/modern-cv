#!/usr/bin/env bash
set -eu

wget -O ~/fontawesome.zip https://use.fontawesome.com/releases/v6.6.0/fontawesome-free-6.6.0-desktop.zip
mkdir -p ~/fontawesome-fonts
unzip ~/fontawesome.zip -d ~/fontawesome-fonts
mkdir -p ~/.fonts
find ~/fontawesome-fonts -type f -name "*.otf" -exec cp {} ~/.fonts \;
rm ~/fontawesome.zip
rm -rf ~/fontawesome-fonts
fc-cache -f -v
