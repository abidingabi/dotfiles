{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")

    ../services/nixos/headscale.nix
    ../services/nixos/restic.nix
    ../services/nixos/ssh.nix
    ../services/nixos/tailscale.nix
    ../services/nixos/web-server.nix

    ../services/nixos/minecraft-server.nix
    ../services/nixos/rss.nix

    ../services/home/syncthing.nix

    ../services/nixos/covey-town.nix
    ../services/nixos/signal-flags.nix
    ../services/nixos/pronoun-space.nix
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

  # backup
  services.restic.backups.abidingabi = {
    timerConfig.OnCalendar = "0:00";
    paths = [ "/etc" "/home" "/root" "/var" ];
  };
}
