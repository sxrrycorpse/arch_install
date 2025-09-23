#!/bin/bash

# Automated-Arch-Install-w/Bash

# Update mirrorlist
reflector --country India --latest 10 --sort rate --save /etc/pacman.d/mirrorlist --verbose
