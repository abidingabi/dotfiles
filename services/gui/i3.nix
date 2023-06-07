{ config, lib, pkgs, ... }:

{
  imports = [ ./dunst.nix ./i3status-rust.nix ./rofi.nix ];

  services.xserver.windowManager.i3 = {
    enable = true;
    configFile = ./i3.conf;
  };

  # compositor to prevent screen tearing
  services.picom = {
    enable = true;
    vSync = true;
  };

  hmModules = [{
    home.packages = with pkgs; [
      copyq
      feh
      flameshot
      i3lock
      xss-lock
    ];
  }];
}
