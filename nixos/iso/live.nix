{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"
  ];

  # This is only a development Live image. Keep the upstream NixOS
  # installer identity and hardware handling until the base configuration
  # has been tested and the distribution branding is designed.

  services.displayManager.defaultSession = "niri";
  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };
}
