{ pkgs, ... }:

{
  services.libinput.enable = true;
  services.libinput.mouse.accelProfile = "flat";

  # keyboard options
  services.xserver.xkb.layout = "us,us";
  services.xserver.xkb.variant = "colemak,";
  services.xserver.xkb.options = "grp:shift_caps_toggle";

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
