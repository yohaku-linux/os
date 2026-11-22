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

The following command was used for the current Live ISO smoke test:

```sh
ISO="$(find -L result/iso -maxdepth 1 -name '*.iso' -print -quit)"

nix shell nixpkgs#qemu --command \
  qemu-system-x86_64 \
  -m 4096 \
  -smp 4 \
  -device qemu-xhci,id=xhci \
  -device usb-tablet,bus=xhci.0 \
  -device virtio-vga-gl \
  -display gtk,gl=on \
  -nic user,model=virtio-net-pci \
  -cdrom "$ISO" \
  -boot d
```

The USB tablet provides pointer input in the virtual machine. The
user-mode network device provides QEMU's NAT-based network connection.

## Live ISO smoke test

The development Live ISO has been manually tested in QEMU.

Confirmed:

- The Live environment boots into the Niri session.
- Keyboard and mouse input work.
- Fcitx5 with Mozc is available and Japanese input/conversion works.
- Fuzzel can launch Foot.
- Notifications appear and Waybar is displayed.
- Network connectivity works from the guest: ping to `1.1.1.1` succeeds
  and DNS resolution for `github.com` succeeds.

Known observation:

- Waybar displays the network as disconnected in the QEMU environment
  even though the guest can reach the network and resolve hostnames.
  This has not yet been verified on physical hardware, so it is not
  currently treated as a confirmed network configuration defect.

Physical hardware compatibility and installation to a machine have not
yet been tested. In particular, Wi-Fi, audio, Bluetooth, and
hardware-specific graphics behavior still need separate validation.

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
