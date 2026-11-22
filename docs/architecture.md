# Yohaku Linux architecture

## Current development target

Yohaku Linux is built as a NixOS-based desktop distribution. The first
milestone is a bootable x86_64 Live ISO, not a finished installer.

The initial desktop profile is based on Niri and includes Japanese input,
common desktop utilities, audio, Bluetooth, and NXC.

## Repository boundaries

- `yohaku-linux/os`: distribution Flake, NixOS modules, ISO and release
  configuration.
- `nxc-project/nixos-json-controller`: independently maintained NXC CLI
  and NXC LOUNGE. Yohaku consumes its Flake packages.
- `niri-spatial/depth-workspaces`: independently maintained Niri extension.
  It is not shipped by the initial image while its package and user-facing
  behavior are still under development.

## Reuse from the maintainer's personal configuration

The distribution reuses general desktop choices from the personal NixOS
configuration: Niri, Ly, Xwayland, Wayland portals, Fcitx5/Mozc, Japanese
locale and fonts, Foot, Fuzzel, Waybar, and Mako.

Machine-specific hardware configuration, filesystem UUIDs, personal user
accounts, hostname, and personal application choices are deliberately not
copied into the distribution.

Developer tools and Docker are kept in the optional
`nixos/profiles/developer.nix` profile rather than the default desktop.

## Stability policy

The Flake currently tracks `nixos-unstable` to match the upstream NXC input
and support active integration work. This is a development choice, not a
promise of stable releases. A release branch and update policy should be
selected before publishing an installation image for general users.

## Next milestones

1. Evaluate the Flake and build the Live ISO.
2. Test boot, input, networking, audio, Bluetooth, and NXC in a VM and on
   more than one physical device.
3. Add a reproducible installer and first-boot user setup.
4. Define system update, rollback, release signing, and support policies.
5. Package and integrate depth-workspaces after its behavior and interface
   are stable enough for end users.
