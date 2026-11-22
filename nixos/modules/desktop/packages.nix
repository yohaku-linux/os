{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    foot
    fuzzel
    waybar
    mako
    wl-mirror
    bibata-cursors
    grim
    slurp
    wl-clipboard
    gpu-screen-recorder
  ];
}
