{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

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

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;

  networking.hostName = "abidingabi-laptop"; # Define your hostname.
  networking.interfaces.wlp1s0.useDHCP = true;

  time.timeZone = "America/New_York";

  services.xserver.libinput.enable = true;

  users.extraGroups.vboxusers.members = [ "abidingabi" ];
  virtualisation.virtualbox.host.enable = true;

  # Setup steam
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;
  programs.steam.enable = true;
}
