{ modulesPath, ... }:

{
  imports = [
    # The base installer profile provides EFI/USB boot support, hardware
    # detection, the live "nixos" account and installation utilities.
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"
  ];

  isoImage.isoName = "yohaku-linux-live.iso";
  isoImage.volumeID = "YOHAKU";
  isoImage.edition = "yohaku";

  system.nixos.distroName = "Yohaku Linux";
  system.nixos.distroId = "yohaku";
  system.nixos.vendorName = "Yohaku Linux Project";
  system.nixos.vendorId = "yohaku";
  system.nixos.variantName = "Yohaku Live";
  system.nixos.variant_id = "live";

  # The live installer account is created by installation-device.nix.
  # Automatic login is only enabled in this live image, never in an
  # installed Yohaku system.
  services.displayManager.defaultSession = "niri";
  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };
}
