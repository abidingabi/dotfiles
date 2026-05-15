{ pkgs, pkgs-unstable, ... }:

{
  home-manager.users.abi = {
    home.packages = with pkgs; [
      # GUI applications
      audacity
      discord
      pkgs-unstable.firefox

      # Games
      prismlauncher
    ];
  };
}
