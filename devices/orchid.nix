{ ... }:

{
  imports = [
    ../services/email.nix
    ../services/gui/gui.nix
    ../services/tailscale.nix
    ../services/wireless-connectivity.nix

    ../applications/cli-apps.nix
    ../applications/emacs/emacs.nix
    ../applications/fish.nix
    ../applications/git.nix

    ../applications/gui-apps.nix
    ../applications/kitty.nix
    ../applications/steam.nix
    ../applications/virtualbox.nix
  ];

  # hardware config
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];

  fileSystems."/" = {
    device = "/dev/sda2";
    fsType = "ext4";
  };

  fileSystems."/home" = {
    device = "/dev/sda5";
    fsType = "ext4";
  };

  boot.loader.grub.device = "/dev/sda";

  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.dpi = 94;
  services.xserver.xrandrHeads = [
    "DP-0"
    {
      "output" = "HDMI-0";
      "monitorConfig" = "DisplaySize 400 300";
    }
  ];
}
