{ pkgs, ... }:

{
  hmModules = [{
    home.packages = with pkgs; [
      # GUI applications
      androidStudioPackages.beta
      audacity
      discord
      firefox
      gimp
      google-chrome
      jetbrains.idea-community
      kitty
      pavucontrol
      prusa-slicer

      # GUI utilities
      appimage-run
      flameshot
      mpv
    ];
  }];
}
