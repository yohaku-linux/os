{ pkgs, nxc, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  environment.systemPackages = (with pkgs; [
    # Core desktop tools for the Niri session.
    foot
    fuzzel
    waybar
    mako
    thunar

    # Common desktop utilities.
    firefox
    pavucontrol
    networkmanagerapplet
    blueman
    brightnessctl
    playerctl
    grim
    slurp
    wl-clipboard
    xdg-utils
  ]) ++ [
    # NXC CLI and its graphical application manager.
    nxc.packages.${system}.default
    nxc.packages.${system}.nxc-app
  ];
}
