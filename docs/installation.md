# Installing Yohaku Linux

The development Live ISO includes an experimental, guided terminal installer.
It installs the same Niri-based configuration that is used by the Live image.

## Start the installer

1. Boot the Yohaku Linux Live ISO.
2. Connect to the internet if the machine is not already online.
3. Open **Install Yohaku Linux** from Fuzzel, or open Foot and run:

   ```sh
   yohaku-install
   ```

4. Follow the prompts to select the target disk and enter the new account name.
5. Read the disk-erasure warning carefully. The installer proceeds only after
   the exact confirmation phrase is entered.
6. When the system installation finishes, enter a password for the new account.
7. Remove the installation USB before rebooting.

## Initial installer scope

The current installer is intentionally small and destructive, suitable only
for testing on a spare disk or a virtual machine.

- Architecture: `x86_64-linux`
- Boot mode: UEFI or legacy BIOS
- Partition table: GPT
- UEFI layout: 1 GiB EFI System Partition and an ext4 root partition
- BIOS layout: BIOS boot partition and an ext4 root partition
- Root filesystem: ext4
- Minimum target disk size: 20 GiB
- The entire selected disk is erased and repartitioned.

The installer does not yet support preserving existing partitions, dual-boot
installation, disk encryption, Btrfs, custom partition layouts, swap
configuration, or Secure Boot. Secure Boot should be disabled in firmware
before attempting installation. It should not be used on a disk containing
data you need.

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

Create a separate 40 GiB virtual disk:

```sh
nix shell nixpkgs#qemu --command qemu-img create -f qcow2 yohaku-test-disk.qcow2 40G
```

Boot the Live ISO with that virtual disk attached:

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
  -drive file=yohaku-test-disk.qcow2,if=virtio,format=qcow2 \
  -cdrom "$ISO" \
  -boot d
```

In the Live session, launch **Install Yohaku Linux** and choose the virtual
disk shown by the installer (usually `/dev/vda`). The installer will erase
that virtual disk. Complete the install and choose not to reboot from inside
the VM. Then close QEMU and start the VM again with the same virtual disk,
but without the ISO:

```sh
nix shell nixpkgs#qemu --command \
  qemu-system-x86_64 \
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

Do not use a physical disk for the first installation test. A failed or
misconfigured disk selection can erase the selected disk. The installer
has been added to the Live image configuration, but a complete
install-to-disk and first-boot test is still required before it should be
considered reliable.
