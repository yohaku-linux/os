{ pkgs, ... }:

{
  # Optional development profile. This is not imported into the
  # default desktop or Live image.
  virtualisation.docker.enable = true;

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
    supabase-cli
  ];
}
