{ config, lib, pkgs, ... }:

{
  options.dogbuilt.services.gui = {
    laptopFeatures.enable = lib.mkEnableOption "laptop features";
  };

  imports = [ ./fonts.nix ./gnome.nix ./input-devices.nix ];

  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;

    # # sound configuration
    # sound.enable = false;
    # security.rtkit.enable = true;
    # services.pipewire = {
    #   enable = true;
    #   alsa.enable = true;
    #   alsa.support32Bit = true;
    #   pulse.enable = true;
    # };
  };
}
