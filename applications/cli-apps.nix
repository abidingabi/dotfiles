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
      jq
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
    ];
  }];
}
