# Yohaku Linux

**余白から、新しいデスクトップ体験を。**

Yohaku Linux begins as a NixOS-based configuration project. The initial
work focuses on organizing and testing a general desktop setup based on
the maintainer's existing NixOS configuration.

## Current status

This repository is at the initial configuration stage. It is not yet a
finished distribution or a stable release.

The current setup reuses Niri, Ly, Xwayland, Japanese locale and input,
Fcitx5/Mozc, Japanese fonts, and common desktop utilities.

No Yohaku-specific desktop behavior or custom system-management
application is added at this stage.

## Build the development Live image

On a NixOS or Linux system with Nix flakes enabled:

```sh
nix flake lock
nix flake check --no-build
nix build --cores 2 --max-jobs 1 .#iso -L
```

The build uses two cores for each derivation to avoid letting the ISO
SquashFS compression saturate the machine. The development Live image
uses Zstandard compression level 3 for faster builds; the ISO may be
larger than one built with the NixOS default compression level.

The ISO is produced under `result/iso/`.

The initial configuration targets `x86_64-linux` and follows
`nixos-unstable`. The generated `flake.lock` pins the exact inputs used
for a build.

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

- `flake.nix` — NixOS configuration and development ISO output.
- `nixos/modules/` — shared NixOS modules.
- `nixos/iso/` — development Live image configuration.
- `nixos/profiles/` — optional configuration profiles.
- `docs/` — architecture and development notes.

## Personal machine settings intentionally excluded

Machine-specific hardware files, disk UUIDs, personal user accounts,
and personal host names are not copied. Personal applications and
developer tools are also kept out of the default desktop setup.

See [docs/architecture.md](docs/architecture.md) for the current scope.
