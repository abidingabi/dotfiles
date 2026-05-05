{
  imports = [ ./gnome.nix ./fonts.nix ./input-devices.nix ];

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
  };
}
