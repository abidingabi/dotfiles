# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  boot.kernel.sysctl = { "kernel.sysrq" = 1; };

  nix = {
    autoOptimiseStore = true;
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;
  networking.useDHCP = false;

  # Enable i3wm
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "colemak";
  services.xserver.xkbOptions = "grp:sclk_toggle,grp_led:scroll";

  # Disable mouse acceleration
  services.xserver.libinput.mouse.accelProfile = "flat";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dansman805 = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkManager" ]; # Enable ‘sudo’ for the user.
  };

  programs.fish.enable = true;
  programs.adb.enable = true;

  # System-level packages
  environment.systemPackages = with pkgs; [
    git
    wget
    vim
    gcc
    fish
    rdiff-backup # for backup
    dconf
  ];

  services.interception-tools.enable = true;
  services.picom.enable = true;
  services.earlyoom.enable = true;

  system.stateVersion = "20.09"; # Did you read the comment?
}
