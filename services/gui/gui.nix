{ config, lib, pkgs, ... }:

{
  options.dogbuilt.services.gui = {
    laptopFeatures.enable = lib.mkEnableOption "laptop features";
  };

  imports = [ ./fonts.nix ./i3.nix ./input-devices.nix ];

  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # sound configuration
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # used by lollypop for last.fm scrobbling
    services.gnome.gnome-keyring.enable = true;
  };
}
