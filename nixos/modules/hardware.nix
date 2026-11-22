{ ... }:

{
  hardware.graphics.enable = true;
  hardware.enableRedistributableFirmware = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.libinput.enable = true;
  services.upower.enable = true;
  powerManagement.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;
}
