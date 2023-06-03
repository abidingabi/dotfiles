{ pkgs, ... }:

{
  services.xserver.libinput.enable = true;
  services.xserver.libinput.mouse.accelProfile = "flat";

  # keyboard options
  services.xserver.layout = "us,us";
  services.xserver.xkbVariant = "colemak,";
  services.xserver.xkbOptions = "grp:ctrls_toggle";

  services.keyd = {
    enable = true;
    settings = {
      main = {
        capslock = "overload(control, esc)";
      };
    };
  };
}
