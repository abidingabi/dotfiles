{ pkgs, ... }:

{
  imports = [
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    # GUI applications
    firefox google-chrome
    discord
    pavucontrol
    xfce.thunar

    # GUI utilities
    flameshot
    rofi
    i3status-rust
    feh
    copyq
    scrcpy
    fzf

    # Games
    minecraft
    multimc

    # Command line utilities
    ripgrep fd
    coreutils
    tree jq trash-cli
    tealdeer
    ffmpeg imagemagick pandoc
    haskellPackages.FractalArt
    zip unzip p7zip
    gitAndTools.gh git-lfs
    ispell
    graphviz
    appimage-run
    xclip xdotool xorg.xwininfo
    units
    inotify-tools

    # Command line fun
    fortune
    cowsay

    # Compilers/programming language stuff
    clang
    gnumake libtool cmake
    gradle openjdk
    python38
    nixfmt
    zig
    nodejs
    texlive.combined.scheme-medium

    # IDEs
    jetbrains.idea-community
    android-studio

    # Fonts
    fira fira-code fira-mono
    montserrat
    overpass
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsGcc;
    extraPackages = (epkgs: [ epkgs.vterm ] );
  };
  services.emacs.enable = true;
  services.emacs.client.enable = true;

  services.dunst.enable = true;
  services.dunst.settings = {
      global = {
          transparency = 10;
          geometry = "700-30+20";

          font = "Monsterrat 12";
      };
  };

  fonts.fontconfig.enable = true;
}
