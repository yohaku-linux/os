# Yohaku Linux architecture

## Current development target

Yohaku Linux starts as a NixOS configuration project. The first goal is
to organize and validate a reusable desktop configuration before adding
distribution-specific applications, branding, or behavior.

The initial configuration reuses settings from the maintainer's existing
NixOS setup:

- Niri, Ly, Xwayland, and XDG portals
- Japanese locale, Fcitx5/Mozc, and Japanese fonts
- Foot, Fuzzel, Waybar, Mako, and selected Wayland utilities
- NetworkManager, Asia/Tokyo timezone, Nix Flakes, and nix-ld

An experimental guided installer is part of the development Live image.
It uses the shared NixOS modules and generates a hardware-specific
configuration during installation.

## Repository boundaries

- `yohaku-linux/os`: shared NixOS configuration, optional profiles,
  development Live image, and its installer.
- `nxc-project/nixos-json-controller`: independently maintained NXC
  project. It is not integrated into the initial system configuration.
- `niri-spatial/depth-workspaces`: independently maintained Niri
  extension. It is not integrated while it remains under development.

## Personal configuration exclusions

The distribution configuration does not copy:

- machine-specific hardware configuration or filesystem UUIDs
- the maintainer's personal user account and host name
- personal application selections such as Chrome, VS Code, Obsidian,
  and Vesktop into the default image
- Docker and development tools into the default desktop profile

Development tools are kept in the optional
`nixos/profiles/developer.nix` module.

## Current scope

There are no Yohaku-specific desktop patches, custom Niri keybindings,
custom package manager, or branded system identity in this initial stage.
The objective is to keep the configuration close to upstream NixOS and
make it easy to understand and test.

The first installer deliberately has a narrow scope: whole-disk
installation using GPT and ext4, with either UEFI or legacy BIOS boot.
It creates one normal user account and sets the password interactively
inside the installed system. It does not yet preserve existing
partitions, configure encryption, or support dual-boot layouts.

## Next milestones

1. Rebuild and evaluate the Live image with the installer included.
2. Test the installer in QEMU using a separate virtual disk.
3. Verify first boot, Ly login, Niri, Japanese input, networking, and
   password-authenticated sudo on the installed system.
4. Test hardware compatibility on physical hardware.
5. Decide which settings should be common defaults and which should
   remain optional; then consider installer UX and distribution branding.
