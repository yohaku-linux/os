{ ... }:

{
  networking.hostName = "yohaku";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tokyo";

  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Preserve the initial NixOS state version when updating nixpkgs.
  system.stateVersion = "26.05";
}
