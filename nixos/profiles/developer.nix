{ pkgs, ... }:

{
  # Optional development tools. This profile is intentionally not imported
  # by the default desktop image; it can be enabled in a developer edition.
  virtualisation.docker.enable = true;

  programs.nix-ld.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    python3
    gcc
    gnumake
    curl
    mise
  ];
}
