{ pkgs, ... }:

{
  imports = [ ./email.nix ];

  home.stateVersion = "20.09";

  home.packages = with pkgs; [
    # GUI applications
    firefox
    google-chrome
    discord
    pavucontrol
    xfce.thunar
    rpi-imager
    prusa-slicer
    kitty
    gimp
    arandr
    audacity
    calibre

    # GUI utilities
    flameshot
    rofi
    i3status-rust i3lock-fancy-rapid xss-lock
    feh
    copyq
    scrcpy
    peek
    mpv
    piper

    # Games
    minecraft

    # Command line utilities
    coreutils
    ripgrep
    ripgrep-all
    fd
    fzf
    bat
    tree
    jq
    trash-cli
    tealdeer
    ffmpeg
    imagemagick
    pandoc
    haskellPackages.FractalArt
    zip
    unzip
    p7zip
    gitAndTools.gh
    git-lfs
    ispell
    graphviz
    appimage-run
    xclip
    xdotool
    xorg.xwininfo
    units
    inotify-tools
    bc
    whois
    htop
    visidata
    sshuttle

    # Command line fun
    fortune
    cowsay
    bottom-rs

    # Compilers/programming language stuff
    clang
    gnumake
    libtool
    cmake
    gradle
    openjdk
    python3Full python3Packages.poetry
    nixfmt
    zig
    nodejs
    gnuapl

    # LaTeX
    (texlive.combine {
      inherit (texlive)
        scheme-medium
        # These packages are needed for CalcTeX
        mathalpha soul amsmath adjustbox collectbox mathtools cancel

        # These packages are needed for Org Mode PDF exports
        wrapfig capt-of

        stix2-type1;
    })

    # IDEs
    jetbrains.idea-community
    androidStudioPackages.beta

    # Fonts
    fira
    fira-mono
    montserrat
    overpass
    noto-fonts
    noto-fonts-cjk
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-emoji-blob-bin
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacsNativeComp;
    extraPackages = (epkgs: [ epkgs.vterm ]);
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

  services.redshift = {
    enable = true;
    tray = true;

    dawnTime = "6:00-8:00";
    duskTime = "18:00-20:00";

    temperature = {
      day = 4500;
      night = 3700;
    };
  };

  fonts.fontconfig.enable = true;
}
