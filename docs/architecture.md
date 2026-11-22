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

## Repository boundaries

- `yohaku-linux/os`: shared NixOS configuration, optional profiles, and
  development Live image.
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

## Next milestones

1. Evaluate the Flake and build the development Live image.
2. Confirm the desktop, Japanese input, network, and common utilities work.
3. Decide which settings should be common defaults and which should remain
   optional.
4. Only after the base is stable, consider installation, distribution
   branding, update policy, and independent components.
