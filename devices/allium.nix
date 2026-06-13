{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../services/home/email.nix
    ../services/home/syncthing.nix

    ../services/nixos/gui/gui.nix
    ../services/nixos/restic.nix
    ../services/nixos/tailscale.nix
    ../services/nixos/wireless-connectivity.nix

    ../applications/home/beets.nix
    ../applications/home/cli-apps.nix
    ../applications/home/direnv.nix
    ../applications/home/emacs/emacs.nix
    ../applications/nixos/fish.nix
    ../applications/home/git.nix

    ../applications/home/kitty.nix
    ../applications/nixos/gui-apps.nix
    ../applications/nixos/steam.nix
    ../applications/nixos/virtualbox.nix
  ];

  # hardware config
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  }; # Force intel-media-driver

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "sr_mod"
    "rtsx_pci_sdmmc"
    "nvme"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "boot.shell_on_fail"
    "i915.force_probe=46a6"
    "i915.enable_psr=0"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
  };

  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];
  zramSwap.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.thermald.enable = true;

  # printing, with autodiscovery
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # backup paths
  services.restic.backups.abidingabi = {
    paths = [ "/home/abi" ];
    extraBackupArgs = [
      "--exclude=/home/abi/.cache/*"
      "--exclude=/home/abi/Android/*"
    ];
    timerConfig.OnCalendar = "0:00";
  };

  # for CS 331
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  services.gnome.gnome-keyring.enable = true;
}
