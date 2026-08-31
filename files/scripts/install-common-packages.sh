#!/usr/bin/env bash
set -eoux pipefail

rpm-ostree install -y \
    cockpit \
    git \
    distrobox \
    zsh \
    btop \
    tailscale \
    newt \
    lorax \
    xorriso

curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir /usr/bin