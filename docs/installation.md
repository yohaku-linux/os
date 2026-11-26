# Installing Yohaku Linux

The development Live ISO includes an experimental, guided terminal installer.
It installs the same Niri-based configuration that is used by the Live image.

## Start the installer

1. Boot the Yohaku Linux Live ISO in UEFI mode.
2. Connect to the internet if the machine is not already online.
3. Open **Install Yohaku Linux** from Fuzzel, or open Foot and run:

   ```sh
   yohaku-install
   ```

4. The installer discovers internal, non-removable disks and excludes USB-connected disks.
   - If exactly one eligible disk is found, it is selected automatically.
   - If multiple eligible disks are found, choose one from the numbered list.
5. Check the displayed disk name, model, and capacity. The installer proceeds only
   after the exact disk-erasure confirmation phrase is entered.
6. Enter the new account name.
7. When system installation finishes, set the account password interactively.
8. Remove the installation USB before rebooting.

## Standard disk layout

The initial installer follows the maintainer's existing NixOS layout:

- Architecture: `x86_64-linux`
- Boot mode: UEFI only
- Partition table: GPT
- EFI System Partition: 1 GiB, FAT32
- Root partition: remaining disk space, ext4
- Bootloader: systemd-boot
- Swap: none
- Minimum target disk size: 20 GiB

The entire selected disk is erased and repartitioned. The installer does not
ask the user to create or resize partitions manually.

Removable disks and devices with a USB transport are excluded from automatic
discovery to reduce the chance of selecting the Live installation media.
The disk selection is still a destructive operation, so always verify the
device name, model, and capacity before confirming.

The installer does not yet support preserving existing partitions, dual-boot,
disk encryption, Btrfs, custom partition layouts, swap, or Secure Boot.
Disable Secure Boot in firmware before attempting installation. Do not use
the installer on a disk containing data you need.

## User account and password

The installer asks for a username and declares that user as a normal user in
the installed NixOS configuration. The account belongs to the `wheel` and
`networkmanager` groups.

The password is requested only after `nixos-install` has completed. It is set
inside the target system with `nixos-enter` and `passwd`; it is not written
to the Nix configuration or committed to this repository. The root password
prompt is skipped, so the created user account is used for login and
password-authenticated `sudo`.

## What is written to the installed system

- `/etc/nixos/hardware-configuration.nix` is generated for the target machine.
- The shared Yohaku modules are copied to
  `/etc/nixos/yohaku-modules/`.
- `/etc/nixos/configuration.nix` imports the generated hardware settings and
  the shared Yohaku modules.

This keeps the installed system configurable with the standard NixOS tools,
while keeping machine-specific hardware settings out of the public repository.

## Test the installation in QEMU

Do this test with a separate virtual disk. Never use a physical disk for the
first installation test.

Create a 40 GiB virtual disk and obtain the OVMF UEFI firmware:

```sh
nix shell nixpkgs#qemu --command qemu-img create -f qcow2 yohaku-test-disk.qcow2 40G
OVMF_FD="$(nix build nixpkgs#OVMF.fd --no-link --print-out-paths)/FV/OVMF.fd"
```

Boot the Live ISO with the virtual disk attached:

```sh
ISO="$(find -L result/iso -maxdepth 1 -name '*.iso' -print -quit)"

nix shell nixpkgs#qemu --command \
  qemu-system-x86_64 \
  -bios "$OVMF_FD" \
  -m 4096 \
  -smp 4 \
  -device qemu-xhci,id=xhci \
  -device usb-tablet,bus=xhci.0 \
  -device virtio-vga-gl \
  -display gtk,gl=on \
  -nic user,model=virtio-net-pci \
  -drive file=yohaku-test-disk.qcow2,if=virtio,format=qcow2 \
  -cdrom "$ISO" \
  -boot d
```

In the Live session, launch **Install Yohaku Linux**. Since the VM has one
eligible virtual disk, it should be selected automatically. Verify that the
selected target is the 40 GiB virtual disk before confirming the erase
operation. Complete the install and choose not to reboot from inside the VM.

Then close QEMU and start the VM again with the same virtual disk, but without
the ISO. Keep the OVMF firmware enabled:

```sh
nix shell nixpkgs#qemu --command \
  qemu-system-x86_64 \
  -bios "$OVMF_FD" \
  -m 4096 \
  -smp 4 \
  -device qemu-xhci,id=xhci \
  -device usb-tablet,bus=xhci.0 \
  -device virtio-vga-gl \
  -display gtk,gl=on \
  -nic user,model=virtio-net-pci \
  -drive file=yohaku-test-disk.qcow2,if=virtio,format=qcow2 \
  -boot c
```

Verify that the installed system boots, Ly accepts the account password,
Niri starts, Japanese input works, and `sudo` asks for the user's password.

The installer has been added to the Live image configuration, but a complete
install-to-disk and first-boot test is still required before it should be
considered reliable.
