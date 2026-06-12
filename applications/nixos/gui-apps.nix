{ pkgs, ... }:

{
  imports = [ ../home/gui-apps.nix ];

  programs.dconf.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  home-manager.users.abi.home.packages = with pkgs; [
    # GUI applications
    gimp
    jetbrains.idea-oss
    recordbox
    ungoogled-chromium
    reaper
    vital

    # GUI utilities
    gradia
    mpv
    pavucontrol
  ];
}
