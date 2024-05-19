{ pkgs, ... }:

{
  programs.dconf.enable = true;

  home-manager.users.abi = {
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
      prusa-slicer
      xfce.thunar

      # GUI utilities
      appimage-run
      arandr
      mpv
      pavucontrol
      peek

      # Games
      prismlauncher
    ];
  };
}
