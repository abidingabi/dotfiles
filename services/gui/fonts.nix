{ pkgs, ... }:

{
  home-manager.users.abi = {
    home.packages = with pkgs; [
      fira-mono
      overpass

      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      noto-fonts-emoji-blob-bin

      emacs-all-the-icons-fonts # used for emacs and i3status-rust
    ];

    fonts.fontconfig.enable = true;
  };
}
