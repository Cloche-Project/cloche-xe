*[Leia em Português](README.pt-BR.md)*

<p align="center">
  <picture>
    <img src="cloche-logo/watermark.png" alt="Cloche OS Logo" height="80" />
  </picture>
</p>

<p align="center">
    <strong>Performance & Gaming Workstation</strong>
</p>

<p align="center">
  <strong>Cloche Xe</strong> is a series of immutable, container-native desktop images built on top of Bazzite, aimed at a performance- and gaming-oriented workstation — including a Steam Deck-optimized variant.
</p>

<p align="center">
  <a href="https://github.com/cloche-project/cloche-xe/actions/workflows/build.yml">
    <img src="https://github.com/cloche-project/cloche-xe/actions/workflows/build.yml/badge.svg" alt="Build Status" />
  </a>
  <a href="https://ghcr.io/cloche-project/cloche-xe">
    <img src="https://img.shields.io/badge/registry-GHCR-blue?logo=github" alt="GHCR Registry" />
  </a>
  <img src="https://img.shields.io/github/license/cloche-project/cloche-xe" alt="License" />
</p>

> [!NOTE]
> **Cloche Xe inherits from [Bazzite](https://github.com/ublue-os/bazzite) rather than the Cloche Headless Base.** It layers the same Cloche desktop defaults (`cloche-gnome-defaults`/`cloche-kde-defaults` from [`rpm-repo`](https://github.com/cloche-project/rpm-repo)) on top of Bazzite's gaming/performance stack, instead of building the desktop up from scratch the way `cloche-standard` does.

---

## Available Variants

| Image Name | Desktop Environment | Target Use Case |
|------------|---------------------|-----------------|
| `cloche-xe` | KDE Plasma | Performance/gaming-oriented workstation |
| `cloche-xe-gnome` | GNOME (Wayland native) | Performance/gaming-oriented workstation |
| `cloche-xe-deck` | KDE Plasma | Optimized for Steam Deck |
| `cloche-xe-deck-gnome` | GNOME | Optimized for Steam Deck |

---

## Core Desktop Architecture

| Component | Details |
|-----------|---------|
| **Base Layer** | Bazzite (`ghcr.io/ublue-os/bazzite[-gnome\|-deck\|-deck-gnome]`), tracking the `stable`/`testing` channel — Bazzite doesn't use a rolling `latest` tag |
| **Package Install** | `script` module (`install-*-packages.sh`, `setup-cloche-xe*.sh`) installing `cloche-gnome-defaults`/`cloche-kde-defaults` from the Cloche `rpm-repo`, the same RPMs `cloche-standard` uses |
| **App Delivery** | Flatpak, with a curated set of default apps pre-installed system-wide |
| **Hardware Support** | Inherits Bazzite's gaming-focused driver stack and performance tuning |

---

## Key Desktop Features

* **Shared Desktop Defaults:** GNOME/Plasma theming, wallpapers, and shell configuration come from the same `cloche-*-defaults` RPMs used by `cloche-standard`, keeping the desktop experience consistent across the Cloche family.
* **Gaming-Ready Base:** Built on Bazzite, so gamemode, controller support, and GPU driver handling come pre-tuned out of the box.
* **Curated Flatpaks:** Ships a default set of apps (VSCodium, Podman Desktop, Amberol, LocalSend, Resources, and more) via `default-flatpaks`, with a Blender/Gear Lever-focused set on the Deck variant.
* **Steam Deck Variant:** `cloche-xe-deck`/`cloche-xe-deck-gnome` build on Bazzite's own Deck images for the handheld form factor.

---

## Deployment & Installation

### Remote Rebase

To migrate an existing Fedora Atomic workstation to Cloche Xe, choose your preferred variant and execute:

```bash
# Example: Rebasing to the Plasma variant
rpm-ostree rebase ostree-unverified-registry:ghcr.io/cloche-project/cloche-xe:latest

# Or for the GNOME variant
rpm-ostree rebase ostree-unverified-registry:ghcr.io/cloche-project/cloche-xe-gnome:latest
```

### Apply the desktop layers by rebooting your system:

```bash
systemctl reboot
```

### Post-Installation Recommended Steps

* **Verify Layers:** Run `rpm-ostree status` to ensure the base and local overrides match expectations.
* **Setup Flatpaks:** Flatpak remotes are configured at system level; user-space apps can be added without root privileges via Software Center or CLI.

---

## Verification & Security

Every desktop image build is signed via Sigstore Cosign against the repository's public verification key.

```bash
# Verify the specific desktop variant layer
cosign verify --key cosign.pub ghcr.io/cloche-project/cloche-xe:latest
```

## License & Acknowledgments

* Licensed under Apache 2.0
* Built on top of the [Bazzite](https://github.com/ublue-os/bazzite) image from Universal Blue
* Shares desktop defaults with `cloche-project/cloche-standard` via `cloche-project/rpm-repo`
* Powered by the BlueBuild framework and Universal Blue project engines
