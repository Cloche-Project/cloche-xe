#!/bin/bash
set -eoux pipefail

# cloche-rpm.repo is laid down by the "files" module (source: common), which
# runs before this script, so the repo is available here.
rpm-ostree install -y --force-replacefiles cloche-kde-defaults plasma-applet-appgrid

# Set boot animation
plymouth-set-default-theme spinner
dracut -f --regenerate-all

echo "Removing upstream default wallpapers"
rm -f /usr/share/backgrounds/convergence.png
rm -f /usr/share/backgrounds/convergence.jxl
rm -f /usr/share/backgrounds/default.png
rm -f /usr/share/backgrounds/default-dark.png
rm -f /usr/share/backgrounds/default.jxl

echo "Setting Cloche logo symlinks"
ln -sf /usr/share/wallpapers/Cloche-Default/contents/images/3840x2025.webp /usr/share/backgrounds/default.png
ln -sf /usr/share/wallpapers/Cloche-Default/contents/images/3840x2025-dark.webp /usr/share/backgrounds/default-dark.png

# Fastfetch patch for distrobox
if [ -f /etc/skel/.bashrc ]; then
    sed -i '/alias fastfetch/d' /etc/skel/.bashrc
fi

if [ -f /etc/skel/.zshrc ]; then
    sed -i '/alias fastfetch/d' /etc/skel/.zshrc
fi