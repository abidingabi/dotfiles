{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    asciidoctor    
    androidenv.androidPkgs_9_0.platform-tools
    arandr
    bazel
    blueman
    bluez
    cabal-install
    calibre
    cargo
    clipmenu
    cloc
    discord
    dos2unix
    dotnet-sdk
    evince
    feh
    firefox
    fish
    flameshot
    fsharp
    gcc
    ghc
    gimp
    gitAndTools.gitFull
    gnumake
    gnupg
    graphviz
    guvcview
    gradle
    htop
    i3
    i3blocks
    imagemagick
    jetbrains.idea-community
    jq
    kakoune
    killall
    kitty
    kotlin
    libreoffice
    lsof
    minicom
    multimc
    neofetch
    nim
    nodejs
    octaveFull
    # openjdk11
    openssl
    pavucontrol
    pciutils
    polybar
    ptask
    python37Full
    python37Packages.pip
    python37Packages.setuptools
    python37Packages.sphinx
    R
    racket
    rdiff_backup
    ripgrep
    rstudio
    rofi
    rustup
    rxvt_unicode
    stack
    stow
    syncthing
    taskwarrior
    tealdeer
    texlive.combined.scheme-full
    texworks
    unifont
    unity3d
    unzip
    vim
    vscodium
    w3m
    wget
    xbanish
    xdotool
    xfce.thunar
    xorg.xrandr
    zip

    (import (fetchTarball "channel:nixos-unstable") {}).android-studio
    (import (fetchTarball "channel:nixos-unstable") {}).jdk12
  ];

  fonts.fonts = with pkgs; [
    fira
    fira-mono
    fira-code
    hermit
    inconsolata
    montserrat
    roboto
    unifont
  ];
}
