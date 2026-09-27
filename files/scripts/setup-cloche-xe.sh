#!/bin/bash
set -eoux pipefail

# bazzite ships a steamdeck-kde-presets* package that owns /etc/xdg/kdeglobals
# and /etc/xdg/kscreenlockerrc — the same files cloche-kde-defaults ships. The
# exact package name differs across bazzite variants (steamdeck-kde-presets on
# bazzite-deck, steamdeck-kde-presets-desktop on plain bazzite), so resolve it
# from the conflicting file itself instead of hardcoding a name.
# --force-replacefiles doesn't cover this (it only arbitrates between packages
# in the same transaction, not files already committed in the base image), so
# the conflicting package has to go before cloche-kde-defaults can install.
conflicting_pkg=$(rpm -qf /etc/xdg/kdeglobals --qf '%{NAME}\n' 2>/dev/null || true)
if [ -n "$conflicting_pkg" ]; then
    rpm-ostree override remove "$conflicting_pkg"
fi

# cloche-rpm.repo is laid down by the "files" module (source: common), which
# runs before this script, so the repo is available here.
rpm-ostree install -y cloche-kde-defaults plasma-applet-appgrid

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