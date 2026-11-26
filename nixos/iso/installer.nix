{ pkgs, ... }:

let
  yohakuInstall = pkgs.writeShellApplication {
    name = "yohaku-install";
    runtimeInputs = with pkgs; [
      coreutils
      dosfstools
      e2fsprogs
      gawk
      gnugrep
      nixos-install-tools
      parted
      sudo
      systemd
      util-linux
    ];
    text = builtins.readFile ../../scripts/yohaku-install;
  };
in
{
  environment.systemPackages = [ yohakuInstall ];

  # Keep a copy of the shared system modules available to the installer.
  environment.etc."yohaku/modules".source = ../modules;

  environment.etc."xdg/applications/yohaku-installer.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Install Yohaku Linux
    Comment=Install Yohaku Linux to a disk
    Exec=foot -e yohaku-install
    Icon=system-software-install
    Terminal=false
    Categories=System;Settings;
  '';
}
