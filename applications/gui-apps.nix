{
  hmModules = [{
    home.packages = with pkgs; [
      # GUI applications
      audacity
      discord
      firefox
      gimp
      google-chrome
      kitty
      pavucontrol
      prusa-slicer
      xfce.thunar

      # GUI utilities
      mpv
    ];
  }];
}
