{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.libinput.mouse.accelProfile = "flat";

  services.xserver.layout = "us,us";
  services.xserver.xkbVariant = "colemak,";
  services.xserver.xkbOptions = "grp:rctrl_toggle";

  # map CapsLock to Esc on single press and Ctrl on when used with multiple keys.
  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.caps2esc ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
  };

  # sound configuration
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.desktopManager.plasma5.enable = true;

  hmModules = [{

    home.packages = with pkgs; [
      fira-mono
      overpass
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      emacs-all-the-icons-fonts # used for emacs and i3status-rust
    ];

    fonts.fontconfig.enable = true;
  }];
}
