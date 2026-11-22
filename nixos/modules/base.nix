{ ... }:

{
  networking.hostName = "yohaku";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tokyo";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Keep the default installation free of unfree packages. Proprietary
  # applications can be considered separately after license review.
  nixpkgs.config.allowUnfree = false;

  security.polkit.enable = true;

  # Keep this at the release used for the initial system data layout.
  # Changing the nixpkgs input does not require changing stateVersion.
  system.stateVersion = "26.05";
}
