{ pkgs, inputs, ... }:

{
  imports = [
    # ../services/home/email.nix
    # ../services/home/syncthing.nix

    # ../services/nixos/restic.nix
    # ../services/nixos/tailscale.nix

    ../services/nixos/gui/home/fonts.nix

    # ../applications/home/beets.nix
    ../applications/home/cli-apps.nix
    # ../applications/home/direnv.nix
    ../applications/home/emacs/emacs.nix
    ../applications/home/fish.nix
    ../applications/home/git.nix

    ../applications/home/kitty.nix
  ];

  nix.package = pkgs.lix;
  nix.settings.experimental-features = "nix-command flakes";
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "magnolia";
  networking.computerName = "magnolia";

  users.users.abi = { home = "/Users/abi"; };
  home-manager.users.abi = { home.stateVersion = "25.11"; };

  system.primaryUser = "abi";

  # various system config
  security.pam.services.sudo_local.touchIdAuth = true;

  # dock settings
  system.defaults.dock = {
    autohide = true;
    persistent-apps = [ ];
  };

  # figure out how to configure
  # keyboard layout: colemak/us
  # automatically adjust brightness: off
  # remap caps lock to control
  # control+command to drag windows
  # allow discord to show desktop notifications
  # show bluetooth in menu bar
  # require password after display is turned off: immediately
  # set max battery charge to 80%

  # install graphical tailscale

  # services
  programs.fish.enable = true;

  homebrew = {
    enable = true;

    # gui apps
    casks = [ "firefox" "discord" ];
  };
}
