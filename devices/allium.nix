{ config, lib, pkgs, ... }:

{
  imports = [
    ../services/email.nix
    ../services/gui/gui.nix
    ../services/restic.nix
    ../services/syncthing.nix
    ../services/tailscale.nix
    ../services/wireless-connectivity.nix

    ../applications/beets.nix
    ../applications/cli-apps.nix
    ../applications/direnv.nix
    ../applications/emacs/emacs.nix
    ../applications/fish.nix
    ../applications/git.nix

    ../applications/gui-apps.nix
    ../applications/kitty.nix
    ../applications/steam.nix
    ../applications/virtualbox.nix
  ];

  dogbuilt.services.gui.laptopFeatures.enable = true;

  # hardware config
  hardware.enableRedistributableFirmware = true;

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
  boot.kernelParams =
    [ "boot.shell_on_fail" "i915.force_probe=46a6" "i915.enable_psr=0" ];

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

  swapDevices = [{ device = "/dev/disk/by-label/swap"; }];
  zramSwap.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "balance_performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "power";

      # p-states
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 85;

      # turbo boost
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
    };
  };

  # printing, with autodiscovery
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
