# Yohaku Linux

**余白から、新しいデスクトップ体験を。**

Yohaku Linux is an independent desktop distribution based on NixOS.

The project aims to combine a reproducible NixOS foundation, a carefully
configured desktop experience, and approachable system management tools.

## Current development status

This repository is at the initial bring-up stage. The first target is an
x86_64 Live ISO using Niri, Japanese input, common desktop utilities, and
NXC. It is not yet an installation-ready or stable release.

## Project components

- **NixOS / Nixpkgs** — operating-system and package foundation.
- **NXC** — system and package management CLI / NXC LOUNGE GUI.
  [Source repository](https://github.com/nxc-project/nixos-json-controller)
- **Niri** — Wayland compositor used by the initial desktop profile.
- **depth-workspaces** — planned integration after the independent project
  is packaged and ready for everyday use.
  [Source repository](https://github.com/niri-spatial/depth-workspaces)

## Build the development ISO

On a NixOS or Linux system with Nix flakes enabled:

```sh
nix flake lock
nix flake check --no-build
nix build .#iso -L
```

The ISO is produced under `result/iso/`.

The initial Flake targets `x86_64-linux` and follows `nixos-unstable`.
The generated `flake.lock` pins the exact inputs used for a build.

## Test in QEMU

```sh
ISO="$(find -L result/iso -name '*.iso' -print -quit)"

nix shell nixpkgs#qemu --command \
  qemu-system-x86_64 \
  -m 4096 \
  -smp 4 \
  -cdrom "$ISO" \
  -boot d
```

## Repository layout

- `flake.nix` — distribution entry point and ISO output.
- `nixos/modules/` — reusable NixOS modules.
- `nixos/iso/` — live installation media configuration.
- `nixos/profiles/` — optional system profiles.
- `docs/` — architecture and development notes.

## Important

- Do not copy a machine's generated `hardware-configuration.nix` or disk
  UUIDs into the distribution-wide configuration.
- The Live ISO auto-login is limited to the disposable `nixos` live user.
  Installed systems must create their own user during installation.
- Proprietary applications are not enabled by default. Their redistribution
  and licensing requirements must be reviewed before inclusion.
- This is an experimental development image. Test it in a VM before using
  it on physical hardware.
