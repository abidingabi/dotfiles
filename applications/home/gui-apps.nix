{ pkgs, pkgs-unstable, ... }:

{
  home-manager.users.abi = {
    home.packages = with pkgs; [
      # GUI applications
      audacity
      discord
      pkgs-unstable.firefox
      gimp
      jetbrains.idea-oss
      kitty
      prusa-slicer
      reaper
      recordbox
      ungoogled-chromium
      vital
      xfce.thunar

      # GUI utilities
      gradia
      mpv
      pavucontrol

      # Games
      prismlauncher
    ];
  };
}
