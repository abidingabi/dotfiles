{ pkgs, ... }:

{
  services.xserver.libinput.enable = true;
  services.xserver.libinput.mouse.accelProfile = "flat";

  # keyboard options
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
}
