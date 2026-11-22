{ pkgs, ... }:

{
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  services.displayManager.ly.enable = true;
  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # A system-wide starter configuration for new users. Users can override
  # this with ~/.config/niri/config.kdl after installation.
  environment.etc."niri/config.kdl".text = ''
    input {
      keyboard {
        xkb {
          layout "jp"
        }
      }
    }

    spawn-at-startup "waybar"
    spawn-at-startup "mako"

    binds {
      Mod+Return { spawn "foot"; }
      Mod+D { spawn "fuzzel"; }
      Mod+E { spawn "thunar"; }
      Mod+Q { close-window; }
      Mod+Shift+E { quit; }
    }
  '';
}
