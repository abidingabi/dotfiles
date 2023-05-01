{ config, lib, pkgs, ... }:

{
  options.dogbuilt.services.gui = {
    laptopFeatures.enable = lib.mkEnableOption "laptop features";
  };

  imports = [ ./fonts.nix ./i3.nix ./input-devices.nix ./redshift.nix ];

  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.lightdm.enable = true;

    # sound configuration
    sound.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
