{ pkgs, pkgs-unstable, ... }:

{
  programs.dconf.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  home-manager.users.abi = {
    home.packages = with pkgs; [
      # GUI applications
      audacity
      discord
      pkgs-unstable.firefox

      gimp
      jetbrains.idea-community
      kitty
      prusa-slicer
      reaper
      ungoogled-chromium
      vital
      xfce.thunar

      # GUI utilities
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
