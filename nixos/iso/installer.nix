{ pkgs, ... }:

let
  yohakuInstall = pkgs.writeShellApplication {
    name = "yohaku-install";
    runtimeInputs = with pkgs; [
      coreutils
      dosfstools
      e2fsprogs
      findutils
      gawk
      gnugrep
      jq
      nixos-install-tools
      parted
      sudo
      systemd
      util-linux
    ];
    text = builtins.readFile ../../scripts/yohaku-install;
  };

  installerDesktop = pkgs.makeDesktopItem {
    name = "yohaku-installer";
    desktopName = "Install Yohaku Linux";
    genericName = "System Installer";
    comment = "Install Yohaku Linux to a disk";
    exec = "foot -e yohaku-install";
    icon = "system-software-install";
    terminal = false;
    categories = [ "System" "Settings" ];
  };
in
{
  environment.systemPackages = [
    yohakuInstall
    installerDesktop
  ];

  # Keep a copy of the shared system modules available to the installer.
  environment.etc."yohaku/modules".source = ../modules;
}
