{ pkgs, ... }:

{
  hmModules = [{
    home.packages = with pkgs; [
      bat
      bc
      coreutils
      fd
      ffmpeg
      fzf
      git-lfs
      gitAndTools.gh
      htop
      imagemagick
      p7zip
      pandoc
      ripgrep
      ripgrep-all
      tealdeer
      trash-cli
      tree
      units
      unzip
      visidata
      whois
      xclip
      xdotool
      xorg.xwininfo
      zip

      # programming stuff
      gcc
      jq
      gnumake
      nixfmt

      poetry
      python3
    ];
  }];
}
