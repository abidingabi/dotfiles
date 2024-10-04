{ pkgs, ... }:

{
  home-manager.users.abi = {
    home.packages = with pkgs; [
      bat
      bc
      coreutils
      fd
      ffmpeg
      file
      fzf
      git-lfs
      gitAndTools.gh
      graphviz
      htop
      imagemagick
      librsvg
      p7zip
      pandoc
      parallel
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
      gdb
      gnumake
      valgrind

      nixfmt-classic

      fq
      jq

      poetry
      python3

      dig
    ];
    home.file.".digrc".text = "+noall +answer";
  };
}
