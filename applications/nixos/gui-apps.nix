{
  imports = [ ../home/gui-apps.nix ];

  programs.dconf.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
}
