{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/2195dfb7-4fc5-470a-8221-395eed5392aa";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1374-0984";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/sda5";
      fsType = "ext4";
    };


  swapDevices = [ ];

  boot.loader.grub.device = "/dev/sda";
	
  networking.hostName = "dansman805-desktop"; # Define your hostname.

  time.timeZone = "America/New_York";

  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.dpi = 94;
  services.xserver.xrandrHeads = [
    "DP-0"
    {"output" = "HDMI-0"; "monitorConfig" = "DisplaySize 400 300";}
  ];

  services.printing.drivers = [
    pkgs.gutenprint
    pkgs.gutenprintBin
    pkgs.brlaser
  ];
}
