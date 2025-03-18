{ pkgs, pkgs-unstable, ... }:

{
  programs.dconf.enable = true;

  home-manager.users.abi = {
    home.packages = with pkgs; [
      # GUI applications
      audacity
      discord
      pkgs-unstable.firefox
      gimp
      google-chrome
      jetbrains.idea-community
      kitty
      prusa-slicer
      reaper
      vital
      xfce.thunar

      # GUI utilities
      appimage-run
      arandr
      lollypop
      mpv
      pavucontrol
      peek

      # Games
      prismlauncher
    ];
  };
}
