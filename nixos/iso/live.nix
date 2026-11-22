{ modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"
  ];

  # This is only a development Live image. Keep the upstream NixOS
  # installer identity and hardware handling until the base configuration
  # has been tested and the distribution branding is designed.

  # The NixOS default uses a high Zstandard compression level. Use a
  # faster level for development builds so SquashFS creation is less CPU
  # intensive. The resulting ISO may be larger.
  isoImage.squashfsCompression = "zstd -Xcompression-level 3";

  services.displayManager.defaultSession = "niri";
  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };
}
