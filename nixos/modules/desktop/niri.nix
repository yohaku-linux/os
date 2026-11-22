{ ... }:

{
  # Reuse the Niri, Ly, and Xwayland setup from the maintainer's
  # existing NixOS configuration. User-level Niri preferences remain
  # in the user's own ~/.config/niri/config.kdl.
  programs.niri.enable = true;
  services.displayManager.ly.enable = true;
  programs.xwayland.enable = true;

  xdg.portal.enable = true;
}
