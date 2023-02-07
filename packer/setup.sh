#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo pacman-key --init
sudo pacman-key --populate
sudo reflector --country "Germany" --protocol https,http\
    --score 20 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman --noconfirm -Syyu

sudo pacman --noconfirm -S docker make python python-pip tox\
    python-pytest python-pytest-cov python-pytest-black
