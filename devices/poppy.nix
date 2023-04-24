{ config, lib, pkgs, modulesPath, ... }:

# To be used with nixos-rebuild build-vm
{
  imports = [
    (modulesPath + "/virtualisation/qemu-vm.nix")

    ../services/gui.nix
    ../services/tailscale.nix
  ];

  system.stateVersion = "22.11";
  hmModules = [{ home.stateVersion = "22.11"; }];

  virtualisation.qemu.options = [ "-vga qxl" ];

  # I like being able to log into my vms
  users.users.abi.password = "password";
}
