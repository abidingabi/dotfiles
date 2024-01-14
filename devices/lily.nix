{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")

    ../services/headscale.nix
    ../services/ssh.nix
    ../services/tailscale.nix
    ../services/web-server.nix

    ../services/rss.nix

    ../services/signal-flags.nix
  ];

  services.tailscale.useRoutingFeatures = "both";

  # needed to be able to be able to nixos-rebuild with a target-host remotely
  # without ssh access to root, see
  # https://github.com/NixOS/nixpkgs/issues/159082#issuecomment-1118968571
  nix.settings.trusted-users = [ "root" "@wheel" ];

  boot.loader.grub.device = "/dev/sda";
  boot.initrd.availableKernelModules =
    [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" ];
  boot.initrd.kernelModules = [ "nvme" ];

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;

  networking = {
    interfaces.enp1s0.ipv6.addresses = [{
      address = "2a01:4ff:f0:bb04::";
      prefixLength = 64;
    }];
    defaultGateway6 = {
      address = "fe80::1";
      interface = "enp1s0";
    };
  };
}
