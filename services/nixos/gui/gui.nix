{
  imports =
    [ ./gnome.nix ./home/fonts.nix ./input-devices.nix ./usb-automount.nix ];

  config = {
    # sound configuration
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # clipboard manager
    home-manager.users.abi = {
      services.copyq = {
        enable = true;
        forceXWayland = false;
      };
    };
  };
}
