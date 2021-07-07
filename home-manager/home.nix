{ pkgs, ... }:

{
  imports = [
    ./email.nix
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    # GUI applications
    firefox google-chrome unstable.nyxt
    discord
    pavucontrol
    xfce.thunar
    rpi-imager
    super-slicer

    # GUI utilities
    flameshot
    rofi
    i3status-rust
    feh
    copyq
    scrcpy
    peek

    # Games
    minecraft
    multimc

    # Command line utilities
    coreutils
    ripgrep ripgrep-all
    fd
    fzf
    bat
    tree
    jq
    trash-cli
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

    # LaTeX
    (texlive.combine { inherit (texlive)
      scheme-medium
    # These packages are needed for CalcTeX
      mathalpha soul amsmath adjustbox collectbox mathtools cancel stix2-type1; })


    # IDEs
    jetbrains.idea-community
    android-studio

    # Fonts
    fira fira-mono
    montserrat
    overpass
    noto-fonts noto-fonts-cjk noto-fonts-extra noto-fonts-emoji noto-fonts-emoji-blob-bin
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtkGcc;
    extraPackages = (epkgs: [ epkgs.vterm ] );
  };
  services.emacs.enable = true;
  services.emacs.client.enable = true;

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  services.dunst.enable = true;
  services.dunst.settings = {
      global = {
          transparency = 10;
          geometry = "700-30+20";
      };
  };

  fonts.fontconfig.enable = true;
}
