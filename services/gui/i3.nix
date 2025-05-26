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

  programs.i3lock.enable = true;

  home-manager.users.abi = {
    home.packages = with pkgs; [ copyq feh flameshot xss-lock ];
  };
}
